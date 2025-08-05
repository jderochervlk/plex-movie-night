open WebAPI

let plexCache = await Deno.Cache.caches.open_("plex-cache")

let handler = Fresh.Handler.make({
  get: async (req, ctx) => {
    let cached = await plexCache.match(req)
    if cached->Nullable.isNullable {
      Console.debug2("Cache miss for", ctx.url.pathname)
      await Utils.authCheck(req, async () => {
        let thumb = URLSearchParams.fromString(ctx.url.search)->URLSearchParams.get("thumb")

        let _ = await Deno.Timers.setTimeout(5000, async _ => {
          // Console.error("ImageMagick operation timed out")
          // let _ = await Promise.thenResolve(42)
          ()
        })

        let image =
          await Plex.Api.getThumb(thumb)
          ->fetch
          ->Promise.then(Response.arrayBuffer)

        await ImageMagick.initialize()

        let format = ref("image/webp")

        let img: Uint8Array.t = {
          let image = Uint8Array.fromBuffer(image)
          let res = ref(image)
          try {
            // If the image conversion takes too long or fails we just return the original image
            let _ = Deno.Timers.setTimeout(200, async _ => {
              let result = await ImageMagick.imageMagick.read(
                image,
                img => {
                  img.write(
                    ImageMagick.magickFormat.webp,
                    image => {
                      Promise.resolve(image)
                    },
                  )
                },
              )
              res := result
            })->Promise.catch(_ => {
              Console.error("ImageMagick operation timed out")
              Promise.resolve()
            })
          } catch {
          | _ => {
              Console.error("Failed to convert image to webp format")
              format := "image/jpeg" // Fallback to JPEG if conversion fails
              res := image
            }
          }
          res.contents
        }

        let headers = Headers.fromKeyValueArray([
          ("Expires", Utils.sixMonthsFromNow()->Date.toDateString),
          format.contents == "image/webp"
            ? ("Cache-Control", "public")
            : ("Cache-Control", "no-Cache"),
          ("Content-Type", format.contents),
        ])

        let res = Response.fromTypedArray(
          img,
          ~init={status: 200, headers: HeadersInit.fromHeaders(headers)},
        )

        // If the image is successfully converted to webp, cache it
        if format.contents == "image/webp" {
          await plexCache.put(req, res->Response.clone)
        }
        res
      })
    } else {
      Console.debug2("Cache hit for", ctx.url.pathname)
      cached->Nullable.getUnsafe
    }
  },
})

open WebAPI

let plexCache = await Deno.Cache.caches.open_("plex-cache")

let handler = Fresh.Handler.make({
  get: async (req, ctx) => {
    let cached = await plexCache.match(req)

    if cached->Nullable.isNullable {
      Console.debug2("Cache miss for", ctx.url.pathname)
      await Utils.authCheck(req, async () => {
        let searchParams = URLSearchParams.fromString(ctx.url.search)
        let thumb = searchParams->URLSearchParams.get("thumb")

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
            // If the image conversion fails we just return the original image
            let result = await ImageMagick.imageMagick.read(image, img => {
              img.write(
                ImageMagick.magickFormat.webp,
                image => {
                  Promise.resolve(image)
                },
              )
            })
            res := result
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
          // ("Content-Length", img.byte),
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

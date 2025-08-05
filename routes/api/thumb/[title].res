open WebAPI

let handler = Fresh.Handler.make({
  get: async (req, ctx) =>
    await Utils.authCheck(req, async () => {
      let thumb = URLSearchParams.fromString(ctx.url.search)->URLSearchParams.get("thumb")

      let image =
        await Plex.Api.getThumb(thumb)
        ->fetch
        ->Promise.then(Response.arrayBuffer)

      await ImageMagick.initialize()

      let img: Uint8Array.t = await ImageMagick.imageMagick.read(
        Uint8Array.fromBuffer(image),
        img => {
          // let _ = img.resize(Plex.imgHeight, Plex.imgWidth)
          img.write(
            ImageMagick.magickFormat.webp,
            image => {
              Promise.resolve(image)
            },
          )
        },
      )

      let headers = Headers.fromKeyValueArray([
        ("Expires", Utils.sixMonthsFromNow()->Date.toDateString),
        ("Cache-Control", "public"),
      ])

      Response.fromTypedArray(img, ~init={status: 200, headers: HeadersInit.fromHeaders(headers)})
    }),
})

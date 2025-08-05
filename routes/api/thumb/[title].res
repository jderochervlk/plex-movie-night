open WebAPI

let handler = Fresh.Handler.make({
  get: async (req, ctx) =>
    await Utils.authCheck(req, async () => {
      let thumb = URLSearchParams.fromString(ctx.url.search)->URLSearchParams.get("thumb")

      let image =
        await Plex.Api.getThumb(thumb)
        ->fetch
        ->Promise.then(Response.arrayBuffer)

      let webpImage = await Deno.toWebp(image)

      let headers = Headers.fromKeyValueArray([
        ("Expires", Utils.sixMonthsFromNow()->Date.toDateString),
        ("Cache-Control", "public"),
      ])

      Response.fromArrayBuffer(
        webpImage,
        ~init={status: 200, headers: HeadersInit.fromHeaders(headers)},
      )
    }),
})

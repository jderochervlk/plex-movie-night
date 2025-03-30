open WebAPI

let handler = Fresh.Handler.make({
  get: async (req, ctx) =>
    await Utils.authCheck(req, async () => {
      let thumb = URLSearchParams.make3(~init=ctx.url.search)->URLSearchParams.get("thumb")

      let image =
        await Plex.Api.getThumb(thumb)
        ->fetch
        ->Promise.then(Response.arrayBuffer)

      let headers = Headers.make(~init=[["Cache-control", "public, max-age=9999999999"]])

      Response.make4(~body=image, ~init={status: 200, headers: HeadersInit.fromHeaders(headers)})
    }),
})

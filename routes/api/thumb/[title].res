open WebAPI

let plexCache = await Deno.Cache.caches.open_("plex-cache")

let handler = Fresh.Handler.make({
  get: async (req, ctx) => {
    let cached = await plexCache.match(req)

    if cached->Nullable.isNullable {
      Console.debug2("Cache miss for", ctx.url.pathname)

      let searchParams = URLSearchParams.fromString(ctx.url.search)
      let thumb = searchParams->URLSearchParams.get("thumb")

      let image =
        await Plex.Api.getThumb(thumb)
        ->fetch
        ->Promise.then(Response.arrayBuffer)

      let headers = Headers.fromKeyValueArray([
        ("Expires", Utils.sixMonthsFromNow()->Date.toDateString),
        ("Cache-Control", "public"),
      ])

      let res = Response.fromArrayBuffer(
        image,
        ~init={status: 200, headers: HeadersInit.fromHeaders(headers)},
      )

      let _ = await plexCache.put(req, res->Response.clone)

      res
    } else {
      Console.debug2("Cache hit for", ctx.url.pathname)
      cached->Nullable.getUnsafe
    }
  },
})

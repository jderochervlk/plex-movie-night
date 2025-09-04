open WebAPI
type data

@live
let handler = Fresh.Handler.make({
  post: async (req, _ctx) => {
    if await Utils.doesPasswordMatch(req) {
      let headers = Headers.make()
      headers->Headers.set(~name="location", ~value=Utils.getRootUrl(req.url))
      headers->Std.Http.Cookies.set({
        name: "auth",
        value: Env.token(),
        expires: Utils.sixMonthsFromNow(),
        sameSite: "Lax",
        domain: req->Utils.getHostname,
        path: "/",
        secure: true,
      })

      let headers = HeadersInit.fromHeaders(headers)

      Response.fromNull(~init={status: 303, headers})
    } else {
      let headers = Headers.make()
      headers->Headers.set(~name="location", ~value="/")
      headers->Std.Http.Cookies.set({
        name: "error",
        value: "wrong-password",
        maxAge: 10000,
        sameSite: "Lax",
        domain: req->Utils.getHostname,
        path: "/",
        secure: true,
      })
      let headers = HeadersInit.fromHeaders(headers)
      Response.fromNull(~init={status: 302, headers})
    }
  },
})

open WebAPI
type data = {isAllowed: bool}

let handler: Fresh.Handler.t<unknown, unknown, unknown> = {
  post: async (req, _ctx) => {
    if await Utils.doesPasswordMatch(req) {
      let headers = Headers.make()
      headers->Headers.set(~name="location", ~value="/")
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

      Response.make2(~init={status: 303, headers})
    } else {
      Response.make2(~init={status: 403})
    }
  },
}

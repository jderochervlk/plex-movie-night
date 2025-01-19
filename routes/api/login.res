open WebAPI
type data = {isAllowed: bool}

let sixMonthsFromNow = () => {
  let now = Date.now()->Date.fromTime
  now->Date.setMonth(now->Date.getMonth + 6)
  now
}

/** Takes in the request and checks that the password matches the env variable */
let doesPasswordMatch = async req => {
  let form = await req->Request.formData

  let password = form->FormData.get2("password")

  password == Env.password()
}

let hasNameSet = async (req: FetchAPI.request) => {
  let cookies = Std.Http.Cookies.get(req.headers)
  switch cookies->Dict.get("name") {
  | Some(name) => Env.names()->Array.includes(name)
  | None => false
  }
}

let isAuthenticated = async (req: FetchAPI.request) => {
  let cookies = Std.Http.Cookies.get(req.headers)
  switch cookies->Dict.get("auth") {
  | Some(isAllowed) => isAllowed == Env.token()
  | None => false
  }
}

let handler: Fresh.Handler.t<unknown, unknown, unknown> = {
  post: async (req, _ctx) => {
    if await doesPasswordMatch(req) {
      let headers = Headers.make()
      headers->Headers.set(~name="location", ~value="/")
      headers->Std.Http.Cookies.set({
        name: "auth",
        value: Env.token(),
        expires: sixMonthsFromNow(),
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

let authCheck = async req => {
  switch (await isAuthenticated(req), await hasNameSet(req)) {
  | (true, true) => None
  | (false, _) => Some(() => Response.redirect(~url=`${req.url}signin`))
  | (true, false) => Some(() => Response.redirect(~url=`${req.url}setname`))
  }
}

open WebAPI

let getHostname = _req => %raw(`_req.url.hostname`)

module FormData = {
  type t

  @new
  external make: {..} => t = "FormData"

  @send
  external get: (t, string) => string = "get"
}

let sixMonthsFromNow = () => {
  let now = Date.now()->Date.fromTime
  now->Date.setMonth(now->Date.getMonth + 6)
  now
}

/** Takes in the request and checks that the password matches the env variable */
let doesPasswordMatch = async req => {
  let form = await req->Request.formData

  let password = form->WebAPI.FormData.get2("password")

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

let authCheck = async (req, fn) => {
  switch (await isAuthenticated(req), await hasNameSet(req)) {
  | (true, true) => await fn()
  | (false, _) => Response.redirect(~url=`${req.url}/signin`)
  | (true, false) => Response.redirect(~url=`${req.url}/setname`)
  }
}

let getRootUrl = (url: string) => {
  let prefix = url->String.includes("http://") ? "http://" : "https://"
  url
  ->String.replace("http://", "")
  ->String.replace("https://", "")
  ->String.split("/")
  ->Array.at(0)
  ->Option.map(url => prefix ++ url)
  ->Option.getOr("/")
}

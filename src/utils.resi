let getHostname: 'a => 'b
let getRootUrl: string => string
module FormData: {
  type t
  @new
  external make: {..} => t = "FormData"
  @send
  external get: (t, string) => string = "get"
}
let sixMonthsFromNow: unit => Date.t
let doesPasswordMatch: WebAPI.FetchAPI.request => promise<bool>
let hasNameSet: WebAPI.FetchAPI.request => promise<bool>
let isAuthenticated: WebAPI.FetchAPI.request => promise<bool>
let authCheck: (
  WebAPI.FetchAPI.request,
  unit => promise<WebAPI.FetchAPI.response>,
) => promise<WebAPI.FetchAPI.response>
@send @scope("headers")
external append: (WebAPI.FetchAPI.response, string, string) => unit = "append"

open WebAPI

module Http = {
  module Cookies = {
    type t

    @module("jsr:@std/http/cookie")
    external get: FetchAPI.headers => Dict.t<string> = "getCookies"

    type cookieInit = {
      name: string,
      value: string,
      maxAge?: int,
      expires?: Date.t,
      sameSite: string,
      domain: string,
      path: string,
      secure: bool,
    }

    @module("jsr:@std/http/cookie")
    external set: (FetchAPI.headers, cookieInit) => unit = "setCookie"
  }
}

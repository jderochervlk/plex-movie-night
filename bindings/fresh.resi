@module("$fresh/runtime.ts")
external is_browser: bool = "IS_BROWSER"
module Head: {
  @module("$fresh/runtime.ts") @jsx.component
  external make: (~children: Jsx.element) => Jsx.element = "Head"
}
module Partial: {
  @module("$fresh/runtime.ts") @jsx.component
  external make: (~children: Jsx.element, ~name: string) => Jsx.element = "Partial"
}
module URL: {
  type t = {
    href: string,
    origin: string,
    protocol: string,
    username: string,
    password: string,
    host: string,
    hostname: string,
    port: string,
    pathname: string,
    hash: string,
    search: string,
  }
}
module Router: {
  type destinationKind =
    | @as("internal") Internal
    | @as("static") Static
    | @as("route") Route
    | @as("notFound") NotFound
}
module ResolvedConfig: {
  type t
}
module Context: {
  type renderOptions = WebAPI.FetchAPI.responseInit
  type t<'a> = {
    url: URL.t,
    basePath: string,
    route: string,
    destination: Router.destinationKind,
    params: Dict.t<string>,
    isPartial: bool,
    state: Dict.t<unknown>,
    data: unknown,
    error?: unknown,
    codeFrame?: unknown,
    renderNotFound: option<unknown> => promise<WebAPI.FetchAPI.response>,
    render: (~data: 'a=?, ~options: renderOptions=?) => WebAPI.FetchAPI.response,
    @as("Component")
    component: Preact.component<unknown>,
    next: unit => promise<WebAPI.FetchAPI.response>,
  }
}
module Handler: {
  type route<'a> = (WebAPI.FetchAPI.request, Context.t<'a>) => promise<WebAPI.FetchAPI.response>
  type t<'a> = {
    @as("GET")
    get?: route<'a>,
    @as("HEAD")
    head?: route<'a>,
    @as("POST")
    post?: route<'a>,
    @as("PUT")
    put?: route<'a>,
    @as("DELETE")
    delete?: route<'a>,
    @as("OPTIONS")
    options?: route<'a>,
    @as("PATCH")
    patch?: route<'a>,
  }
  external make: t<'t> => t<'t> = "%identity"
}

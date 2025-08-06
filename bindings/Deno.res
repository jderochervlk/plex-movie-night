module Kv = {
  type t

  type commitResult

  type entry = {value: Null.t<array<string>>}

  @scope("Deno")
  external openKv: unit => promise<t> = "openKv"

  @send
  external set: (t, array<string>, array<string>) => promise<commitResult> = "set"

  @send
  external get: (t, array<string>) => promise<entry> = "get"
}

@module("jsr:@epi/image-to-webp")
external toWebp: ArrayBuffer.t => promise<ArrayBuffer.t> = "default"

module Cache = {
  type cache = {
    match: WebAPI.FetchAPI.request => promise<Nullable.t<WebAPI.FetchAPI.response>>,
    put: (WebAPI.FetchAPI.request, WebAPI.FetchAPI.response) => promise<unit>,
  }
  type caches = {@as("open") open_: string => promise<cache>}

  external caches: caches = "caches"
}

module Timers = {
  @module("node:timers/promises")
  external setTimeout: (int, (unit => unit) => promise<unit>) => promise<unit> = "setTimeout"
}

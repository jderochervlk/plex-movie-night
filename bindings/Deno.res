module Kv = {
    type t
    type commitResult
    type entry


    @scope("Deno")
    external openKv: () => promise<t> = "openKv"

    @send
    external set: (t, array<string>, string)=> promise<commitResult> = "get"

    @send
    external get: (t, array<string>)=> promise<entry> = "get"
}
module Kv = {
    type t

    type commitResult

    type entry ={
        key: array<string>,
        value: Null.t<array<string>>
    }


    @scope("Deno")
    external openKv: () => promise<t> = "openKv"

    @send
    external set: (t, array<string>, array<string>)=> promise<commitResult> = "get"

    @send
    external get: (t, array<string>)=> promise<entry> = "get"
}
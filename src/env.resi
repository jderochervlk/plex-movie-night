external set: (string, string) => unit = "Deno.env.set"
external get: string => option<string> = "Deno.env.get"
let password: unit => string
let token: unit => string
let plexToken: unit => string
let plexServer: unit => string
let names: unit => array<string>

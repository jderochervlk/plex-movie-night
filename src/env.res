external set: (string, string) => unit = "Deno.env.set"
external get: string => option<string> = "Deno.env.get"

let password = () => get("PASSWORD")->Option.getOrThrow(~message="PASSWORD not set")
let token = () => get("TOKEN")->Option.getOrThrow(~message="TOKEN not set")
let plexToken = () => get("PLEX_TOKEN")->Option.getOrThrow(~message="PELX_TOKEN not set")
let plexServer = () => get("PLEX_SERVER")->Option.getOrThrow(~message="PLEX_SERVER not set")
let names = () => get("NAMES")->Option.getOrThrow(~message="NAMES not set")->String.split(",")

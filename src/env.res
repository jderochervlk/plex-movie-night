external set: (string, string) => unit = "Deno.env.set"
external get: string => option<string> = "Deno.env.get"

let password = get("PASSWORD")->Option.getExn(~message="PASSWORD not set")
let token = get("TOKEN")->Option.getExn(~message="TOKEN not set")
let plexToken = get("PLEX_TOKEN")->Option.getExn(~message="PELX_TOKEN not set")
let plexServer = get("PLEX_SERVER")->Option.getExn(~message="PLEX_SERVER not set")
let names = get("NAMES")->Option.getExn(~message="NAMES not set")->String.split(",")

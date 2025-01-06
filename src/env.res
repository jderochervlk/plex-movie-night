external set: (string, string) => unit = "Deno.env.set"
external get: string => string = "Deno.env.get"

let password = get("PASSWORD")
let token = get("TOKEN")
let plexToken = get("PLEX_TOKEN")
let plexServer = get("PLEX_SERVER")

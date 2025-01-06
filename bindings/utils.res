let getHostname = _req => %raw(`_req.url.hostname`)

module FormData = {
  type t

  @new
  external make: {..} => t = "FormData"

  @send
  external get: (t, string) => string = "get"
}

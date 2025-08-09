open WebAPI

let handler = Fresh.Handler.make({
  get: async (req, ctx) => {
    let isAllowed = await Utils.isAuthenticated(req)
    let rootUrl = Utils.getRootUrl(req.url)

    switch isAllowed {
    | true => Response.redirect(~url=rootUrl)
    | false => {
        let data =
          Std.Http.Cookies.get(req.headers)
          ->Dict.get("error")
          ->Option.getOr("")

        ctx.render(~data)
      }
    }
  },
})

@jsx.component
let make = (~data) => {
  <LoginForm error=data />
}

let default = make

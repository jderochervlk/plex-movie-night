open WebAPI

let handler = Fresh.Handler.make({
  get: async (req, ctx) => {
    let isAllowed = await Utils.isAuthenticated(req)
   

    switch isAllowed {
    | true => Response.redirect(~url="/")
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
  <div>
    <LoginForm error=data />
  </div>
}

let default = make

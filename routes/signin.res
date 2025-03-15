open WebAPI

let handler: Fresh.Handler.t<unknown, unknown, unknown> = {
  get: async (req, ctx) => {
    let isAllowed = await Utils.isAuthenticated(req)
    switch isAllowed {
    | true => Response.redirect(~url="/")
    | false => ctx.render(None, None)
    }
  },
}

@jsx.component
let make = () => {
  <div>
    <LoginForm />
  </div>
}

let default = make

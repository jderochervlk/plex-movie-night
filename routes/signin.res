open WebAPI

let handler = Fresh.Handler.make({
  get: async (req, ctx) => {
    let isAllowed = await Utils.isAuthenticated(req)
    switch isAllowed {
    | true => Response.redirect(~url="/")
    | false => ctx.render()
    }
  },
})

@jsx.component
let make = () => {
  <div>
    <LoginForm />
  </div>
}

let default = make

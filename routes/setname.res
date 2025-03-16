open WebAPI

@live
let handler: Fresh.Handler.t<unknown, unknown, unknown> = {
  get: async (req, ctx) => {
    let hasName = await Utils.hasNameSet(req)
    switch hasName {
    | true => Response.redirect(~url="/")
    | false => ctx.render(None, None)
    }
  },
}

@jsx.component
let make = () => {
  <div>
    <NameForm />
  </div>
}
@live
let default = make

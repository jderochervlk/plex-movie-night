open WebAPI

let handler = Fresh.Handler.make({
  get: async (req, ctx) => {
    let hasName = await Utils.hasNameSet(req)
    let rootUrl = Utils.getRootUrl(req.url)
    switch hasName {
    | true => Response.redirect(~url=rootUrl)
    | false => ctx.render()
    }
  },
})

@jsx.component
let make = () => {
  <div>
    <NameForm />
  </div>
}

let default = make

open WebAPI

type data = {users: array<string>, active: array<string>}

let handler = Fresh.Handler.make({
  get: async (req, ctx) =>
    await Utils.authCheck(req, async () => {
      let users = Env.names()
      let active = await User.getActiveUsers()
      ctx.render(~data={users, active})
    }),
  post: async (req, ctx) => {
    await Utils.authCheck(req, async () => {
      let users = Env.names()
      let form = await req->Request.formData

      let active = users->Array.filter(name => {
        let isActive = form->FormData.get(name)
        isActive == "on"
      })

      let _ = await User.setActiveUsers(active)

      Console.log(form)

      // console.lo
      // let active = await User.getActiveUsers()

      ctx.render(~data={users, active})
    })
  },
})

@jsx.component
let make = (~data: data) =>
  <section class="configure">
    <form fClientNav=false method="post" action="/configure" class="form-card">
      <fieldset>
        <legend> {Preact.string("Viewers")} </legend>
        <Fresh.Partial name="active-users">
          {data.users
          ->Array.map(name => {
            let isActive = data.active->Array.includes(name)
            <>
              <label>
                <input name type_="checkbox" defaultChecked=isActive />
                {Preact.string(name)}
              </label>
            </>
          })
          ->Preact.array}
        </Fresh.Partial>
      </fieldset>
      <button class="form-button" type_="submit"> {Preact.string("update viewers")} </button>
    </form>
  </section>

let default = make

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
  <section class="mx-auto max-w-lg">
    <form
      fClientNav=false
      method="post"
      action="/configure"
      class="card m-auto bg-neutral text-primary-content px-10 pt-5 pb-10 mt-3 shadow-lg min-w-sm">
      <fieldset class="fieldset bg-base-100 border-base-300 rounded-box w-full border p-4 mb-6">
        <legend class="fieldset-legend"> {Preact.string("Viewers")} </legend>
        <Fresh.Partial name="active-users">
          {data.users
          ->Array.map(name => {
            let isActive = data.active->Array.includes(name)
            <>
              <label class="label text-lg">
                <input name type_="checkbox" defaultChecked=isActive class="checkbox" />
                {Preact.string(name)}
              </label>
            </>
          })
          ->Preact.array}
        </Fresh.Partial>
      </fieldset>
      <button class="btn btn-secondary w-full" type_="submit">
        {Preact.string("update viewers")}
      </button>
    </form>
  </section>

let default = make

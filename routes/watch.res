type data = {users: array<Db__edgeql.SelectAllUsers.response>, votes: Dict.t<int>}

let handler: Fresh.Handler.t<unknown, data, unknown> = {
  get: async (req, ctx) =>
    await Utils.authCheck(req, async () => {
      let users = await User.getAllUsers()
      ctx.render(~data={users, votes: Dict.make()})
    }),
}

@jsx.component
let make = (~data: data) =>
  <section>
    <P> "Watch now!" </P>
    {JSON.stringifyAny(data.users, ~space=2)->Option.getOr("")->Preact.string}
  </section>

let default = make

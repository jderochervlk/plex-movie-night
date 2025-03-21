type data = {users: array<Db__edgeql.SelectAllUsers.response>, votes: Dict.t<int>}

let handler: Fresh.Handler.t<unknown, data, unknown> = {
  get: async (req, ctx) => {
    switch await Utils.authCheck(req) {
    | Some(fn) => fn()
    | None => {
        let users = await User.getAllUsers()
        ctx.render(
          ~data={users, votes: Dict.make()},
          //   switch await Plex.Api.getRecent() {
          //   | None => None
          //   },
        )
      }
    }
  },
}

@jsx.component
let make = (~data: data) =>
  <section>
    <P> "Watch now!" </P>
    {JSON.stringifyAny(data.users, ~space=2)->Option.getOr("")->Preact.string}
  </section>

let default = make

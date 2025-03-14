type data = {recentlyAdded: Plex.MediaContainer.t}

let handler: Fresh.Handler.t<unknown, data, unknown> = {
  get: async (req, ctx) => {
    let client = Db.client
    let res = await client->Db.addMovieToUser({ratingKey: "another one"})
    Console.log(res)
    switch await Login.authCheck(req) {
    | Some(fn) => fn()
    | None =>
      ctx.render(
        Some({
          recentlyAdded: await Plex.getRecent(),
        }),
        None,
      )
    }
  },
}

@jsx.component
let make = (~data: data) => {
  <Movies media=data.recentlyAdded.mediaContainer.metadata />
}

let default = make

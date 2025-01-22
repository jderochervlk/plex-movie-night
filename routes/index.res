type data = {recentlyAdded: Plex.MediaContainer.t}

let handler: Fresh.Handler.t<unknown, data, unknown> = {
  get: async (req, ctx) => {
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

type data = {recentlyAdded: Plex.MediaContainer.t}

let handler: Fresh.Handler.t<unknown, data, unknown> = {
  get: async (req, ctx) => {
    switch await Utils.authCheck(req) {
    | Some(fn) => fn()
    | None =>
      ctx.render(
        switch await Plex.getRecent() {
        | Some(recentlyAdded) => Some({recentlyAdded: recentlyAdded})
        | None => None
        },
        None,
      )
    }
  },
}

@jsx.component
let make = (~data: option<data>) =>
  switch data {
  | Some(data) => <Movies media=data.recentlyAdded.mediaContainer.metadata />
  | None =>
    <div className="w-full text-xl p-5 text-center">
      {Preact.string("Something went wrong connecting to Plex.")}
    </div>
  }

let default = make

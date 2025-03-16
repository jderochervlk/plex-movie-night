type data = {recentlyAdded: Plex.MediaContainer.t, moviesToWatch: array<string>}

let handler: Fresh.Handler.t<unknown, data, unknown> = {
  get: async (req, ctx) => {
    switch await Utils.authCheck(req) {
    | Some(fn) => fn()
    | None => {
        let user = User.getCurrentUser(req)
        let moviesToWatch =
          await User.getMovies(~name=user)->Promise.thenResolve(movies => movies->Set.toArray)
        ctx.render(
          switch await Plex.getRecent() {
          | Some(recentlyAdded) => Some({recentlyAdded, moviesToWatch})
          | None => None
          },
          None,
        )
      }
    }
  },
}

@jsx.component
let make = (~data: option<data>) =>
  switch data {
  | Some(data) =>
    <>
      <p> {Preact.string("search")} </p>
      <Movies media=data.recentlyAdded.mediaContainer.metadata wantToWatch=data.moviesToWatch />
    </>
  | None =>
    <div className="w-full text-xl p-5 text-center">
      {Preact.string("Something went wrong connecting to Plex.")}
    </div>
  }

let default = make

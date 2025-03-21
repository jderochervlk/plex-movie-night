type data = {recentlyAdded: array<Plex.Movie.t>, moviesToWatch: array<string>}

let handler = Fresh.Handler.make({
  get: async (req, ctx) =>
    await Utils.authCheck(req, async () => {
      let user = User.getCurrentUser(req)
      let moviesToWatch =
        await User.getMovies(~name=user)->Promise.thenResolve(movies => movies->Set.toArray)

      ctx.render(
        ~data=switch await Plex.Api.getRecent() {
        | Some(recentlyAdded) => Some({recentlyAdded, moviesToWatch})
        | None => None
        },
      )
    }),
})

@jsx.component
let make = (~data: option<data>) => {
  switch data {
  | Some(data) =>
    <Movies
      movies=data.recentlyAdded wantToWatch=data.moviesToWatch heading="Recently Added" redirect="/"
    />

  | None =>
    <div className="w-full text-xl p-5 text-center">
      {Preact.string("Something went wrong connecting to Plex.")}
    </div>
  }
}

let default = make

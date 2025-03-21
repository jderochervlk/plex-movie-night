open WebAPI

type data = {recentlyAdded: array<Plex.Movie.t>, moviesToWatch: array<string>}

let handler: Fresh.Handler.t<unknown, option<data>, unknown> = {
  get: async (req, ctx) => {
    switch await Utils.authCheck(req) {
    | Some(fn) => fn()
    | None => {
        let user = User.getCurrentUser(req)
        let moviesToWatch =
          await User.getMovies(~name=user)->Promise.thenResolve(movies => movies->Set.toArray)
        let response = ctx.render(
          ~data=switch await Plex.Api.getRecent() {
          | Some(recentlyAdded) => Some({recentlyAdded, moviesToWatch})
          | None => None
          },
        )

        response.headers->Headers.set(~name="x-foo", ~value="bar")

        response
      }
    }
  },
}

@jsx.component
let make = (~data: option<data>) =>
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

let default = make

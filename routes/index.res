type data = {
  recentlyAdded: array<Plex.Movie.t>,
  newest: array<Plex.Movie.t>,
  moviesToWatch: array<string>,
  eighties: array<Plex.Movie.t>,
}

let handler = Fresh.Handler.make({
  get: async (req, ctx) =>
    await Utils.authCheck(req, async () => {
      let _ = await User.createAllUsers()

      let user = User.getCurrentUser(req)
      let moviesToWatch =
        await User.getMovies(~name=user)->Promise.thenResolve(movies => movies->Set.toArray)

      let (newest, recentlyAdded, eighties) = switch await Promise.all([
        Plex.Api.getNewest()->Promise.thenResolve(Option.getOr(_, [])),
        Plex.Api.getRecent()->Promise.thenResolve(Option.getOr(_, [])),
        Plex.Api.getByDecade("1980")->Promise.thenResolve(Option.getOr(_, [])),
      ]) {
      | [newest, recentlyAdded, eighties] => (newest, recentlyAdded, eighties)
      | _ => ([], [], [])
      }

      ctx.render(~data=Some({recentlyAdded, moviesToWatch, newest, eighties}))
    }),
})

module Scroll = {
  @jsx.component @module("../islands/Scroll.tsx")
  external make: unit => Preact.element = "Scroll"
}

@jsx.component
let make = (~data: option<data>) =>
  switch data {
  | Some(data) =>
    <>
      <Scroll />
      <Movies
        movies=data.newest
        wantToWatch=data.moviesToWatch
        heading="Recently Released"
        redirect="/"
        aboveTheFold=true
      />
      <Movies
        movies=data.recentlyAdded
        wantToWatch=data.moviesToWatch
        heading="Recently Added"
        redirect="/"
      />
      <Movies
        movies=data.eighties wantToWatch=data.moviesToWatch heading="Best of the 80s" redirect="/"
      />
    </>
  | None =>
    <div className="w-full text-xl p-5 text-center">
      {Preact.string("Something went wrong connecting to Plex.")}
    </div>
  }

let default = make

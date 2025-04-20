type data = {
  moviesToWatch: array<string>,
  movies: array<Plex.Movie.t>,
  decade: string,
}

let handler = Fresh.Handler.make({
  get: async (req, ctx) =>
    await Utils.authCheck(req, async () => {
      let user = User.getCurrentUser(req)

      let moviesToWatch =
        await User.getMovies(~name=user)->Promise.thenResolve(movies => movies->Set.toArray)

      let decade = ctx.params->Dict.get("year")->Option.getOr("2000")

      let movies =
        await Plex.Api.getByDecade(decade, ~audienceRating=8.0)->Promise.thenResolve(
          Option.getOr(_, []),
        )

      ctx.render(~data=Some({movies, moviesToWatch, decade: `${decade}s`}))
    }),
})

@jsx.component
let make = (~data: option<data>) =>
  switch data {
  | Some(data) =>
    <>
      <Movies movies=data.movies wantToWatch=data.moviesToWatch heading=data.decade redirect="/" />
    </>
  | None =>
    <div className="w-full text-xl p-5 text-center">
      {Preact.string("Something went wrong connecting to Plex.")}
    </div>
  }

let default = make

type data = {votes: Dict.t<array<string>>, movies: array<Plex.Movie.t>}

let handler = Fresh.Handler.make({
  get: async (req, ctx) =>
    await Utils.authCheck(req, async () => {
      let votes: Dict.t<array<string>> = Dict.make()

      await User.getAllUsers()->Promise.thenResolve(
        Array.forEach(_, user => {
          let name = user.name
          let movies = user.movies
          movies->Array.forEach(
            ratingKey => {
              let existing = votes->Dict.get(ratingKey)->Option.getOr([])
              votes->Dict.set(ratingKey, existing->Array.concat([name]))
            },
          )
          ()
        }),
      )

      votes->Dict.forEachWithKey((value, key) => {
        switch value->Array.length > 1 {
        | true => ()
        | false => votes->Dict.delete(key)->ignore
        }
      })

      let moviesWeWantToWatch = votes->Dict.keysToArray

      let movies: array<Plex.Movie.t> = {
        let movies = await Promise.all(
          moviesWeWantToWatch->Array.map(req => Plex.Api.getMovie(req)),
        )
        let temp: array<Plex.Movie.t> = []
        movies->Array.forEach(movie => movie->Option.forEach(movie => temp->Array.push(movie)))
        temp
      }

      ctx.render(~data={votes, movies})
    }),
})

@jsx.component
let make = (~data: data) =>
  <section>
    <Movies
      movies={data.movies}
      redirect="/watch"
      wantToWatch=[]
      heading="At least two of you want to watch these movies!"
    />
  </section>

let default = make

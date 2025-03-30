type data = {votes: Dict.t<array<string>>, movies: array<Plex.Movie.t>}

let handler = Fresh.Handler.make({
  get: async (req, ctx) =>
    await Utils.authCheck(req, async () => {
      let users = await User.getAllUsers()

      let votes: Map.t<string, int> = Map.make()

      users->Array.forEach(user => {
        let movies = user.movies->Null.getOr([])
        movies->Array.forEach(
          ratingKey => {
            let count = votes->Map.get(ratingKey)->Option.getOr(0)
            votes->Map.set(ratingKey, count + 1)
          },
        )
        ()
      })

      let votes: Map.t<string, array<string>> = Map.make()

      users->Array.forEach(user => {
        let name = user.name
        let movies = user.movies->Null.getOr([])
        movies->Array.forEach(
          ratingKey => {
            let existing = votes->Map.get(ratingKey)->Option.getOr([])
            votes->Map.set(ratingKey, existing->Array.concat([name]))
          },
        )
        ()
      })

      votes->Map.forEachWithKey((value, key) => {
        switch value->Array.length > 1 {
        | true => ()
        | false => votes->Map.delete(key)->ignore
        }
      })

      let votes = votes->Utils.fromEntries

      let moviesWeWantToWatch = votes->Dict.keysToArray

      let requests = moviesWeWantToWatch->Array.map(req => Plex.Api.getMovie(req))

      let movies: array<Plex.Movie.t> = {
        let movies = await Promise.all(requests)
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
      heading="At least of you want to watch these movies!"
    />
  </section>

let default = make

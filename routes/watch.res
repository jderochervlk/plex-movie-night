type data = {votes: Dict.t<array<string>>, movies: array<Plex.Movie.t>}

let handler = Fresh.Handler.make({
  get: async (req, ctx) =>
    await Utils.authCheck(req, async () => {
      let votes: Dict.t<array<string>> = Dict.make()
      let activeUsers = await User.getActiveUsers()
      Console.info2("Active Users", activeUsers)

      let users = await User.getAllUsers()
      Console.info2("All users", users)

      let users = users->Array.filter(user => activeUsers->Array.includes(user.name))

      users->Array.forEach(user => {
        let name = user.name
        let movies = user.movies
        movies->Array.forEach(
          ratingKey => {
            let existing = votes->Dict.get(ratingKey)->Option.getOr([])
            votes->Dict.set(ratingKey, existing->Array.concat([name]))
          },
        )
        ()
      })

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
let make = (~data: data) => {
  switch data.movies->Array.length > 1 {
  | false =>
    <section class="w-full mt-5 text-center">
      <h2 class="text-xl">
        {Preact.string("There are no movies found that this group has in common.")}
      </h2>
      <a href="/configure"> {Preact.string("Make sure you have selected the active viewers.")} </a>
      <p> {Preact.string("And go select more movies!")} </p>
    </section>
  | true =>
    <section>
      <Movies
        movies={data.movies}
        redirect="/watch"
        wantToWatch=[]
        heading="At least two of you want to watch these movies!"
      />
    </section>
  }
}

let default = make

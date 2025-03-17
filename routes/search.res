type data = {movies: array<Plex.Movie.t>, moviesToWatch: array<string>}

let handler: Fresh.Handler.t<unknown, data, unknown> = {
  get: async (req, ctx) => {
    switch await Utils.authCheck(req) {
    | Some(fn) => fn()
    | None => {
        let user = User.getCurrentUser(req)
        let moviesToWatch =
          await User.getMovies(~name=user)->Promise.thenResolve(movies => movies->Set.toArray)

        ctx.render(Some({movies: [], moviesToWatch}), None)
      }
    }
  },
  post: async (req, ctx) => {
    switch await Utils.authCheck(req) {
    | Some(fn) => fn()
    | None => {
        let user = User.getCurrentUser(req)
        let moviesToWatch =
          await User.getMovies(~name=user)->Promise.thenResolve(movies => movies->Set.toArray)

        let data = switch await Plex.Api.search() {
        | Some(movies) => Some({movies: [], moviesToWatch})
        | None => None
        }

        ctx.render(data, None)
      }
    }
  },
}

@jsx.component
let make = (~data: option<data>) =>
  switch data {
  | Some({movies, moviesToWatch}) =>
    switch movies->Array.length {
    | 0 => <p class="text-center text-sm"> {Preact.string("No matches found.")} </p>
    | _ =>
      <>
        <p class="text-center text-sm">
          {Preact.string(`Number of results: ${movies->Array.length->Int.toString}`)}
        </p>
        <Movies movies wantToWatch=moviesToWatch heading="Search results" />
      </>
    }
  | None =>
    <div class="w-full text-xl p-5 text-center">
      {Preact.string("Something went wrong connecting to Plex.")}
    </div>
  }

let default = make

type data = {movies: array<Plex.Movie.t>, moviesToWatch: array<string>, query: string}

let handler: Fresh.Handler.t<unknown, data, unknown> = {
  get: async (req, ctx) => {
    switch await Utils.authCheck(req) {
    | Some(fn) => fn()
    | None => {
        let user = User.getCurrentUser(req)
        let moviesToWatch =
          await User.getMovies(~name=user)->Promise.thenResolve(movies => movies->Set.toArray)

        let query =
          ctx.url.search
          ->String.split("=")
          ->Array.at(1)
          ->Option.map(decodeURIComponent)
          ->Option.getOr("")

        let data = switch await Plex.Api.search(query) {
        | Some(movies) => Some({movies, moviesToWatch, query})
        | None => Some({movies: [], moviesToWatch, query})
        }
        ctx.render(data, None)
      }
    }
  },
  post: async (req, ctx) => {
    open WebAPI
    switch await Utils.authCheck(req) {
    | Some(fn) => fn()
    | None => {
        let user = User.getCurrentUser(req)
        let moviesToWatch =
          await User.getMovies(~name=user)->Promise.thenResolve(movies => movies->Set.toArray)

        let form = await req->Request.formData
        let query = form->FormData.get2("query")

        // Console.log(form)

        let data = switch await Plex.Api.search(query) {
        | Some(movies) => Some({movies, moviesToWatch, query})
        | None => Some({movies: [], moviesToWatch, query})
        }

        ctx.render(data, None)
      }
    }
  },
}

@jsx.component
let make = (~data: option<data>) => {
  <section>
    {switch data {
    | Some({movies, moviesToWatch, query}) =>
      <>
        <form action="/search" method="post" class="w-full m-auto">
          <label class="block"> {"Search"->Preact.string} </label>
          <input name="query" class="text-black rounded-lg p-2" value={query} />
        </form>
        {switch (movies->Array.length, query) {
        | (_, "") => Preact.null
        | (0, _) => <p class="text-center text-sm"> {Preact.string("No matches found.")} </p>
        | _ =>
          <>
            <Movies
              movies
              wantToWatch=moviesToWatch
              heading={`Number of results: ${movies->Array.length->Int.toString}`}
              redirect={`/search?query=${query}`->encodeURIComponent}
            />
          </>
        }}
      </>
    | None =>
      <div class="w-full text-xl p-5 text-center">
        {Preact.string("Something went wrong connecting to Plex.")}
      </div>
    }}
  </section>
}

let default = make

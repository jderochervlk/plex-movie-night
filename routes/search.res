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
        // <form action="/search" method="post" class="w-full m-auto">
        //   <label class="block"> {"Search"->Preact.string} </label>
        //   <input name="query" class="text-black rounded-lg p-2" value={query} />
        // </form>

        <form class="max-w-md mx-auto" action="/search" method="post">
          <label class="mb-2 text-sm font-medium text-gray-900 sr-only">
            {"Search"->Preact.string}
          </label>
          <div class="relative">
            <input
              name="query"
              value={query}
              type_="search"
              id="default-search"
              class="block w-full p-4 text-sm text-gray-900 border border-gray-300 rounded-lg bg-gray-50 focus:ring-blue-900 focus:border-blue-900 border-3 focus:outline-none"
              placeholder="Search by title"
            />
            <button
              type_="submit"
              class="absolute top-0 end-0 p-2.5 text-sm font-medium h-full text-gray-50 bg-blue-900 rounded-e-md border border-blue-900 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 dark:bg-blue-600  ">
              <img src="/search.svg" class="h-7" />
            </button>
          </div>
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

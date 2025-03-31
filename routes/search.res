open WebAPI

type data = {movies: array<Plex.Movie.t>, moviesToWatch: array<string>, query: string}

let handler = Fresh.Handler.make({
  get: async (req, ctx) =>
    await Utils.authCheck(req, async () => {
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
      | Some(movies) => {movies, moviesToWatch, query}
      | None => {movies: [], moviesToWatch, query}
      }
      ctx.render(~data)
    }),
  post: async (req, ctx) =>
    await Utils.authCheck(req, async () => {
      let user = User.getCurrentUser(req)
      let moviesToWatch =
        await User.getMovies(~name=user)->Promise.thenResolve(movies => movies->Set.toArray)

      let form = await req->Request.formData
      let query = form->FormData.get2("query")

      let data = switch await Plex.Api.search(query) {
      | Some(movies) => {movies, moviesToWatch, query}
      | None => {movies: [], moviesToWatch, query}
      }

      ctx.render(~data)
    }),
})

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

        <form class="max-w-md mx-auto pt-10 text-center" action="/search" method="post">
          <label class="input bg-base-content text-secondary-content">
            <svg class="h-[1em] opacity-50" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
              <g
                strokeLinejoin="round"
                strokeLinecap="round"
                strokeWidth="2.5"
                fill="none"
                stroke="currentColor">
                <circle cx="11" cy="11" r="8" />
                <path d="m21 21-4.3-4.3" />
              </g>
            </svg>
            <input
              name="query"
              type_="search"
              class="grow border-none"
              placeholder="Search"
              value={query}
            />
          </label>
          // <div class="relative">
          //   <input
          //     name="query"
          //     value={query}
          //     type_="search"
          //     id="default-search"
          //     class="block w-full p-4 text-sm text-gray-900 border border-gray-300 rounded-lg bg-gray-50 focus:ring-blue-900 focus:border-blue-900 border-3 focus:outline-hidden"
          //     placeholder="Search by title"
          //   />
          //   <button
          //     type_="submit"
          //     class="absolute top-0 end-0 p-2.5 text-sm font-medium h-full text-gray-50 bg-blue-900 rounded-e-md border border-blue-900 hover:bg-blue-800 focus:ring-4 focus:outline-hidden focus:ring-blue-300 dark:bg-blue-600  "
          //   />
          // </div>
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

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
        ->String.replace("?", "")
        ->String.split("&")
        ->Array.map(String.split(_, "="))
        ->Array.find(x => x[0] == Some("query"))
        ->Option.flatMap(Array.at(_, 1))
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
      let query = form->FormData.get("query")

      let data = switch await Plex.Api.search(query) {
      | Some(movies) => {movies, moviesToWatch, query}
      | None => {movies: [], moviesToWatch, query}
      }

      ctx.render(~data)
    }),
})

@jsx.component
let make = (~data: option<data>) => {
  <section class="search">
    {switch data {
    | Some({movies, moviesToWatch, query}) =>
      <>
        <form action="/search" method="post">
          <input name="query" type_="search" placeholder="Search" value={query} />
          <button type_="submit" title="search">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
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
          </button>
        </form>
        {switch (movies->Array.length, query) {
        | (_, "") => Preact.null
        | (0, _) => <p> {Preact.string("No matches found.")} </p>
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
    | None => <h3> {Preact.string("Something went wrong connecting to Plex.")} </h3>
    }}
  </section>
}

let default = make

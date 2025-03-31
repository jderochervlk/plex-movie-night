/**
 Renders a grid of movies with an overlay if that movie is on a user's watchlist
 */
@jsx.component
let make = (~movies: array<Plex.Movie.t>, ~wantToWatch: array<string>, ~heading, ~redirect) => {
  <Fresh.Partial name=heading>
    <section class="px-4 py-8 mx-auto max-w-(--breakpoint-2xl)">
      <h2 class="text-center text-xl mb-5"> {heading->Preact.string} </h2>
      <div
        class="grid grid-flow-row-dense grid-cols-3 gap-1 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-8 2xl:grid-cols-12 items-center">
        {movies
        ->Array.mapWithIndex(({title, thumb, ratingKey}, index) =>
          <div>
            <a href={`/movie/${ratingKey->Int.toString}?redirect=${redirect}`} title>
              <Thumbnail
                title thumb index wantToWatch={wantToWatch->Array.includes(ratingKey->Int.toString)}
              />
            </a>
          </div>
        )
        ->Preact.array}
      </div>
    </section>
  </Fresh.Partial>
}

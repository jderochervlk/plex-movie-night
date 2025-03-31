/**
 Renders a grid of movies with an overlay if that movie is on a user's watchlist
 */
@jsx.component
let make = (
  ~movies: array<Plex.Movie.t>,
  ~wantToWatch: array<string>,
  ~heading,
  ~redirect,
  ~aboveTheFold=false,
) => {
  <section class="px-4 py-8 mx-auto max-w-(--breakpoint-2xl)">
    <div class="prose mb-4">
      <h2 class="text-center text-base-content text-2xl"> {heading->Preact.string} </h2>
    </div>
    <div
      class="not-prose grid grid-flow-row-dense grid-cols-3 gap-1 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-8 2xl:grid-cols-12 items-center">
      {movies
      ->Array.mapWithIndex(({title, thumb, ratingKey}, index) =>
        <div class="h-full">
          <a
            href={`/movie/${ratingKey->Int.toString}?redirect=${redirect}`}
            title
            class="h-full flex">
            <Thumbnail
              title
              thumb
              index
              wantToWatch={wantToWatch->Array.includes(ratingKey->Int.toString)}
              aboveTheFold
            />
          </a>
        </div>
      )
      ->Preact.array}
    </div>
  </section>
}

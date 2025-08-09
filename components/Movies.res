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
  <section>
    <h2> {heading->Preact.string} </h2>
    <div class="movie-grid">
      {movies
      ->Array.mapWithIndex(({title, thumb, ratingKey}, index) =>
        <a class="movie-card" href={`/movie/${ratingKey->Int.toString}?redirect=${redirect}`} title>
          <Thumbnail
            title
            thumb
            index
            wantToWatch={wantToWatch->Array.includes(ratingKey->Int.toString)}
            aboveTheFold
          />
        </a>
      )
      ->Preact.array}
    </div>
  </section>
}

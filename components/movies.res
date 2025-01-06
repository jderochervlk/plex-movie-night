@jsx.component
let make = (~movies: array<Movie.t>) => {
  <div>
    {movies
    ->Array.map(movie => <Movie movie={{name: movie.name, wantToWatch: movie.wantToWatch}} />)
    ->Preact.array}
  </div>
}

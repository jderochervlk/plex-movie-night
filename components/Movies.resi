@react.component
let make: (
  ~movies: array<Plex.Movie.t>,
  ~wantToWatch: array<string>,
  ~heading: string,
  ~redirect: string,
  ~aboveTheFold: bool=?,
) => Jsx.element

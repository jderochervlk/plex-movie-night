let imgHeight: int
let imgWidth: int

module Movie: {
  type t = {
    title: string,
    thumb: string,
    ratingKey: int,
    titleSort: string,
    tagline: string,
    summary: string,
    contentRating: string,
    rating: float,
    audienceRating: float,
    duration: string,
    audienceRatingImage: string,
    ratingImage: string,
  }
}
module Api: {
  let getRecent: (~size: int=?, ~offset: int=?) => promise<option<array<Movie.t>>>
  let getNewest: unit => promise<option<array<Movie.t>>>
  let getByDecade: (string, ~audienceRating: float=?) => promise<option<array<Movie.t>>>
  let getMovie: string => promise<option<Movie.t>>
  let getThumb: string => string
  let search: string => promise<option<array<Movie.t>>>
}

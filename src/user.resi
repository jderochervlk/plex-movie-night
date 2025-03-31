type t = {name: string, movies: array<string>}
let getMovies: (~name: string) => promise<Set.t<string>>
let toggleMovie: (~name: string, ~ratingKey: string, ~wantToWatch: string) => promise<unit>
let doesUserWantToWatch: (~name: string, ~ratingKey: string) => promise<string>
let getCurrentUser: WebAPI.FetchAPI.request => string
let createAllUsers: unit => promise<unit>
let getAllUsers: unit => promise<array<Db__edgeql.SelectAllUsers.response>>

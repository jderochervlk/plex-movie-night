let client = EdgeDB.Client.make()

type wantTowach = [#"true" | #"false"]

let selectUser = %edgeql(`
    # @name selectUser
    select default::User {
        movies,
        name
    }
    filter .name = <str>$name
`)

let selectAllUsers = %edgeql(`
    # @name selectAllUsers
    select default::User {
        movies,
        name
    }
`)

let insertUser = %edgeql(`
    # @name insertUser
    insert User {
        name := <str>$name
    }
`)

let addMovieToUser = %edgeql(`
    # @name addMovieToUser
    update User
    filter .name = <str>$name
    set { movies := [<str>$ratingKey]++.movies }
`)

let setUserMovies = %edgeql(`
    # @name setUserMovies
    update User
    filter .name = <str>$name
    set { movies := <array<str>>$movies }
`)

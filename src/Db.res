let client = EdgeDB.Client.make()

type wantTowach = [#"true" | #"false"]

let insertMovie = %edgeql(`
    # @name insertMovie
    insert Movie {
        ratingKey := <str>$ratingKey
    }
`)

let selectUser = %edgeql(`
    # @name selectUser
    select User {
        name := <str>$name
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
    filter .name = "Josh"
    set { movies := [<str>$ratingKey]++.movies }
`)

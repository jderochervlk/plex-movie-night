let client = EdgeDB.Client.make()

type wantTowach = [#"true" | #"false"]

let insertMovie = %edgeql(`
    # @name insertMovie
    insert Movie {
        ratingKey := <str>$ratingKey
    }
`)

module SelectUser = %edgeql(`
    # @name selectUser
    select User {
        name := <str>$name
    }
`)

module InsertUser = %edgeql(`
    # @name insertUser
    insert User {
        name := <str>$name
    }
`)

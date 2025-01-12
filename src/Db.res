module InsertMovie = %edgeql(`
    # @name insertMovie
    insert Movie {
        title := <str>$title
    }
`)

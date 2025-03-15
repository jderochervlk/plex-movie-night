// @sourceHash 5f3843091f6b54b4d4bbc7bbb718cd41

module SelectUser = {
  let queryText = `# @name selectUser
      select default::User {
          movies,
          name
      }
      filter .name = <str>$name`
  
  @live  
  type args = {
    name: string,
  }
  
  type response = {
    movies: Null.t<array<string>>,
    name: string,
  }
  
  @live
  let query = (client: EdgeDB.Client.t, args: args): promise<array<response>> => {
    client->EdgeDB.QueryHelpers.many(queryText, ~args)
  }
  
  @live
  let transaction = (transaction: EdgeDB.Transaction.t, args: args): promise<array<response>> => {
    transaction->EdgeDB.TransactionHelpers.many(queryText, ~args)
  }
}

module InsertUser = {
  let queryText = `# @name insertUser
      insert User {
          name := <str>$name
      }`
  
  @live  
  type args = {
    name: string,
  }
  
  type response = {
    id: string,
  }
  
  @live
  let query = (client: EdgeDB.Client.t, args: args): promise<result<response, EdgeDB.Error.errorFromOperation>> => {
    client->EdgeDB.QueryHelpers.singleRequired(queryText, ~args)
  }
  
  @live
  let transaction = (transaction: EdgeDB.Transaction.t, args: args): promise<result<response, EdgeDB.Error.errorFromOperation>> => {
    transaction->EdgeDB.TransactionHelpers.singleRequired(queryText, ~args)
  }
}

module AddMovieToUser = {
  let queryText = `# @name addMovieToUser
      update User
      filter .name = <str>$name
      set { movies := [<str>$ratingKey]++.movies }`
  
  @live  
  type args = {
    ratingKey: string,
    name: string,
  }
  
  type response = {
    id: string,
  }
  
  @live
  let query = (client: EdgeDB.Client.t, args: args): promise<array<response>> => {
    client->EdgeDB.QueryHelpers.many(queryText, ~args)
  }
  
  @live
  let transaction = (transaction: EdgeDB.Transaction.t, args: args): promise<array<response>> => {
    transaction->EdgeDB.TransactionHelpers.many(queryText, ~args)
  }
}

module SetUserMovies = {
  let queryText = `# @name setUserMovies
      update User
      filter .name = <str>$name
      set { movies := <array<str>>$movies }`
  
  @live  
  type args = {
    movies: array<string>,
    name: string,
  }
  
  type response = {
    id: string,
  }
  
  @live
  let query = (client: EdgeDB.Client.t, args: args): promise<array<response>> => {
    client->EdgeDB.QueryHelpers.many(queryText, ~args)
  }
  
  @live
  let transaction = (transaction: EdgeDB.Transaction.t, args: args): promise<array<response>> => {
    transaction->EdgeDB.TransactionHelpers.many(queryText, ~args)
  }
}
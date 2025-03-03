// @sourceHash fc2882af871b8fe0b0fa337d02eb8b9d

module InsertMovie = {
  let queryText = `# @name insertMovie
      insert Movie {
          ratingKey := <str>$ratingKey
      }`
  
  @live  
  type args = {
    ratingKey: string,
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

module SelectUser = {
  let queryText = `# @name selectUser
      select User {
          name := <str>$name
      }`
  
  @live  
  type args = {
    name: string,
  }
  
  type response = {
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
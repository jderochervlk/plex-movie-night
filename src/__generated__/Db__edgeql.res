// @sourceHash 90ae927fdc440d4fbef6d3721c860e99

module InsertMovie = {
  let queryText = `# @name insertMovie
      insert Movie {
          title := <str>$title
      }`
  
  @live  
  type args = {
    title: string,
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
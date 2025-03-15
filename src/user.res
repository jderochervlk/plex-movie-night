open WebAPI

let getMovies = async (~name) => {
  let client = Db.client
  let user = await client->Db.selectUser({name: name})
  switch await client->Db.selectUser({name: name}) {
  | [user] => user.movies->Null.getOr([])->Set.fromArray
  | _ => Set.make()
  }
}

let toggleMovie = async (~name, ~ratingKey, ~wantToWatch) => {
  let client = Db.client
  let movies = await getMovies(~name)
  let wantToWatch = wantToWatch === "true"
  if movies->Set.has(ratingKey) {
    if wantToWatch {
      () // movie already in watch list so we don't need to do anything
    } else {
      // movie needs to be removed
      let _ = movies->Set.delete(ratingKey)
      let _ = await client->Db.setUserMovies({name, movies: movies->Set.toArray})
    }
  } else {
    // movie needs to be added
    movies->Set.add(ratingKey)
    let _ = await client->Db.setUserMovies({name, movies: movies->Set.toArray})
  }
}

let doesUserWantToWatch = async (~name, ~ratingKey) => {
  let movies = await getMovies(~name)
  movies->Set.has(ratingKey) ? "true" : "false"
}

let getCurrentUser = (req: FetchAPI.request) =>
  req.headers
  ->Std.Http.Cookies.get
  ->Dict.get("name")
  ->Option.getUnsafe // we can get this unsafe since we already redirect if the user doesn't exist

/**
 Make sure all the users defined in the env exist in the DB
 */
let createAllUsers = async () => {
  let client = Db.client
  let users = Env.names()
  for i in 0 to users->Array.length {
    switch users[i] {
    | Some(name) =>
      // check if user exists
      switch await client->Db.selectUser({name: name}) {
      | [_] => () // if user already exists, do nothing
      | _ => {
          // if user doesn't exist, create user
          let res = await client->Db.insertUser({name: name})
          switch res {
          | Ok(_) => ()
          | Error(err) => Console.error(err)
          }
        }
      }
    | None => ()
    }
  }
}

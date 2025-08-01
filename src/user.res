open WebAPI

type t = {
  name: string,
  movies: array<string>,
}

let getUser = async name => {
  let kv = await Deno.Kv.openKv()
  let user = await kv->Deno.Kv.get(["users", name])
  switch user.value->Null.toOption {
  | Some(movies) => {name, movies}
  | None => {name, movies: []}
  }
}

let getMovies = async (~name) => {
  let user = await getUser(name)
  user.movies->Set.fromArray
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

let createUser = async name => {
  let kv = await Deno.Kv.openKv()
  let user = await kv->Deno.Kv.get(["users", name])
  switch user.value->Null.toOption {
  | Some(_) => ()
  | None => {
      let _ = await kv->Deno.Kv.set(["users", name], [])
    }
  }
}

/**
 Make sure all the users defined in the env exist in the DB
 */
let createAllUsers = async () => {
  let names = Env.names()
  let kv = await Deno.Kv.openKv()
  let users = await kv->Deno.Kv.get(["users"])
  switch users.value->Null.toOption {
  | Some(_) => ()
  | None => {
      let _ = await kv->Deno.Kv.set(["users"], [])
    }
  }
  let _ = names->Array.forEach(name => {
    let _ = createUser(name)
  })
}

let getUser = async name => {
  let kv = await Deno.Kv.openKv()
  let user = await kv->Deno.Kv.get(["users", name])
  switch user.value->Null.toOption {
  | Some(movies) => {name, movies}
  | None => {
      let _ = await createUser(name)
      {name, movies: []}
    }
  }
}

let getAllUsers = async () => {
  let kv = await Deno.Kv.openKv()
  let users = await kv->Deno.Kv.get(["users"])
  switch users.value->Null.toOption {
  | Some(users) => await Promise.all(users->Array.map(getUser))
  | None => []
  }
}

open WebAPI

type data = {
  movie: Plex.Movie.t,
  wantToWatch: string,
}

module Data = {
  let make = async (ratingKey, wantToWatch) => {
    switch await Plex.Api.getMovie(ratingKey) {
    | Some(movie) => Some({movie, wantToWatch})
    | None => None
    }
  }
}

let handler: Fresh.Handler.t<unknown, option<data>, unknown> = {
  get: async (req, ctx) => {
    let ratingKey = ctx.params->Dict.get("ratingKey")
    switch (await Utils.authCheck(req), ratingKey) {
    | (Some(fn), _) => fn()
    | (None, Some(ratingKey)) => {
        let wantToWatch = await User.doesUserWantToWatch(~name=User.getCurrentUser(req), ~ratingKey)
        let data = await Data.make(ratingKey, wantToWatch)
        ctx.render(~data)
      }
    | _ => Response.redirect(~url=Utils.getRootUrl(req.url))
    }
  },
  post: async (req, ctx) => {
    let rootUrl = Utils.getRootUrl(req.url)
    let path =
      ctx.url.search
      ->String.split("=")
      ->Array.at(1)
      ->Option.map(decodeURIComponent)
      ->Option.getOr("/")

    let redirect = rootUrl ++ path

    let ratingKey = ctx.params->Dict.get("ratingKey")
    let data = await req->Request.formData
    let wantToWatch = data->FormData.get2("wantToWatch")
    switch (await Utils.authCheck(req), ratingKey) {
    | (Some(fn), _) => fn()
    | (None, Some(ratingKey)) =>
      await User.toggleMovie(~name=User.getCurrentUser(req), ~ratingKey, ~wantToWatch)
      Response.redirect(~url=redirect)
    | _ => Response.redirect(~url=redirect)
    }
  },
}

@jsx.component
let make = (~data: option<data>) => {
  switch data {
  | Some({movie: {title, summary, thumb, ratingKey}, wantToWatch}) =>
    <Movie title summary thumb ratingKey wantToWatch />
  | None =>
    <section className="w-full text-center text-xl p-4">
      <h2 className="mb-6"> {Preact.string("Movie not found.")} </h2>
      <a className="text-blue-200 underline hover:text-blue-500 cursor-pointer" href="/">
        {Preact.string("Return home")}
      </a>
    </section>
  }
}

let default = make

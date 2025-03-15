open WebAPI

type data = {
  mediaContainer: Plex.MediaContainer.t,
  wantToWatch: string,
}

module Data = {
  let make = async (ratingKey, wantToWatch) => {
    switch await Plex.getMetadata(ratingKey) {
    | Some(mediaContainer) => Some({mediaContainer, wantToWatch})
    | None => None
    }
  }
}

let handler: Fresh.Handler.t<unknown, data, unknown> = {
  get: async (req, ctx) => {
    let ratingKey = ctx.params->Dict.get("ratingKey")
    switch (await Utils.authCheck(req), ratingKey) {
    | (Some(fn), _) => fn()
    | (None, Some(ratingKey)) => {
        let wantToWatch = await User.doesUserWantToWatch(~name=User.getCurrentUser(req), ~ratingKey)
        let data = await Data.make(ratingKey, wantToWatch)
        ctx.render(data, None)
      }
    | _ => Response.redirect(~url="/")
    }
  },
  post: async (req, ctx) => {
    let ratingKey = ctx.params->Dict.get("ratingKey")
    let data = await req->Request.formData
    let wantToWatch = data->FormData.get2("wantToWatch")
    switch (await Utils.authCheck(req), ratingKey) {
    | (Some(fn), _) => fn()
    | (None, Some(ratingKey)) =>
      await User.toggleMovie(~name=User.getCurrentUser(req), ~ratingKey, ~wantToWatch)
      let data = await Data.make(ratingKey, wantToWatch)
      ctx.render(data, None)
    | _ => Response.redirect(~url="/")
    }
  },
}

@jsx.component
let make = (~data: option<data>) => {
  let wantToWatch = data->Option.map(data => data.wantToWatch)->Option.getOr("false")
  switch data
  ->Option.map(data => data.mediaContainer)
  ->Option.flatMap(Plex.getFirstMovieFromMediaContainer) {
  | Some(Movie({title, summary, thumb, ratingKey})) =>
    <Movie title summary thumb ratingKey wantToWatch />
  | _ =>
    <section className="w-full text-center text-xl p-4">
      <h2 className="mb-6"> {Preact.string("Movie not found.")} </h2>
      <a className="text-blue-200 underline hover:text-blue-500 cursor-pointer" href="/">
        {Preact.string("Return home")}
      </a>
    </section>
  }
}

let default = make

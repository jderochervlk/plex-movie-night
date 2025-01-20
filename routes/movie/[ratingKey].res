open WebAPI

type data = Plex.MediaContainer.t<Plex.Movie.t>

let handler: Fresh.Handler.t<unknown, Plex.MediaContainer.t<Plex.Movie.t>, unknown> = {
  get: async (req, ctx) => {
    let ratingKey = ctx.params->Dict.get("ratingKey")
    switch (await Login.authCheck(req), ratingKey) {
    | (Some(fn), _) => fn()
    | (None, Some(ratingKey)) => ctx.render(Some(await Plex.getMetadata(ratingKey)), None)
    | _ => Response.redirect(~url="/")
    }
  },
}

@jsx.component
let make = (~data: data) => {
  switch data->Plex.getFirstMovieFromMediaContainer {
  | Some(movie) => // Console.log(movie)
    <div>
      <h1 className="text-2xl"> {Preact.string(movie.title)} </h1>
    </div>
  | _ => Preact.null
  }
}

let default = make

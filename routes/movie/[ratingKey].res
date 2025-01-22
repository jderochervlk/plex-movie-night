open WebAPI

type data = Plex.MediaContainer.t

let handler: Fresh.Handler.t<unknown, Plex.MediaContainer.t, unknown> = {
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
  let _ = data->Plex.getFirstMovieFromMediaContainer->Console.log
  switch data->Plex.getFirstMovieFromMediaContainer {
  | Some(Movie({title, summary})) => <Movie title summary />
  | _ => <div> {Preact.string("Movie not found.")} </div>
  }
}

let default = make

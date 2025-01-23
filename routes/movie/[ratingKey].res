open WebAPI

type data = {
  mediaContainer: Plex.MediaContainer.t,
  wantToWatch: string,
}

let handler: Fresh.Handler.t<unknown, data, unknown> = {
  get: async (req, ctx) => {
    let ratingKey = ctx.params->Dict.get("ratingKey")
    switch (await Login.authCheck(req), ratingKey) {
    | (Some(fn), _) => fn()
    | (None, Some(ratingKey)) => ctx.render(
        Some({mediaContainer: await Plex.getMetadata(ratingKey), wantToWatch: "false"}),
        None,
      )
    | _ => Response.redirect(~url="/")
    }
  },
  post: async (req, ctx) => {
    let ratingKey = ctx.params->Dict.get("ratingKey")
    let data = await req->Request.formData
    Console.log2(4, data)
    let wantToWatch = data->FormData.get2("wantToWatch")
    switch (await Login.authCheck(req), ratingKey) {
    | (Some(fn), _) => fn()
    | (None, Some(ratingKey)) => {
        Console.log(data)
        ctx.render(Some({mediaContainer: await Plex.getMetadata(ratingKey), wantToWatch}), None)
      }
    | _ => Response.redirect(~url="/")
    }
  },
}

@jsx.component
let make = (~data: data) => {
  let wantToWatch = data.wantToWatch
  switch data.mediaContainer->Plex.getFirstMovieFromMediaContainer {
  | Some(Movie({title, summary, thumb, ratingKey})) =>
    <Movie title summary thumb ratingKey wantToWatch=data.wantToWatch />
  | _ => <div> {Preact.string("Movie not found.")} </div>
  }
}

let default = make

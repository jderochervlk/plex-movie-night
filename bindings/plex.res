open WebAPI

type media =
  | @tag("type") @as("season") Season({parentTitle: string})
  | @tag("type") @as("movie")
  Movie({
      title: string,
      thumb: string,
      ratingKey: int,
      titleSort: string,
      tagline: string,
      summary: string,
      contentRating: string,
      rating: float,
      audienceRating: float,
      duration: string,
      audienceRatingImage: string,
      ratingImage: string,
    })

module MediaContainer = {
  type mediaContainer = {
    @as("Metadata")
    metadata: array<media>,
  }

  type t = {
    @as("MediaContainer")
    mediaContainer: mediaContainer,
  }
  @scope("JSON") @val
  external parse: string => t = "parse"
}

let createUrl = (path, ~otherParams=false) =>
  `${Env.plexServer()}${path}${otherParams ? "&" : "?"}X-Plex-Token=${Env.plexToken()}`

let getRecent = async (~size=100, ~offset=0) => {
  let headers = Headers.make(~init=[["Accept", "application/json"]])
  await fetch(
    createUrl(
      `/library/recentlyAdded?X-Plex-Container-Size=${size->Int.toString}&X-Plex-Container-Start=${offset->Int.toString}`,
      ~otherParams=true,
    ),
    ~init={headers: headers->HeadersInit.fromHeaders},
  )
  ->Promise.then(Response.json)
  ->Promise.thenResolve(res => res->JSON.stringify)
  ->Promise.thenResolve(t => Some(MediaContainer.parse(t)))
  ->Promise.catch(err => {
    Console.error(err)
    Promise.resolve(None)
  })
}

let onlyMovies = items =>
  items->Array.filter(item =>
    switch item {
    | Movie(_) => true
    | _ => false
    }
  )

let getThumb = url =>
  createUrl(
    `/photo/:/transcode?width=248&height=372&minSize=1&upscale=1&url=${encodeURIComponent(url)}`,
    ~otherParams=true,
  )

let getMetadata = async ratingKey => {
  let headers = Headers.make(~init=[["Accept", "application/json"]])
  await fetch(
    createUrl(`/library/metadata/${ratingKey}`, ~otherParams=false),
    ~init={headers: headers->HeadersInit.fromHeaders},
  )
  ->Promise.then(Response.json)
  ->Promise.thenResolve(res => res->JSON.stringify)
  ->Promise.thenResolve(res => Some(res->MediaContainer.parse))
  ->Promise.catch(exn => {
    Console.error(exn)
    Promise.resolve(None)
  })
}

let getFirstMovieFromMediaContainer = (mediaContainer: MediaContainer.t) =>
  mediaContainer.mediaContainer.metadata->Array.get(0)

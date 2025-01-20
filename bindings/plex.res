open WebAPI

module Movie = {
  type t = {title: string, thumb: string, ratingKey: int}
}

type media =
  | @tag("type") @as("season") Season({parentTitle: string})
  | @tag("type") @as("movie") Movie(Movie.t)

module MediaContainer = {
  type mediaContainer<'a> = {
    @as("Metadata")
    metadata: array<'a>,
  }

  type t<'a> = {
    @as("MediaContainer")
    mediaContainer: mediaContainer<'a>,
  }
  @scope("JSON") @val
  external parse: string => t<'a> = "parse"
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
  ->Promise.thenResolve(MediaContainer.parse)
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
  ->Promise.thenResolve(res => res->MediaContainer.parse)
}

let getFirstMovieFromMediaContainer = (mediaContainer: MediaContainer.t<Movie.t>) =>
  mediaContainer.mediaContainer.metadata->Array.get(0)

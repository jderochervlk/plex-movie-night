open WebAPI

module MediaContainer = {
  type media =
    | @tag("type") @as("season") Season({\"type": string})
    | @tag("type") @as("movie") Movie({\"type": string})
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

let testVal: MediaContainer.media = Movie({\"type": "movie"})

module Movie = {
  type t = {
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
  }
  external parse: array<MediaContainer.media> => array<t> = "%identity"
}

module Api = {
  let onlyMovies = (items: array<MediaContainer.media>) =>
    items
    ->Array.filter(item =>
      switch item {
      | Movie(_) => true
      | Season(_) => false
      }
    )
    ->Movie.parse

  let createUrl = (path, ~otherParams=false) =>
    `${Env.plexServer()}${path}${otherParams ? "&" : "?"}X-Plex-Token=${Env.plexToken()}`

  let parsePlexResponse = res =>
    res
    ->Promise.then(Response.json)
    ->Promise.thenResolve(res => res->JSON.stringify)
    ->Promise.thenResolve(t =>
      Some(MediaContainer.parse(t))->Option.map(x => x.mediaContainer.metadata->onlyMovies)
    )
    ->Promise.catch(err => {
      Console.error(err)
      Promise.resolve(None)
    })

  let getRecent = async (~size=100, ~offset=0) => {
    let headers = Headers.make(~init=[["Accept", "application/json"]])
    await fetch(
      createUrl(
        `/library/recentlyAdded?X-Plex-Container-Size=${size->Int.toString}&X-Plex-Container-Start=${offset->Int.toString}`,
        ~otherParams=true,
      ),
      ~init={headers: headers->HeadersInit.fromHeaders},
    )->parsePlexResponse
  }

  let getMovie = async ratingKey => {
    let headers = Headers.make(~init=[["Accept", "application/json"]])
    let movies =
      await fetch(
        createUrl(`/library/metadata/${ratingKey}`, ~otherParams=false),
        ~init={headers: headers->HeadersInit.fromHeaders},
      )->parsePlexResponse

    movies->Option.flatMap(movies => movies[0])
  }
}

let getThumb = url =>
  Api.createUrl(
    `/photo/:/transcode?width=248&height=372&minSize=1&upscale=1&url=${encodeURIComponent(url)}`,
    ~otherParams=true,
  )

open WebAPI

type media =
  | @tag("type") @as("season") Season({parentTitle: string})
  | @tag("type") @as("movie") Movie({title: string, thumb: string, ratingKey: int})

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
  `${Env.plexServer}${path}${otherParams ? "&" : "?"}X-Plex-Token=${Env.plexToken}`

let getRecent = async () => {
  let headers = Headers.make(~init=[["Accept", "application/json"]])
  await fetch(
    createUrl(
      `/library/recentlyAdded?X-Plex-Container-Size=100&X-Plex-Container-Start=0`,
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

let getThumb = url => {
  // TODO: size this correctly
  let t = createUrl(
    `/photo/:/transcode?width=124&height=186&minSize=1&upscale=1&url=${encodeURIComponent(url)}`,
    ~otherParams=true,
  )
  Console.log(t)
  t
}

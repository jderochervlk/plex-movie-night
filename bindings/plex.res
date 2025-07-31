open WebAPI

module MediaContainer = {
  // Even though we don't build things with this constructor it is used for pattern matching on external data
  @@warning("-37")
  type media =
    | @tag("type") @as("season") Season({\"type": string})
    | @tag("type") @as("movie") Movie({\"type": string})

  type library =
    | @tag("type") @as("movie") Movie({\"type": string, uuid: string})
    | @tag("type") @as("show") Show({\"type": string, uuid: string})

  type hub = {
    \"type": string,
    size: int,
    @as("Metadata")
    metadata: option<array<media>>,
  }

  type mediaContainer = {
    @as("Metadata")
    metadata: option<array<media>>,
    @as("Directory")
    directory: array<library>,
    @as("Hub")
    hub: array<hub>,
  }

  type t = {
    @as("MediaContainer")
    mediaContainer: option<mediaContainer>,
  }
  @scope("JSON") @val
  external parse: string => t = "parse"
}

module Movie = {
  @deriving(accessors)
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

  let _ = (m: t) => m->title
}

module Api = {
  let headers = Headers.make()
  headers->Headers.append(~name="Accept", ~value="application/json")

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
      MediaContainer.parse(t).mediaContainer
      ->Option.flatMap(mediaContainer => mediaContainer.metadata)
      ->Option.map(onlyMovies)
    )
    ->Promise.catch(err => {
      Console.error(err)
      Promise.resolve(None)
    })

  let getRecent = async (~size=100, ~offset=0) => {
    await fetch(
      createUrl(
        `/library/recentlyAdded?X-Plex-Container-Size=${size->Int.toString}&X-Plex-Container-Start=${offset->Int.toString}`,
        ~otherParams=true,
      ),
      ~init={headers: headers->HeadersInit.fromHeaders},
    )->parsePlexResponse
  }

  let getMovie = async ratingKey =>
    await fetch(
      createUrl(`/library/metadata/${ratingKey}`, ~otherParams=false),
      ~init={headers: headers->HeadersInit.fromHeaders},
    )
    ->parsePlexResponse
    ->Promise.thenResolve(Option.flatMap(_, Array.at(_, 0)))

  let getId = (directory: array<MediaContainer.library>) =>
    directory
    ->Array.filter(library =>
      switch library {
      | Movie(_) => true
      | Show(_) => false
      }
    )
    ->Array.at(0)
    ->Option.map(library =>
      switch library {
      | Movie({uuid}) => uuid
      | Show({uuid}) => uuid
      }
    )

  let getMovieLibraryId = async () =>
    await fetch(createUrl(`/library/sections/`), ~init={headers: headers->HeadersInit.fromHeaders})
    ->Promise.then(Response.json)
    ->Promise.thenResolve(JSON.stringify(_))
    ->Promise.thenResolve(t =>
      Some(MediaContainer.parse(t))
      ->Option.flatMap(x => x.mediaContainer)
      ->Option.flatMap(mediaContainer => mediaContainer.directory->getId)
    )
    ->Promise.catch(err => {
      Console.error(err)
      Promise.resolve(None)
    })

  let search = async query =>
    switch await getMovieLibraryId() {
    | Some(id) =>
      await fetch(
        createUrl(`/hubs/search/?query="${query}"&sectionId=${id}`, ~otherParams=true),
        ~init={headers: headers->HeadersInit.fromHeaders},
      )
      ->Promise.then(Response.json)
      ->Promise.thenResolve(JSON.stringify(_))
      ->Promise.thenResolve(t =>
        MediaContainer.parse(t).mediaContainer
        ->Option.flatMap(mediaContainer =>
          mediaContainer.hub->Array.find(hub => hub.\"type" == "movie")
        )
        ->Option.flatMap(x => {
          x.metadata
        })
        ->Option.map(onlyMovies)
      )
      ->Promise.catch(err => {
        Console.error(err)
        Promise.resolve(None)
      })

    | None => {
        Console.error("No valid movie library was found")
        None
      }
    }

  let parseMoviesResponse = async res =>
    await res
    ->Promise.then(Response.json)
    ->Promise.thenResolve(JSON.stringify(_))
    ->Promise.thenResolve(t =>
      MediaContainer.parse(t).mediaContainer
      ->Option.flatMap(x => {
        x.metadata
      })
      ->Option.map(onlyMovies)
    )
    ->Promise.catch(err => {
      Console.error(err)
      Promise.resolve(None)
    })

  let getNewest = async () =>
    await fetch(
      createUrl(`/library/sections/1/newest`, ~otherParams=false),
      ~init={headers: headers->HeadersInit.fromHeaders},
    )->parseMoviesResponse

  let getByDecade = async (decade, ~audienceRating=9.0) =>
    await fetch(
      createUrl(
        `/library/sections/1/decade/${decade}?audienceRating>=${audienceRating->Float.toString}`,
        ~otherParams=true,
      ),
      ~init={headers: headers->HeadersInit.fromHeaders},
    )->parseMoviesResponse

  let getThumb = url =>
    createUrl(
      `/photo/:/transcode?width=${Int.toString(248 * 2)}&height=${Int.toString(
          372 * 2,
        )}&minSize=1&upscale=1&url=${encodeURIComponent(url)}`,
      ~otherParams=true,
    )
}

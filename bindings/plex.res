open WebAPI

let getRecent = async () => {
  let headers = Headers.make(~init=[["Accept", "application/json"]])
  let results = await fetch(
    `${Env.plexServer}/library/recentlyAdded?X-Plex-Container-Size=50&X-Plex-Container-Start=0&X-Plex-Token=${Env.plexToken}`,
    ~init={headers: headers->HeadersInit.fromHeaders},
  )
  Console.log(results)
  await Response.json(results)
}

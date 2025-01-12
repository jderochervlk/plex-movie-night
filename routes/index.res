type data = {recentlyAdded: Plex.MediaContainer.t}

let handler: Fresh.Handler.t<unknown, data, unknown> = {
  get: async (req, ctx) => {
    // let client = EdgeDB.Client.make()
    // EdgeDB.Client.
    switch await Login.authCheck(req) {
    | Some(fn) => fn()
    | None =>
      ctx.render(
        Some({
          recentlyAdded: await Plex.getRecent(),
        }),
        None,
      )
    }
  },
}

@jsx.component
let make = (~data: data) => {
  <main>
    <div class="px-4 py-8 mx-auto bg-[#86efac]">
      <div class="max-w-screen-md mx-auto flex flex-col items-center justify-center">
        <h1 class="text-4xl font-bold"> {"Movie Night"->Preact.string} </h1>
      </div>
    </div>
    <div class="px-4 py-8 mx-auto text-center">
      <NameForm />
    </div>
    <section class="px-4 py-8 mx-auto">
      <h2 class="text-center text-xl mb-5"> {"Recently Added"->Preact.string} </h2>
      <div class="grid grid-flow-row grid-cols-5 gap-5">
        {data.recentlyAdded.mediaContainer.metadata
        ->Plex.onlyMovies
        ->Array.map(item =>
          switch item {
          | Movie({title, thumb}) => <Thumbnail title thumb />
          | _ => Preact.null
          }
        )
        ->Preact.array}
        //   <Movies movies=data.movies />
      </div>
    </section>
    <pre>
      {data.recentlyAdded.mediaContainer.metadata
      ->JSON.stringifyAny(~space=2)
      ->Option.getOr("")
      ->Preact.string}
    </pre>
  </main>
}

let default = make

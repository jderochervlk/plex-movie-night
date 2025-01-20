type data = {recentlyAdded: Plex.MediaContainer.t}

let handler: Fresh.Handler.t<unknown, data, unknown> = {
  get: async (req, ctx) => {
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
    <Movies media=data.recentlyAdded.mediaContainer.metadata />
  </main>
}

let default = make

type data = {
  movies: array<Movie.t>,
  recentlyAdded: JSON.t,
}

let handler: Fresh.Handler.t<unknown, data, unknown> = {
  get: async (req, ctx) => {
    switch await Login.authCheck(req) {
    | Some(fn) => fn()
    | None => {
        let new = await Plex.getRecent()
        ctx.render(
          Some({
            movies: [
              {
                name: "star wars",
                wantToWatch: true,
              },
            ],
            recentlyAdded: new,
          }),
          None,
        )
      }
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
    <div class="px-4 py-8 mx-auto">
      <Movies movies=data.movies />
    </div>
    <pre> {data.recentlyAdded->JSON.stringify(~space=2)->Preact.string} </pre>
  </main>
}

let default = make

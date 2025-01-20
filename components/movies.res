@jsx.component
let make = (~media: array<Plex.media>) => {
  <section class="px-4 py-8 mx-auto">
    <h2 class="text-center text-xl mb-5"> {"Recently Added"->Preact.string} </h2>
    <div
      class="grid grid-flow-row-dense grid-cols-3 gap-1 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-8 max-w-[1700px] m-auto">
      {media
      ->Plex.onlyMovies
      ->Array.map(item =>
        switch item {
        | Movie({title, thumb}) =>
          <div>
            <Thumbnail title thumb />
          </div>
        | _ => Preact.null
        }
      )
      ->Preact.array}
    </div>
  </section>
}

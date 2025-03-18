@jsx.component
let make = () =>
  <header class="p-3 mx-auto bg-blue-900">
    <div class="max-w-screen-lg flex place-content-between mx-auto">
      <a href="/" class="flex flex-row">
        <img src="/film.svg" class="h-7 mr-2" />
        <H1 class="text-xl font-bold"> "Movie Night" </H1>
      </a>
      <a class="h-5" href="/search" title="search">
        <img src="/search.svg" class="h-7 mr-2" />
      </a>
    </div>
  </header>

@jsx.component
let make = () =>
  <header class="p-3 mx-auto bg-blue-900">
    <div class="max-w-screen-lg flex place-content-between mx-auto">
      <a href="/" class="flex flex-row hover:text-blue-200">
        <img src="/film.svg" class="h-7 mr-2" />
        <H1 class="text-xl font-bold"> "Movie Night" </H1>
      </a>
      <a class="h-5 hover:text-blue-200 mr-2" href="/watch" title="watch">
        {"watch"->Preact.string}
      </a>
      <a class="h-5 hover:text-blue-200 mr-2" href="/search" title="search">
        {"search"->Preact.string}
      </a>
    </div>
  </header>

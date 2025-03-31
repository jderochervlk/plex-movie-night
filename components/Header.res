type links = {
  title: string,
  href: string,
}

let links: array<links> = [
  {
    title: "Watch",
    href: "/watch",
  },
]

@jsx.component
let make = () =>
  <navigation class="navbar bg-primary text-primary-content fixed z-100">
    <div class="navbar-start">
      <div class="dropdown">
        <div tabIndex=0 role="button" class="btn btn-ghost btn-circle">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="h-5 w-5"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor">
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth="2"
              d="M4 6h16M4 12h16M4 18h7"
            />
          </svg>
        </div>
        <ul
          tabIndex=0
          class="menu menu-sm dropdown-content bg-primary-content rounded-box z-1 mt-3 w-52 p-2 shadow">
          {links
          ->Array.map(link => {
            <li>
              <a href=link.href class="text-lg text-neutral-content">
                {Preact.string(link.title)}
              </a>
            </li>
          })
          ->Preact.array}
        </ul>
      </div>
    </div>
    <div class="navbar-center">
      <a class="btn btn-ghost text-xl" href="/"> {Preact.string("Movie Night")} </a>
    </div>
    <div class="navbar-end">
      <a class="btn btn-ghost btn-circle" href="/search" title="search">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-5 w-5"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor">
          <path
            strokeLinecap="round"
            strokeLinejoin="round"
            strokeWidth="2"
            d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
          />
        </svg>
      </a>
    </div>
  </navigation>
// let make = () =>
//   <header class="p-3 mx-auto bg-blue-900">
//     <div class="max-w-(--breakpoint-lg) flex place-content-between mx-auto">
//       <a href="/" class="flex flex-row hover:text-blue-200">
//         <img src="/film.svg" class="h-7 mr-2" />
//         <H1 class="text-xl font-bold"> "Movie Night" </H1>
//       </a>
//       <a class="h-5 hover:text-blue-200 mr-2" href="/watch" title="watch">
//         {"watch"->Preact.string}
//       </a>
//       <a class="h-5 hover:text-blue-200 mr-2" href="/search" title="search">
//         {"search"->Preact.string}
//       </a>
//     </div>
//   </header>

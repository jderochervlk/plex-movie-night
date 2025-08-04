type links = {
  title: string,
  href: string,
}

let links: array<links> = [
  {
    title: "Watch",
    href: "/watch",
  },
  {
    title: "Configure",
    href: "/configure",
  },
  {
    title: "2020s",
    href: "/decade/2020",
  },
  {
    title: "2010s",
    href: "/decade/2010",
  },
  {
    title: "2000s",
    href: "/decade/2000",
  },
  {
    title: "1990s",
    href: "/decade/1990",
  },
  {
    title: "1980s",
    href: "/decade/1980",
  },
  {
    title: "1970s",
    href: "/decade/1970",
  },
]

@jsx.component
let make = () =>
  <div class="bg-primary text-primary-content fixed z-100 w-screen">
    <navigation class="navbar max-w-(--breakpoint-2xl) m-auto justify-between">
      <div class="navbar-start prose m w-auto">
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
                <a href=link.href class="text-lg text-secondary-content" fClientNav=false>
                  {Preact.string(link.title)}
                </a>
              </li>
            })
            ->Preact.array}
          </ul>
        </div>
      </div>
      <div class="navbar-center w-auto">
        <a class="btn btn-ghost text-xl" href="/"> {Preact.string("Movie Night")} </a>
      </div>
      <div class="navbar-end w-auto">
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
  </div>

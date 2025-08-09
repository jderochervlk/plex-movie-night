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
  <div class="nav-bar">
    <navigation>
      <div class="popover" tabIndex=0>
        <button popovertarget="menu">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="popover-icon"
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
        </button>
        <nav popover=true id="menu">
          <ul>
            {links
            ->Array.map(link => {
              <li>
                <a href=link.href fClientNav=false> {Preact.string(link.title)} </a>
              </li>
            })
            ->Preact.array}
          </ul>
        </nav>
      </div>
      <a href="/">
        <h1> {Preact.string("Movie Night")} </h1>
      </a>
      <a href="/search" title="search">
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
    </navigation>
  </div>

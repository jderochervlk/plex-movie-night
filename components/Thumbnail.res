@jsx.component
let make = (~title, ~thumb) => <img title alt=title src={Plex.getThumb(thumb)} class="w-15" />

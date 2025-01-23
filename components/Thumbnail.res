@jsx.component
let make = (~title, ~thumb, ~index) =>
  <img loading={index > 5 ? #lazy : #eager} title alt=title src={Plex.getThumb(thumb)} />

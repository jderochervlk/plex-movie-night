type t = {}

@jsx.component
type props = {@as("Component") component: Jsx.component<t>}
let make = props => {
  <html lang="en">
    <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <meta name="robots" content="noindex" />
      <title> {"Movie Night"->Preact.string} </title>
      <link rel="stylesheet" href="/styles.css" />
    </head>
    <body> {props.component({})} </body>
  </html>
}

let default = make

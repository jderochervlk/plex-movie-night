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
    <body class="bg-slate-800 text-slate-50">
      <header class="py-2 mx-auto bg-blue-900">
        <div class="max-w-screen-md mx-auto flex flex-col items-center justify-center">
          <a href="/">
            <h1 class="text-2xl font-bold"> {"Movie Night"->Preact.string} </h1>
          </a>
        </div>
      </header>
      <main className="max-width=[1700px] m-auto p-4 text-lg "> {props.component({})} </main>
    </body>
  </html>
}

let default = make

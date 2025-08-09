// import { Head } from "$fresh/runtime.ts";

@jsx.component
let make = () => {
  <>
    <Fresh.Head>
      <title> {"404 - Page not found"->Preact.string} </title>
    </Fresh.Head>
    <div>
      <div>
        <img
          src="/logo.svg"
          width="128"
          height="128"
          alt="the Fresh logo: a sliced lemon dripping with juice"
        />
        <h1> {"404 - Page not found"->Preact.string} </h1>
        <p> {"The page you were looking for doesn't exist."->Preact.string} </p>
        <a href="/"> {"Go back home"->Preact.string} </a>
      </div>
    </div>
  </>
}

let default = make

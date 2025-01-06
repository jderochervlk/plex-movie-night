// import { Head } from "$fresh/runtime.ts";

@jsx.component
let make = () => {
  <>
    <Fresh.Head>
      <title> {"404 - Page not found"->Preact.string} </title>
    </Fresh.Head>
    <div class="px-4 py-8 mx-auto bg-[#86efac]">
      <div class="max-w-screen-md mx-auto flex flex-col items-center justify-center">
        <img
          class="my-6"
          src="/logo.svg"
          width="128"
          height="128"
          alt="the Fresh logo: a sliced lemon dripping with juice"
        />
        <h1 class="text-4xl font-bold"> {"404 - Page not found"->Preact.string} </h1>
        <p class="my-4"> {"The page you were looking for doesn't exist."->Preact.string} </p>
        <a href="/" class="underline"> {"Go back home"->Preact.string} </a>
      </div>
    </div>
  </>
}

let default = make

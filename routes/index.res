@jsx.component
let make = () => {
  let count = Signal.useSignal(3)
  <div class="px-4 py-8 mx-auto bg-[#86efac]">
    <div class="max-w-screen-md mx-auto flex flex-col items-center justify-center">
      <img
        class="my-6"
        src="/logo.svg"
        width="128"
        height="128"
        alt="the Fresh logo: a sliced lemon dripping with juice"
      />
      <h1 class="text-4xl font-bold"> {"Welcome to Fresh"->Preact.string} </h1>
      <p class="my-4">
        {"Try updating this message in the"->Preact.string}
        <code class="mx-2"> {"./routes/index.tsx"->Preact.string} </code>
        {" file, and refresh."->Preact.string}
      </p>
      <Counter count={count} />
    </div>
  </div>
}

let default = make

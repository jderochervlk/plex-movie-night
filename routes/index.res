let handler: Fresh.Handler.t<unknown, unknown, unknown> = {
  get: Login.authCheck,
}

@jsx.component
let make = () => {
  <main>
    <div class="px-4 py-8 mx-auto bg-[#86efac]">
      <div class="max-w-screen-md mx-auto flex flex-col items-center justify-center">
        <h1 class="text-4xl font-bold"> {"Movie Night"->Preact.string} </h1>
      </div>
    </div>
    <div class="px-4 py-8 mx-auto text-center">
      <NameForm />
    </div>
    <div class="px-4 py-8 mx-auto">
      <Movies />
    </div>
  </main>
}

let default = make

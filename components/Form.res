@jsx.component
let make = (~children, ~action) => {
  <div class="w-full flex items-center">
    <div class="text-left mt-20 min-w-[80vw] p-5 m-auto bg-green-900 text-white text-xl rounded-lg">
      <form method="post" action class="grid grid-flow-row gap-4 min-w-xl">
        {children}
        <button
          class="bg-green-200 text-green-900 p-2 rounded-sm hover:bg-green-100 transition-colors"
          type_="submit">
          {Preact.string("Submit")}
        </button>
      </form>
    </div>
  </div>
}

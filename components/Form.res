@jsx.component
let make = (~children, ~action) => {
  <div className="w-full flex items-center">
    <div
      className="text-left mt-20 min-w-[80vw] p-5 m-auto bg-blue-900 text-white text-xl rounded-lg">
      <form method="post" action className="grid grid-flow-row gap-4 min-w-xl">
        {children}
        <button
          className="bg-blue-200 text-blue-900 p-2 rounded-sm hover:bg-blue-100 transition-colors"
          type_="submit">
          {Preact.string("Submit")}
        </button>
      </form>
    </div>
  </div>
}

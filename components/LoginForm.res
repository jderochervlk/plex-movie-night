@jsx.component
let make = () => {
  <div className="w-full flex items-center">
    <div className="text-left mt-20 p-3 max-w-md m-auto bg-blue-900 text-white text-xl rounded-lg">
      <form method="post" action="/api/login" className="grid grid-flow-row gap-4">
        <label
        /* todo: doesn't have for as a prop, I'll need to add it to my Preact bindings */
        >
          {"password"->Preact.string}
        </label>
        <input type_="password" name="password" className="rounded-sm text-black" />
        <button
          className="bg-blue-200 text-blue-900 p-2 rounded-sm hover:bg-blue-100 transition-colors"
          type_="submit">
          {Preact.string("Submit")}
        </button>
      </form>
    </div>
  </div>
}

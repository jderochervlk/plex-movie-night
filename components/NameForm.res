@jsx.component
let make = () => {
  <div class="w-full flex items-center">
    <form
      method="post"
      action="/api/name"
      class="card m-auto bg-neutral text-primary-content px-10 pt-5 pb-10 mt-30 shadow-lg min-w-sm">
      <label /* todo: doesn't have for as a prop, I'll need to add it to my Preact bindings */>
        {"Select your name"->Preact.string}
      </label>
      <select name="name" class="select select-primary my-4">
        {Env.names()
        ->Array.map(name => <option value=name> {Preact.string(name)} </option>)
        ->Preact.array}
      </select>
      <button class="btn btn-secondary w-full" type_="submit"> {Preact.string("Submit")} </button>
    </form>
  </div>
}

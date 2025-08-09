@jsx.component
let make = () => {
  <div class="w-full flex items-center">
    <form method="post" action="/api/name" class="form-card">
      <label \"for"="name"> {"Select your name"->Preact.string} </label>
      <select name="name">
        {Env.names()
        ->Array.map(name => <option value=name> {Preact.string(name)} </option>)
        ->Preact.array}
      </select>
      <button type_="submit"> {Preact.string("Submit")} </button>
    </form>
  </div>
}

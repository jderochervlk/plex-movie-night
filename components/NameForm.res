@jsx.component
let make = () => {
  <Form action="/api/name">
    <label /* todo: doesn't have for as a prop, I'll need to add it to my Preact bindings */>
      {"Select your name"->Preact.string}
    </label>
    <select name="name" class="select select-primary my-4">
      {Env.names()
      ->Array.map(name => <option value=name> {Preact.string(name)} </option>)
      ->Preact.array}
    </select>
  </Form>
}

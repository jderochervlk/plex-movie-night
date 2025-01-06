@jsx.component
let make = () => {
  <form method="post" action="/api/login">
    <label> {"password"->Preact.string} </label>
    <input type_="password" name="password" />
    <button type_="submit"> {Preact.string("Submit")} </button>
  </form>
}

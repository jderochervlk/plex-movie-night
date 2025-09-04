module Alert = {
  @jsx.component
  let make = () =>
    <div role="alert" class="alert">
      <span> {Preact.string("Wrong password!")} </span>
    </div>
}

@jsx.component
let make = (~error: string) => {
  let wrongPassword = switch error {
  | "wrong-password" => true
  | _ => false
  }

  <form fClientNav=false method="post" action="/api/login" class="form-card">
    {wrongPassword ? <Alert /> : Preact.null}
    <label \"for"="password"> {"password"->Preact.string} </label>
    <input type_="password" name="password" class="my-1" />
    <button type_="submit"> {Preact.string("Submit")} </button>
  </form>
}

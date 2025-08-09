module Alert = {
  @jsx.component
  let make = () =>
    <div role="alert" class="alert">
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth="2"
          d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"
        />
      </svg>
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

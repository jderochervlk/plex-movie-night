module Alert = {
  @jsx.component
  let make = () =>
    <div role="alert" class="alert alert-error">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        class="h-6 w-6 shrink-0 stroke-current"
        fill="none"
        viewBox="0 0 24 24">
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
  <div class="w-full flex items-center">
    <form
      fClientNav=false
      method="post"
      action="/api/login"
      class="card m-auto bg-neutral text-primary-content px-10 pt-5 pb-10 mt-30 shadow-lg min-w-sm">
      {wrongPassword ? <Alert /> : Preact.null}
      <label
        class="text-lg input input-primary my-5"
        /* todo: doesn't have for as a prop, I'll need to add it to my Preact bindings */
      >
        <span class="label bg"> {"password"->Preact.string} </span>
        <input type_="password" name="password" class="my-1" />
      </label>
      <button class="btn btn-secondary w-full" type_="submit"> {Preact.string("Submit")} </button>
    </form>
  </div>
}

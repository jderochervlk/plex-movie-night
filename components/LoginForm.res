@jsx.component
let make = () => {
  <div class="w-full flex items-center">
    <div class="card m-auto bg-neutral text-primary p-10 mt-30 shadow-lg">
      <form method="post" action="/api/login" class="">
        <fieldset class="fieldset">
          // <legend class="fieldset-legend"> {"password"->Preact.string} </legend>
          <label
          /* todo: doesn't have for as a prop, I'll need to add it to my Preact bindings */
          >
            {"password"->Preact.string}
          </label>
          <input type_="password" name="password" class="input input-primary" />
        </fieldset>
        <button class="btn btn-primary" type_="submit"> {Preact.string("Submit")} </button>
      </form>
    </div>
  </div>
}

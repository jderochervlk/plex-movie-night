@jsx.component
let make = (~children, ~action) => {
  <div class="w-full flex items-center">
    <div class="card m-auto bg-neutral text-primary p-10 mt-30 shadow-lg">
      <form method="post" action>
        {children}
        <button class="btn btn-primary" type_="submit"> {Preact.string("Submit")} </button>
      </form>
    </div>
  </div>
}

module P = {
  @jsx.component
  let make = (~children, ~class="") => <p class> {children->Preact.string} </p>
}

module H1 = {
  @jsx.component
  let make = (~children, ~class="") => <h1 class> {children->Preact.string} </h1>
}

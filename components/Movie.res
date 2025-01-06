@jsx.component
let make = (~name, ~checked) => {
  <div>
    {name->Preact.string}
    <input type_="checkbox" checked={checked} />
  </div>
}

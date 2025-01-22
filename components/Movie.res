@jsx.component
let make = (~title, ~summary, ~wantToWatch=false) => {
  <div>
    <h2 className="text-3xl text-center m-3"> {title->Preact.string} </h2>
    <p> {Preact.string(summary)} </p>
    // <input type_="checkbox" checked={wantToWatch} />
  </div>
}

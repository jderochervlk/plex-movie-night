@jsx.component
let make = (~title, ~summary, ~wantToWatch=false, ~thumb) => {
  <div class="max-w-[1400px] m-auto">
    <h2 className="text-3xl text-center m-3"> {title->Preact.string} </h2>
    <Thumbnail thumb title />
    <p> {Preact.string(summary)} </p>
    // <input type_="checkbox" checked={wantToWatch} />
  </div>
}

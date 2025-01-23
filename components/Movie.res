@jsx.component
let make = (~title, ~summary, ~wantToWatch=false, ~thumb) => {
  <div class="max-w-[900px] m-auto">
    <h2 className="text-3xl text-center m-3"> {title->Preact.string} </h2>
    <div class="grid grid-flow-col gap-4">
      <Thumbnail thumb title />
      <p> {Preact.string(summary)} </p>
    </div>
    // <input type_="checkbox" checked={wantToWatch} />
  </div>
}

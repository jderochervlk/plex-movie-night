@jsx.component
let make = (~title, ~summary, ~wantToWatch="false", ~thumb, ~ratingKey, ~name) => {
  <div class="max-w-[900px] m-auto">
    <h2 className="text-3xl text-center m-3">
      {Preact.string(`${title}${wantToWatch === "true" ? "✔️" : ""}`)}
    </h2>
    <div class="grid grid-flow-col gap-4 mb-6">
      <Thumbnail thumb title index=1 />
      <p> {Preact.string(summary)} </p>
    </div>
    <div class="grid grid-flow-col gap-4 mb-6">
      // Critic scores?
      <img />
      <input name="ratingKey" type_="hidden" value={ratingKey->Int.toString} />
      <input
        name="wantToWatch"
        type_="hidden" /* we want to invert the value on button press */
        value={wantToWatch === "true" ? "false" : "true"}
      />
      <Toggle wantToWatch name ratingKey={ratingKey->Int.toString} />
    </div>
    // Cast circles
    // crew details
  </div>
}

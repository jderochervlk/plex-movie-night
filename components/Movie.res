@jsx.component
let make = (~title, ~summary, ~wantToWatch="false", ~thumb, ~ratingKey) => {
  let _ = Console.log2(2, wantToWatch)
  <div class="max-w-[900px] m-auto">
    <h2 className="text-3xl text-center m-3">
      {Preact.string(`${title}${wantToWatch === "true" ? "✔️" : ""}`)}
    </h2>
    <div class="grid grid-flow-col gap-4 mb-6">
      <Thumbnail thumb title />
      <p> {Preact.string(summary)} </p>
    </div>
    <div class="grid grid-flow-col gap-4 mb-6">
      // Critic scores?
      <img />
      <form method="post">
        <input name="ratingKey" type_="hidden" value={ratingKey->Int.toString} />
        <input
          name="wantToWatch"
          type_="hidden" /* we want to invert the value on button press */
          value={wantToWatch === "true" ? "false" : "true"}
        />
        <button
          class={`rounded-lg p-4 ${wantToWatch === "true" ? "bg-red-900" : "bg-blue-900"}`}
          type_="submit">
          {Preact.string(wantToWatch === "true" ? "Remove from watchlist" : "Add movie")}
        </button>
      </form>
    </div>
    // Cast circles
    // crew details
  </div>
}

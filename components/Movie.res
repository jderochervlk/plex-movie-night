@jsx.component
let make = (~title, ~summary, ~wantToWatch="false", ~thumb, ~ratingKey) => {
  <section class="max-w-(--breakpoint-lg) prose m-auto">
    <div class="min-h-[300px]">
      <h2> {Preact.string(title)} </h2>
      <img
        src={`/api/thumb/${title}.jpeg?thumb=${thumb}`}
        class="object-contain h-[250px] float-right ml-4 mb-1 rounded-lg md:h-[350px]"
      />
      // Critic scores?
      <p> {Preact.string(summary)} </p>
    </div>
    <form method="post" class="w-fill mt-6 text-center" fClientNav=false>
      <input name="ratingKey" type_="hidden" value={ratingKey->Int.toString} />
      <input
        name="wantToWatch"
        type_="hidden" /* we want to invert the value on button press */
        value={wantToWatch === "true" ? "false" : "true"}
      />
      <button
        class={`btn btn-wide ${wantToWatch === "true" ? "btn-error" : "btn-neutral"}`}
        type_="submit">
        {Preact.string(wantToWatch === "true" ? "Remove from watchlist" : "Add to watchlist")}
      </button>
    </form>
  </section>
  // Cast circles
  // crew details
}

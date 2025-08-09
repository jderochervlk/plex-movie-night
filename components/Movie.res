@jsx.component
let make = (~title, ~summary, ~wantToWatch="false", ~thumb, ~ratingKey) => {
  <section class="movie-details">
    <div>
      <h2> {Preact.string(title)} </h2>
      <img src={`/api/thumb/${title}.jpeg?thumb=${thumb}`} />
      // Critic scores?
      <p> {Preact.string(summary)} </p>
    </div>
    <form method="post" fClientNav=false>
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

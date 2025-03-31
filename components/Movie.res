@jsx.component
let make = (~title, ~summary, ~wantToWatch="false", ~thumb, ~ratingKey) => {
  <section class="max-w-(--breakpoint-lg) m-auto text-base-content">
    <div class="mb-8">
      <img
        src={`/api/thumb/${title}.jpeg?thumb=${thumb}`}
        class="object-contain h-[250px] float-right ml-4 mb-1 rounded-lg md:h-[350px]"
      />
      <h2 class="text-2xl m-3 md:text-3xl font-bold"> {Preact.string(title)} </h2>
      // Critic scores?
      <p class="item-body px-2"> {Preact.string(summary)} </p>
    </div>
    <form method="post" class="w-fill mt-6" fClientNav=false>
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

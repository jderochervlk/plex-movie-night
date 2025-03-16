@jsx.component
let make = (~title, ~summary, ~wantToWatch="false", ~thumb, ~ratingKey) => {
  <div class="max-w-[900px] m-auto">
    <h2 class="text-3xl text-center m-3"> {Preact.string(title)} </h2>
    <div class="content">
      <img
        src={thumb->Plex.getThumb} class="object-contain h-[250px] float-right ml-4 rounded-lg"
      />
      <p class="item-body px-2"> {Preact.string(summary)} </p>
    </div>
    <div class="">
      // Critic scores?
      <form method="post" class="w-fill mt-4 text-center">
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

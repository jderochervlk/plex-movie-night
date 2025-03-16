let handleClick = async (~ratingKey, ~wantToWatch, ~name) => {
  Console.log("foo")
  await User.toggleMovie(~name, ~ratingKey, ~wantToWatch)
}

@jsx.component
let make = (~wantToWatch, ~name, ~ratingKey) => {
  let (watch, setWatch) = Preact.useState(() => wantToWatch)

  <button
    class={`rounded-lg p-4 ${watch === "true" ? "bg-red-900" : "bg-blue-900"}`}
    onClick={_ => {
      let _ = handleClick(~ratingKey, ~wantToWatch=watch, ~name)
    }}>
    {Preact.string(watch === "true" ? "Remove from watchlist" : "Add movie")}
  </button>
}

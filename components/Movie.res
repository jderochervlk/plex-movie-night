type t = {name: string, wantToWatch: bool}

@jsx.component
let make = (~movie: t) => {
  <div>
    {movie.name->Preact.string}
    <input type_="checkbox" checked={movie.wantToWatch} />
  </div>
}

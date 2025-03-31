@react.component
let make: (
  ~title: string,
  ~thumb: string,
  ~index: int,
  ~wantToWatch: bool,
  ~aboveTheFold: bool,
) => Jsx.element

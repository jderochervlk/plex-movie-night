@react.component
let make: (
  ~title: string,
  ~summary: string,
  ~wantToWatch: string=?,
  ~thumb: string,
  ~ratingKey: int,
) => Jsx.element

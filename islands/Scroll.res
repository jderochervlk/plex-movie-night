type sessionStorage = {
  getItem: string => option<string>,
  setItem: (string, string) => unit,
}

external sessionStorage: sessionStorage = "sessionStorage"

@jsx.component
let make = () => {
  Preact.useEffect(() => {
    let page = location.pathname
    let scrollPosition =
      sessionStorage.getItem(`scroll-position-${page}`)
      ->Option.flatMap(Float.fromString)
      ->Option.getOr(0.0)

    scrollTo(~options={top: scrollPosition, behavior: Instant})

    Some(
      () => {
        sessionStorage.setItem(`scroll-position-${page}`, scrollY->Float.toString)
      },
    )
  }, [])
  Preact.null
}

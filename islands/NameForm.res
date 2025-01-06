open WebAPI.Storage

let get = () => localStorage->getItem("name")
let set = name => localStorage->setItem(~key="name", ~value=name)

@jsx.component
let make = () => {
  let (name, setName) = Preact.useState((): option<string> => None)

  if Fresh.is_browser {
    switch name {
    | Some("__loading__") => Preact.null
    | Some(name) => <p> {`Hello ${name}`->Preact.string} </p>
    | None =>
      <form
        onSubmit={e => {
          e->JsxEvent.Form.preventDefault
          let formData = e->JsxEvent.Form.currentTarget->Utils.FormData.make
          let name = formData->Utils.FormData.get("name")
          setName(_ => Some(name))
          set(name)
        }}>
        <label> {"What's your name?"->Preact.string} </label>
        <input type_="text" name="name" />
        <button type_="submit"> {"submit"->Preact.string} </button>
      </form>
    }
  } else {
    Preact.null
  }
}

let default = make

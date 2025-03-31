type props = {
  ...JsxDOM.domProps,
}

let make = props => {
  <button {...props} disabled={!Fresh.is_browser} class="btn" />
}

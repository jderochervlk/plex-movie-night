@jsx.component
type props = {
  ...JsxDOM.domProps,
}
let make = props => {
  <button
    {...props}
    disabled={!Fresh.is_browser}
    class="px-2 py-1 border-gray-500 border-2 rounded bg-white hover:bg-gray-200 transition-colors"
  />
}

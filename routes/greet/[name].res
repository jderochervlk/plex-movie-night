type params = {name: string}
@jsx.component
let make = (~params: params) => {
  <div> {`Hello ${params.name}`->Preact.string} </div>
}

let default = make

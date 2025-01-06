@jsx.component
let make = (~count: Signal.t<'int>) => {
  <div class="flex gap-8 py-6">
    <Button onClick={_ => count.value = count.value - 1}> {"-1"->Preact.string} </Button>
    <p class="text-3xl tabular-nums"> {count.value->Int.toString->Preact.string} </p>
    <Button onClick={_ => count.value = count.value + 1}> {"+1"->Preact.string} </Button>
  </div>
}

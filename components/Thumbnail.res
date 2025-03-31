@jsx.component
let make = (~title, ~thumb, ~index, ~wantToWatch: bool) => {
  <>
    <img
      loading={index > 5 ? #lazy : #eager}
      title
      alt=title
      src={`/api/thumb/${title}.jpeg?thumb=${thumb}`}
      class="object-cover rounded-md w-full h-full"
    />
    {wantToWatch
      ? {
          <>
            <div
              class="
                  flex items-end justify-center p-2
                  w-full
                  inset-0 rounded-md h-[150px] relative mt-[-150px]
                  bg-linear-to-t from-green-800  from-20% via-30% to-transparent to-80%">
              {Preact.string("on watchlist")}
            </div>
          </>
        }
      : Preact.null}
  </>
}

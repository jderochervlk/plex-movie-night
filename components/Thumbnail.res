@jsx.component
let make = (~title, ~thumb, ~index, ~wantToWatch: bool) => {
  <>
    <div class="relative w-full">
      <img
        loading={index > 5 ? #lazy : #eager}
        title
        alt=title
        src={Plex.getThumb(thumb)}
        className="object-cover rounded-md w-full"
      />
      {wantToWatch
        ? {
            <>
              <div
                class="absolute inset-0 flex items-center justify-center bg-gray-500 opacity-80 rounded-md">
                <h2 class="text-white text-3xl font-bold text-center">
                  {Preact.string("✔️")}
                </h2>
              </div>
            </>
          }
        : Preact.null}
    </div>
  </>
}

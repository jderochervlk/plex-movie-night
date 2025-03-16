@jsx.component
let make = (~title, ~thumb, ~index, ~wantToWatch: bool) => {
  <>
    <div class="relative">
      <img
        loading={index > 5 ? #lazy : #eager}
        title
        alt=title
        src={Plex.getThumb(thumb)}
        className="object-cover rounded-md"
      />
      {wantToWatch
        ? {
            <>
              <div class="absolute inset-0 bg-gray-700 opacity-60 rounded-md" />
              <div class="absolute inset-0 flex items-center justify-center">
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

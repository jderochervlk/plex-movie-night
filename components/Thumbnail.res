@jsx.component
let make = (~title, ~thumb, ~index, ~wantToWatch: bool) => {
  <>
    <div class="relative w-full rounded-lg">
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
                class="
                inset-0 flex items-center justify-center opacity-80 rounded-md h-[75px] relative mt-[-75px]
                bg-gradient-to-t from-gray-700 from-10% via-30% to-transparent to-90%">
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

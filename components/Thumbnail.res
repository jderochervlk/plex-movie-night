let aspectRatio = `${Plex.imgWidth->Int.toString}/${Plex.imgHeight->Int.toString}`

@jsx.component
let make = (~title, ~thumb, ~index, ~wantToWatch: bool, ~aboveTheFold) => {
  let loading: Preact.Elements.props = {
    if aboveTheFold && index < 6 {
      {loading: #eager}
    } else {
      {}
    }
  }
  <>
    <img
      {...loading}
      title
      alt=title
      style={{
        aspectRatio: aspectRatio,
      }}
      src={Plex.Api.getThumb(thumb)}
      fetchPriority={index < 15 && aboveTheFold ? #high : #auto}
    />
    {wantToWatch
      ? <svg
          xmlns="http://www.w3.org/2000/svg"
          x="0px"
          y="0px"
          width="35"
          height="35"
          viewBox="0 0 24 24"
          style={fill: "rgb(65, 119, 78)", background: "white", borderRadius: "50%"}>
          <path
            d="M 12 2 C 6.4830714 2 2 6.4830754 2 12 C 2 17.516925 6.4830714 22 12 22 C 17.516929 22 22 17.516925 22 12 C 22 6.4830754 17.516929 2 12 2 z M 16.498047 9 C 16.626047 9 16.754063 9.0489844 16.851562 9.1464844 C 17.046563 9.3414844 17.048516 9.6575156 16.853516 9.8535156 L 10.853516 15.853516 C 10.755516 15.950516 10.628 16 10.5 16 C 10.372 16 10.244484 15.950516 10.146484 15.853516 L 7.1464844 12.853516 C 6.9514844 12.658516 6.9514844 12.341484 7.1464844 12.146484 C 7.3414844 11.951484 7.6585156 11.951484 7.8535156 12.146484 L 10.498047 14.792969 L 16.144531 9.1464844 C 16.242031 9.0489844 16.370047 9 16.498047 9 z"
          />
        </svg>
      : Preact.null}
  </>
}

open WebAPI

let handler = Fresh.Handler.make({
  post: async (req: FetchAPI.request, _ctx) => {
    let data = await req->Request.formData
    let name = data->FormData.get2("name")
    switch await Utils.isAuthenticated(req) {
    | true => {
        let _ = User.createAllUsers()

        let headers = Headers.make()
        headers->Headers.set(~name="location", ~value="/")
        headers->Std.Http.Cookies.set({
          name: "name",
          value: name,
          expires: Utils.sixMonthsFromNow(),
          sameSite: "Lax",
          domain: req->Utils.getHostname,
          path: "/",
          secure: true,
        })
        let headers = HeadersInit.fromHeaders(headers)
        Response.make2(~init={status: 303, headers})
      }
    | false => Response.make2(~init={status: 403})
    }
  },
})

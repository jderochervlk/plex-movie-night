open WebAPI

@live
let handler = Fresh.Handler.make({
  post: async (req: FetchAPI.request, _ctx) => {
    let name = await req->Request.formData->Promise.thenResolve(FormData.get(_, "name"))
    switch await Utils.isAuthenticated(req) {
    | true => {
        let users = await User.createAllUsers()
        Console.debug2("api/name creating all users", users)
        let headers = Headers.make()
        headers->Headers.set(~name="location", ~value=Utils.getRootUrl(req.url))
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
        Response.fromNull(~init={status: 303, headers})
      }
    | false => Response.fromNull(~init={status: 403})
    }
  },
})

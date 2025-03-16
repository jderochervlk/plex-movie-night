import * as Preact from "preact";

//#region routes/_app.mjs
function make(props) {
	return Preact.h("html", {
		children: [Preact.h("head", { children: [
			Preact.h("meta", { charset: "utf-8" }),
			Preact.h("meta", {
				content: "width=device-width, initial-scale=1.0",
				name: "viewport"
			}),
			Preact.h("meta", {
				content: "noindex",
				name: "robots"
			}),
			Preact.h("title", { children: "Movie Night" }),
			Preact.h("link", {
				href: "/styles.css",
				rel: "stylesheet"
			})
		] }), Preact.h("body", {
			children: [Preact.h("header", {
				children: Preact.h("div", {
					children: Preact.h("a", {
						children: Preact.h("h1", {
							children: "Movie Night",
							class: "text-xl font-bold"
						}),
						href: "/"
					}),
					class: "max-w-screen-md mx-auto flex flex-col items-center justify-center"
				}),
				class: "py-2 mx-auto bg-blue-900"
			}), Preact.h("main", {
				children: props.Component({}),
				className: "max-width=[1700px] m-auto p-4 text-lg "
			})],
			class: "bg-slate-800 text-slate-50"
		})],
		lang: "en"
	});
}
let $$default = make;

//#endregion
export { $$default as default, make };
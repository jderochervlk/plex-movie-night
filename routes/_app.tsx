import { Partial } from "$fresh/runtime.ts";
import { PageProps } from "$fresh/server.ts";
import { make as Header } from "../components/Header.mjs";

export default function ({ Component }: PageProps) {
  return (
    <html lang="en">
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta name="robots" content="noindex" />
        <title>Movie Night</title>
        <link rel="stylesheet" href="/styles.css" />
      </head>
      <body class="bg-slate-800 text-slate-50">
        <Partial name="body">
          <Header />
          <main class="max-width=[1700px] m-auto p-4 text-lg ">
            {/* <Partial name="main"> */}
            <Component />
            {/* </Partial> */}
          </main>
        </Partial>
      </body>
    </html>
  );
}

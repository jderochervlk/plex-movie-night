import { Partial } from "$fresh/runtime.ts";
import { PageProps } from "$fresh/server.ts";
import { make as Header } from "../components/Header.mjs";
import { make as Layout } from "../components/Layout.mjs";
import { Scroll } from "../islands/Scroll.tsx";

export default function ({ Component }: PageProps) {
  return (
    // nord is a nice light theme
    // TODO: add theme switch
    <html lang="en" data-theme="business">
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta name="robots" content="noindex" />
        <title>Movie Night</title>
        <link rel="stylesheet" href="/styles.css" />
      </head>
      <body f-client-nav class="w-full">
        <Partial name="body">
          <Header />
          <Scroll />
          <Layout>
            <Partial name="main">
              <Component />
            </Partial>
          </Layout>
        </Partial>
      </body>
    </html>
  );
}

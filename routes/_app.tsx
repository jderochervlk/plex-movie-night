import { PageProps } from "$fresh/server.ts";

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
        <header class="py-2 mx-auto bg-blue-900">
          <div class="max-w-screen-md mx-auto flex flex-col items-center justify-center">
            <a href="/">
              <h1 class="text-xl font-bold">Movie Night</h1>
            </a>
          </div>
        </header>
        <main class="max-width=[1700px] m-auto p-4 text-lg ">
          <Component />
        </main>
      </body>
    </html>
  );
}

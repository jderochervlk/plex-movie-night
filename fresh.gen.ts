// DO NOT EDIT. This file is generated by Fresh.
// This file SHOULD be checked into source version control.
// This file is automatically updated during development when running `dev.ts`.

import * as $_404 from "./routes/_404.mjs";
import * as $_app from "./routes/_app.mjs";
import * as $api_login from "./routes/api/login.mjs";
import * as $api_name from "./routes/api/name.mjs";
import * as $index from "./routes/index.mjs";
import * as $movie_ratingKey_ from "./routes/movie/[ratingKey].mjs";
import * as $setname from "./routes/setname.mjs";
import * as $signin from "./routes/signin.mjs";

import type { Manifest } from "$fresh/server.ts";

const manifest = {
  routes: {
    "./routes/_404.mjs": $_404,
    "./routes/_app.mjs": $_app,
    "./routes/api/login.mjs": $api_login,
    "./routes/api/name.mjs": $api_name,
    "./routes/index.mjs": $index,
    "./routes/movie/[ratingKey].mjs": $movie_ratingKey_,
    "./routes/setname.mjs": $setname,
    "./routes/signin.mjs": $signin,
  },
  islands: {},
  baseUrl: import.meta.url,
} satisfies Manifest;

export default manifest;

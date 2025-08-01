/// <reference no-default-lib="true" />
/// <reference lib="dom" />
/// <reference lib="dom.iterable" />
/// <reference lib="dom.asynciterable" />
/// <reference lib="deno.ns" />
/// <reference lib="deno.unstable" />

import "$std/dotenv/load.ts";

import { start } from "$fresh/server.ts";
import manifest from "./fresh.gen.ts";
import config from "./fresh.config.ts";

const kv = await Deno.openKv();

const s: Deno.KvCommitResult = await kv.set(["foo"], "bar");

const val = await kv.get(["foo"]);

console.log(val);

await start(manifest, config);

import { bundle } from "jsr:@jotsr/smart-css-bundler";

bundle(["./static/styles.css"], {
  bundleDir: "./css",
  assetDir: "./static",
  cacheDir: "./cache",
  dev: false,
});

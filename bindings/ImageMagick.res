type img = {
  resize: (int, int) => unit,
  write: (string, Uint8Array.t => promise<Uint8Array.t>) => promise<ArrayBuffer.t>,
}
type imageMagick = {read: (Uint8Array.t, img => promise<ArrayBuffer.t>) => promise<Uint8Array.t>}

@module("https://deno.land/x/imagemagick_deno/mod.ts")
external initialize: unit => promise<unit> = "initialize"

@module("https://deno.land/x/imagemagick_deno/mod.ts")
external imageMagick: imageMagick = "ImageMagick"

type format = {@as("WebP") webp: string}

@module("https://deno.land/x/imagemagick_deno/mod.ts")
external magickFormat: format = "MagickFormat"

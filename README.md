# Plex Movie Night

[![Made with Fresh](https://fresh.deno.dev/fresh-badge.svg)](https://fresh.deno.dev)

[![Deploy](https://github.com/jderochervlk/plex-movie-night/actions/workflows/deploy.yml/badge.svg)](https://github.com/jderochervlk/plex-movie-night/actions/workflows/deploy.yml)

An app to see what movies your friends want to watch that you have on your Plex
server.

Built with Deno, ReScript, Fresh, and deployed on Deno Deploy.

<img width="200" src="https://github.com/user-attachments/assets/08a508f1-8293-486b-80ff-2aa0950559e4" />
<img width="200" src="https://github.com/user-attachments/assets/91ab8b35-f5d6-4529-bb75-090bceb5d0d8" />
<img width="200" src="https://github.com/user-attachments/assets/e5b7c92b-9a0d-46c6-9dca-34a0738d8394" />
<img width="200" src="https://github.com/user-attachments/assets/226637d5-9ff7-463a-bf1f-887b654e9b23" />
<img width="200" src="https://github.com/user-attachments/assets/8c272c07-d108-4159-890a-29da33cfaaf4" />
<img width="200" src="https://github.com/user-attachments/assets/4bf5acf3-1268-4478-9a85-877d1402fa76" />

## How to host your own version

This requires some tech knowledge to do and I expect you can find the relevent
documentation, but here are the basic steps.

Fork this repository and set up a free acount on Deno deploy and setup the repo
as a project.

https://deno.com/deploy

The free tier will be more than enough for this app unless you have hundreds of
people using it.

Add these environment variables:

```
PASSWORD= the password users will enter when getting to the app
TOKEN= generate something random and complex, this is used as the auth cookie to check against the server. You might want to rotate this. Hopefully I get a real auth setup soon :)
PLEX_TOKEN= https://support.plex.tv/articles/204059436-finding-an-authentication-token-x-plex-token/
PLEX_SERVER= url to your plex server. It needs to be accessible outside of your network. I have cloudflare using a domain to point to my server.
NAMES= the names of the people using this app, for example: Josh,Logan,Bob
```

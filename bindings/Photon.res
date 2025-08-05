type t
type photonImage = {new_from_blob: WebAPI.FileAPI.blob => t}
type photon = {@as("PhotonImage") photonImage: photonImage}

@module("npm:@silvia-odwyer/photon-node")
external photon: photon = "default"

@send
external fromBlob: (photon, WebAPI.FileAPI.blob) => t = "PhotonImage.new_from_blob"

@send
external getBase64: t => string = "get_base64"

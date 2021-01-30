{ stdenv, fetchurl }:
stdenv.mkDerivation {
  name = "rust-analyzer-nightly";
  src = fetchurl {
    url = "https://github.com/rust-analyzer/rust-analyzer/releases/download/nightly/rust-analyzer-linux";
    sha256 = "06d75c8xdwvm9hb5lybz9jlhws0s473n6ikjnv32zp2kc7b747m9";
  };
  phases = [ "buildPhase" "installPhase" ];
  buildPhase = ''
    cp $src rust-analyzer
    chmod +wx rust-analyzer
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" rust-analyzer
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp rust-analyzer $out/bin/rust-analyzer
  '';
}

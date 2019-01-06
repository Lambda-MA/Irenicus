{ nixpkgs ? import <nixpkgs> {}
, ghc ? nixpkgs.ghc
}:

with nixpkgs;

let
  hie-nix = (import (fetchFromGitHub {
    owner = "domenkozar";
    rev = "19f47e0bf2e2f1a793bf87d64bf8266062f422b1";
    repo = "hie-nix";
    sha256 = "1px146agwmsi0nznc1zd9zmhgjczz6zlb5yf21sp4mixzzbjsasq";
  }) {}).hie86;
in
haskell.lib.buildStackProject {
  inherit ghc;

  name = "haskell-env";

  buildInputs = [
    zlib
    hie-nix
    hlint
    haskellPackages.hindent
    haskellPackages.ghcid
    #haskellPackages.ghc-mod
    #haskellPackages.stylish-haskell
  ];

  shellHooks = ''
    alias stack="\stack --nix"
  '';
}

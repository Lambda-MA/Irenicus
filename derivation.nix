{
  lib,
  pkgs ? import <nixpkgs> {},
  ghc ? pkgs.ghc
}:

with pkgs;

haskell.lib.buildStackProject {
  inherit ghc;

  name = "telegram-bot";
  version = "0.0.0.1";

  src = ./.;

  buildInputs = [
    zlib
  ];

  meta = {
    description = "A Telegram bot for our local community.";
    maintainers = with lib.maintainers; [
      mschonfinkel
    ];
  };
}

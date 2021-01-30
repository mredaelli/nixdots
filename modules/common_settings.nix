{ config, pkgs, options, ... }:
let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
in
{
  nix.nixPath =
    options.nix.nixPath.default ++
    [ "nixpkgs-overlays=/etc/nixos/nixdots/overlays-compat/" ]
  ;
  documentation = {
    doc.enable = false;
    info.enable = false;
  };
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "it_IT.UTF-8/UTF-8" ];

  imports = [
    ../cachix.nix
  ];

  nixpkgs.overlays = [
    moz_overlay
    (self: super: with super; {
      my-rust-analyzer = callPackage ../packages/rust-analyzer-nightly.nix { };
      stylua = callPackage ../packages/stylua.nix { };
      efm = callPackage ../packages/efm.nix { };
    })
  ];

  nixpkgs.config = baseConfig // {
    allowUnfree = true;
    pulseaudio = true;

    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };
      jre = pkgs.jdk11;
      notmuch = pkgs.notmuch.override {
        withEmacs = false;
      };
    };
  };

  console.useXkbConfig = true;

  time.timeZone = "Europe/Rome";

  security.sudo.wheelNeedsPassword = false;

  services = {
    openssh = {
      enable = true;
      permitRootLogin = "no";
    };
  };
}

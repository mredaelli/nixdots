{ config, pkgs, options, ... }:
{
  nix.nixPath =
    options.nix.nixPath.default ++
    [ "nixpkgs-overlays=/etc/nixos/overlays-compat/" ]
  ;
  documentation = {
    doc.enable = false;
    info.enable = false;
  };
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "it_IT.UTF-8/UTF-8" ];

  imports = [
    ../hardware-configuration.nix
    ../cachix.nix
  ];

  nixpkgs.config = {
    pulseaudio = true;

    packageOverrides = pkgs: {
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

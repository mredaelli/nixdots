{ config, pkgs, options, ... }:
let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common_settings.nix
    ../../modules/basic.nix
    ../../modules/wayland.nix
    ../../modules/workstation.nix
    ../../modules/user.nix
    ../../modules/bluetooth.nix
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/x1"
  ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

  networking = {
    hostName = "gimli";
    networkmanager.enable = true;
    firewall.enable = false;
  };

   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.vboxusers.members = [ "turing" ];

  programs = {
    adb.enable = true;
  };

  services = {
    openssh = {
      enable = true;
      permitRootLogin = "no";
    };

    cron = {
      enable = true;
      systemCronJobs = [
        "5,35 */1 * * *   turing   . /etc/profile;DISPLAY=:0.0 time /home/turing/bin/run_restic > /tmp/restic.log 2>&1"
        "0 */4 * * *      turing   . /etc/profile;DISPLAY=:0.0 time vdirsyncer sync > /tmp/davsync.log 2>&1"
      ];
    };

    printing = {
      enable = true;
      drivers = [ pkgs.brlaser pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];
    };

    btrfs.autoScrub.enable = true;

    # udev.packages = [ pkgs.yubikey-personalization ];
    # syncthing = {
    #   enable = true;
    #   user = "turing";
    #   dataDir = "/home/turing/syncthing";
    # };
  };

  system.stateVersion = "18.03";
}

{ config, pkgs, lib, options, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common_settings.nix
    ../../modules/basic.nix
    ../../modules/wayland.nix
    ../../modules/workstation.nix
    ../../modules/user.nix
    ../../modules/bluetooth.nix
  ];

  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      efiSupport = true;
      device = "nodev";
    };
    supportedFilesystems = [ "zfs" ];
  };

  networking = {
    firewall = {
      allowedTCPPorts = [ 22 50000 50001 ];
      allowedUDPPorts = [ 50000 ];
    };
    hostId = "9a88f423";
    hostName = "orual";
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    jp
    rtorrent
    wally-cli
    keepassxc unstable.innernet ];

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      flags = [ "until=240h" ];
    };
  };

  services = {
    xserver = {
      libinput.enable = true;
    };
    openssh.enable = true;
    cron = {
      enable = true;
      systemCronJobs = [
        "0 */4 * * *      turing    . /etc/profile ;DISPLAY=:0.0 vdirsyncer sync calendar > /tmp/calsync.log 2>&1"
        "9,19,29,39,49,59 * * * *      turing    . /etc/profile; DISPLAY=:0.0 /home/turing/bin/reminders"
      ];
    };
    zfs.autoScrub.enable = true;
    fstrim.enable = true;
  };

  system.stateVersion = "18.09"; # Did you read the comment?
}

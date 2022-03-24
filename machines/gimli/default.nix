{ config, pkgs, options, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common_settings.nix
    ../../modules/basic.nix
    ../../modules/wayland.nix
    ../../modules/workstation.nix
    ../../modules/user.nix
    ../../modules/bluetooth.nix
    ../../modules/laptop.nix
    ../../modules/zfs.nix
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/x1"
  ];

  # erase your darlings
  environment.etc = {
    nixos.source = "/persistent/etc/nixos";
    "NetworkManager/system-connections".source = "/persistent/etc/NetworkManager/system-connections";
    adjtime.source = "/persistent/etc/adjtime";
    machine-id.source = "/persistent/etc/machine-id";
  };
  systemd.tmpfiles.rules = [
    "L+ /var/lib/systemd/backlight - - - - /persistent/var/lib/systemd/backlight"
  ];
  users.extraUsers.turing.passwordFile = "/persistent/etc/turing-password";
  security.sudo.extraConfig = ''
    # rollback results in sudo lectures after each reboot
    Defaults lecture = never
  '';

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      postDeviceCommands = lib.mkAfter ''
        zfs rollback -r rpool/enc/local/root@blank
        zfs rollback -r rpool/enc/local/var@blank
      '';
    };
  };

  networking = {
    hostName = "gimli";
    hostId = "b93e7d6e";
    networkmanager.enable = true;
    firewall.enable = false;
    wireguard.interfaces = {
      wg0 = {
        ips = [ "10.0.25.90/24" ];
        listenPort = 51820;
        privateKeyFile = "/persistent/wireguard/private";
        peers = [
          {
            publicKey = "VTaS8M1bema9RmA0RYYOiy1HiNPDVSCENBN/iRXeuUw=";
            allowedIPs = [ "10.0.25.0/24" ];
            endpoint = "88.198.194.32:51820";
            persistentKeepalive = 25;
          }
        ];
      };
    };
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
        "0 */4 * * *      turing   . /etc/profile;DISPLAY=:0.0 time vdirsyncer sync > /tmp/davsync.log 2>&1"
      ];
    };

    printing = {
      enable = true;
      drivers = [ pkgs.brlaser pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];
    };
    fstrim.enable = true;
  };


  system.stateVersion = "18.03";
}

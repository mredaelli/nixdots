{ config, pkgs, lib, options, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/neovim_nightly.nix
    ../../modules/common_settings.nix
    ../../modules/basic.nix
    ../../modules/x.nix
    ../../modules/user.nix
    # ./modules/lari-lap.nix
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
  services.zfs.autoScrub.enable = true;
  networking.hostId = "9a88f423";

  networking.hostName = "orual";


  nixpkgs.config = {
    packageOverrides = pkgs: {
      visidata = with pkgs.python38.pkgs; callPackage /home/turing/visidata.nix { };
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [ 22 50000 50001 ];
      allowedUDPPorts = [ 50000 ];
    };
  };

  environment.systemPackages = with pkgs; [
    gcc
    unstable.page
    unstable.dijo
    zotero
      chromium
      jp
      rtorrent
      visidata
      spotify-tui
      spotifyd
      unstable.wally-cli
      nix-prefetch
    ];

  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      ffirefox = "${lib.getBin pkgs.firefox}/bin/firefox";
      fchromium = "${lib.getBin pkgs.chromium}/bin/chromium";
      fvlc = "${lib.getBin pkgs.vlc}/bin/vlc";
      ftransmission = "${lib.getBin pkgs.transmission-gtk}/bin/transmission-gtk";
    };
  };

  programs.fish.promptInit = ''
    any-nix-shell fish --info-right | source
  '';

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      flags = ["until=240h"];
    };
  };

  services = {
    xserver = {
     libinput.enable = true;
      };
    # acpid = {
    #   enable = true;
    #   handlers.mic_noise = {
    #     action = "${pkgs.alsaUtils}/bin/amixer -c0 sset 'Headphone Mic Boost' 10dB;"; # ${pkgs.alsaUtils}/bin/amixer -c 0 set 'Headset Mic' 65% cap";
    #     event="jack/headphone HEADPHONE plug";
    #   };
    # };
  #  openssh.enable = true;
    cron = {
      enable = true;
      systemCronJobs = [
        "0 */4 * * *      turing    . /etc/profile ;DISPLAY=:0.0 vdirsyncer sync calendar > /tmp/calsync.log 2>&1"
        "9,19,29,39,49,59 * * * *      turing    . /etc/profile; DISPLAY=:0.0 /home/turing/bin/reminders"
      ];
    };
  };

  system.stateVersion = "18.09"; # Did you read the comment?
}

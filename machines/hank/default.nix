{ config, pkgs, options, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common_settings.nix
    ../../modules/basic.nix
    ../../modules/wayland.nix
    ../../modules/workstation.nix
    ../../modules/bluetooth.nix
    ../../modules/user.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  hardware.opengl.driSupport32Bit = true;
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.epkowa ];
  };
  environment = {
    systemPackages = with pkgs; [ gscan2pdf keepassxc unstable.innernet ];
  };

  # virtualisation.virtualbox.host = {
  #   enable = true;
  #   enableExtensionPack = true;
  # };

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      flags = [ "until=240h" ];
    };
  };

  users = {
    extraUsers.ale = {
      isNormalUser = true;
      uid = 1001;
      shell = pkgs.bash;
      extraGroups = [ "networkmanager" "scanner" "lp" ];
      packages = with pkgs; [ xsane networkmanagerapplet firefox zathura ];
    };
  };

  networking = {
    hostName = "hank";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  security.sudo.wheelNeedsPassword = false;

  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.gutenprint pkgs.gutenprintBin ];
    };
    cron = {
      enable = true;
      systemCronJobs = [
        "0 */4 * * *      turing    . /etc/profile ;DISPLAY=:0.0 vdirsyncer sync calendar > /tmp/calsync.log 2>&1"
        "9,19,29,39,49,59 * * * *      turing    . /etc/profile; DISPLAY=:0.0 /home/turing/bin/reminders"
      ];
    };
    openssh.enable = true;
    btrfs.autoScrub.enable = true;
  };

  system.stateVersion = "18.03";
}

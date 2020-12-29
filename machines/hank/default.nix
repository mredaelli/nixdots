{ config, pkgs, options, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/neovim_nightly.nix
    ../../modules/common_settings.nix
    ../../modules/basic.nix
    ../../modules/x.nix
    ../../modules/user.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.extraModprobeConfig = ''
    blacklist pcspkr
    blacklist lpc_ich
    blacklist gpio-ich
  '';

  hardware.pulseaudio = {
    support32Bit = true;
  };
  hardware.opengl.driSupport32Bit = true;
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.epkowa ];
  };
  environment = {
    systemPackages = with pkgs; [ xsane ];
  };

  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;

  nixpkgs.overlays = [(
    self: super: {
      # gitEmail = super.git.override {
      #   sendEmailSupport = true;
      #   withLibsecret = true;
      # };
      # neovim = super.neovim.override {
      #   vimAlias = true;
      #   viAlias = true;
      # };
    }
  )];


  users = {
    defaultUserShell = pkgs.fish;
    extraUsers.ale = {
      isNormalUser = true;
      uid = 1001;
      shell = pkgs.bash;
      extraGroups = [ "networkmanager"  "scanner" "lp" ];
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
    # cron = {
    #   enable = true;
    #   systemCronJobs = [
    #     "*/10 * * * *     turing   . /etc/profile; DISPLAY=:0.0 time /home/turing/bin/fetch-mail > /tmp/fetch-mail.log 2>&1"
    #   ];
    # };
    openssh.enable = true;
    xserver = {
      videoDrivers = [ "nvidia" ];
    };
  };

  system.stateVersion = "18.03"; 
}

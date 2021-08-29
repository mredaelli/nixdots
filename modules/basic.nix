{ config, pkgs, options, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      cachix
      yadm

      lsof
      psmisc
      procs
      htop

      bc
      zip
      unzip
      curl
      imagemagick
      fzf
      restic
      bashmount
      direnv
      so

      exa
      ranger
      fd
      ripgrep
      bat
      sd
      dua

      starship
      any-nix-shell

      unstable.neovim

      git
      gitAndTools.delta
      gitui

      ultralist

      mu
      neomutt
      w3m
      urlscan
      ripmime
      isync
      khard
      vdirsyncer
      khal
    ];
    variables = {
      EDITOR = "nvim";
    };
    shells = [ pkgs.bash pkgs.fish ];
  };

  programs = {
    fish = {
      enable = true;
      promptInit = ''
        any-nix-shell fish --info-right | source
      '';
    };
    bash.enableCompletion = true;
  };

  users = {
    defaultUserShell = pkgs.fish;
  };
}

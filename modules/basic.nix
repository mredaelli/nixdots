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
      ytop

      bc
      zip
      unzip
      curl
      imagemagick
      fzf
      restic
      bashmount
      direnv
      thefuck
      tldr
      so

      exa
      ranger
      fd
      ripgrep
      bat
      sd
      du-dust
      ncdu
      broot

      starship
      any-nix-shell

      neovim-nightly

      git
      gitAndTools.delta
      gitAndTools.tig


      weechat
      taskwarrior

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
    fish.enable = true;
    bash.enableCompletion = true;
    thefuck.enable = true;
  };
}

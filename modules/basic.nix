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
      broot

      starship
      any-nix-shell

      neovim-nightly

      git
      gitAndTools.gitui
      gitAndTools.delta


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
  };

  programs = {
    fish.enable = true;
    bash.enableCompletion = true;
    thefuck.enable = true;
  };
}

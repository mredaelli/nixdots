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
      tldr
      so

      exa
      ranger
      fd
      ripgrep
      bat
      sd
      dua
      broot

      starship
      any-nix-shell

      neovim-nightly

      git
      gitAndTools.delta
      gitAndTools.tig

      weechat
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
    fish.enable = true;
    bash.enableCompletion = true;
    thefuck.enable = true;
  };
}

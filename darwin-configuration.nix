{ config, pkgs, ... }:

{
  imports = [
    ./settings.nix
    ./home.nix
  ];

  homebrew = {
    enable = true;
    casks = [
      "nikitabobko/tap/aerospace"
      "karabiner-elements"
      "firefox"
      "raycast"
      "cursorcerer"
      "docker"
      "kitty"
    ];
  };
  environment.systemPackages = with pkgs;
    [
      nil
      nixpkgs-fmt
      bat
      btop
      direnv
      du-dust
      duf
      fd
      gh
      git
      killall
      libqalculate
      lsd
      lunarvim
      nix-your-shell
      p7zip
      rename
      ripgrep
      starship
      tmux
      uutils-coreutils-noprefix
      wget
      xxd
      zoxide
      jankyborders
    ];

  networking.hostName = "RAY";
  services.skhd.enable = true;
  nix.settings.trusted-users = [ "@admin" ];
  nix.configureBuildUsers = true;

  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
  users.users.raf.shell = pkgs.fish;
  users.users.raf.uid = 501;
  users.users.raf.home = "/Users/raf";
  users.knownUsers = [ "raf" ];

  fonts.packages = with pkgs;
    [
      (iosevka-bin.override { variant = "SGr-IosevkaTermCurly"; })
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      sarasa-gothic
      sarabun-font
      noto-fonts-emoji
    ];


  services.nix-daemon.enable = true;

  system.activationScripts.wallpaper.text = ''
    osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"/System/Library/Desktop Pictures/Solid Colors/Black.png\" as POSIX file"
  '';

  launchd.user.agents.jankyborders = {
    serviceConfig = {
      ProgramArguments = [
        "${pkgs.jankyborders}/bin/borders"
        "active_color=0xFFEBDBB2"
        "inactive_color=0xFF928373"
        "width=4"
        "order=above"
      ];

      KeepAlive = true;
      RunAtLoad = true;
      ProcessType = "Interactive";
      EnvironmentVariables = {
        PATH = "${pkgs.jankyborders}/bin:${config.environment.systemPath}";
        LANG = "en_US.UTF-8";
      };
    };
  };

  system.stateVersion = 4;
}

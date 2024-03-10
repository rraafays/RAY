{ pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [ (import "${home-manager}/nix-darwin") ];

  users.users.raf = {
    name = "raf";
    home = "/Users/raf";
    shell = pkgs.fish;
  };

  home-manager.users.raf = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
    home.stateVersion = "23.11";
    home.packages = with pkgs; [
      raycast
      utm
      m-cli
      skhd
      vim
      neovim
      cargo
      du-dust
      ripgrep
      p7zip
      tmux
      wget
      nodePackages.sql-formatter
      jetbrains.idea-community
      nodePackages.prettier
      speedtest-rs
      xmlformat
      onefetch
      qrencode
      python3
      nodejs
      mprocs
      stylua
      kitty
      thokr
      fzf
      mpv
      jq
    ];

    programs.git = {
      enable = true;
      userName = "raf";
      userEmail = "rraf@tuta.io";
    };
  };

  nix.extraOptions = '' experimental-features = nix-command '';

  environment.systemPackages = with pkgs;
    [
      nil
      git
      uutils-coreutils-noprefix
      fastfetch
      starship
      zoxide
      direnv
      shfmt
      watch
      btop
      bat
      lsd
      xxd
      duf
      gh
      fd

      dotnet-sdk_8
      transmission
      nixpkgs-fmt
    ];

  services.nix-daemon.enable = true;

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      minimize-to-application = true;
      mru-spaces = false;
      static-only = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      CreateDesktop = false;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      QuitMenuItem = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = true;
    };
    loginwindow.GuestEnabled = false;
    NSGlobalDomain._HIHideMenuBar = true;
  };

  programs.fish.enable = true;
  programs.zsh.enable = true;
  programs.zsh.interactiveShellInit = ''
    ${pkgs.fish}/bin/fish -c fish; exit
  '';

  networking.hostName = "RAY";
  system.stateVersion = 4;
  services.yabai.enable = true;
  services.yabai.enableScriptingAddition = true;
  services.skhd.enable = true;

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (iosevka-bin.override { variant = "sgr-iosevka-term-curly"; })
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    sarasa-gothic
  ];

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;
  system.defaults.NSGlobalDomain = {
    ApplePressAndHoldEnabled = false;
    KeyRepeat = 5;
    InitialKeyRepeat = 10;
    AppleKeyboardUIMode = 3;
    AppleFontSmoothing = 1;
  };

  security.pam.enableSudoTouchIdAuth = true;
  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
}

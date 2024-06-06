{ pkgs, ... }:

{
  imports = [
    ./home.nix
    ./modules/environment
  ];
  homebrew = {
    enable = true;
    casks = [
      "nikitabobko/tap/aerospace"
      "karabiner-elements"
      "firefox"
      "raycast"
      "kitty"
      "cursorcerer"
    ];
  };

  networking.hostName = "RAY";
  nixpkgs.config.allowUnsupportedSystem = true;

  services.skhd.enable = true;

  nix.settings.trusted-users = [ "@admin" ];
  nix.configureBuildUsers = true;
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (iosevka-bin.override { variant = "SGr-IosevkaTermCurly"; })
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    sarasa-gothic
    sarabun-font
    noto-fonts-emoji
  ];

  services.nix-daemon.enable = true;

  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
  users.users.raf.shell = pkgs.fish;
  users.users.raf.uid = 501;
  users.users.raf.home = "/Users/raf";
  users.knownUsers = [ "raf" ];

  system.stateVersion = 4;

  security.pam.enableSudoTouchIdAuth = true;
  system = {
    defaults = {
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
      loginwindow.GuestEnabled = false;
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

      NSGlobalDomain = {
        "com.apple.keyboard.fnState" = true;
        ApplePressAndHoldEnabled = false;
        KeyRepeat = 2;
        InitialKeyRepeat = 12;
        AppleKeyboardUIMode = 3;
        AppleFontSmoothing = 1;
        _HIHideMenuBar = true;
      };
    };
  };
}

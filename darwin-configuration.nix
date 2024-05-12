{ pkgs, ... }:

{
  imports = [ ./home.nix ];

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
  environment.systemPackages = with pkgs;
    [
      btop
      detox
      du-dust
      duf
      gh
      git
      neovim
      nix-your-shell
      p7zip
      rename
      unzip
      wget
      xxd

      bat
      fd
      lsd
      ripgrep
      uutils-coreutils-noprefix

      direnv
      starship
      tmux
      zoxide

      nixpkgs-fmt
      nodePackages.prettier
      nodePackages.sql-formatter
      rustfmt
      shfmt
      stylua
      xmlformat

      clang
      csharp-ls
      elmPackages.elm-language-server
      jdt-language-server
      lemminx
      ltex-ls
      lua-language-server
      nil
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
      python311Packages.python-lsp-server
      rust-analyzer
      sqls
      taplo
      vscode-langservers-extracted
    ];

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

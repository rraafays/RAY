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
    nixpkgs.config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        nur = import (fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") { inherit pkgs; };
        unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { };
      };
    };
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
    programs.firefox = {
      enable = true;
      package = null;
      profiles = {
        default = {
          isDefault = true;
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            vimium
            sponsorblock
            youtube-recommended-videos
          ];
          userChrome = ''
            #TabsToolbar { visibility: collapse !important; }
            #main-window:not([customizing]) #navigator-toolbox:not(:focus-within):not(:hover){
                margin-top: -45px;
            }
          '';
          settings = {
            "browser.startup.homepage" = "https://nixos.org";
            "browser.search.region" = "GB";
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "app.normandy.first_run" = false;
            "app.shield.optoutstudies.enabled" = false;
            "app.update.channel" = "default";
            "browser.urlbar.quickactions.enabled" = false;
            "browser.urlbar.quickactions.showPrefs" = false;
            "browser.urlbar.shortcuts.quickactions" = false;
            "browser.urlbar.suggest.quickactions" = false;
            "dom.forms.autocomplete.formatautofill" = false;
            "extensions.update.enabled" = false;
            "extensions.webcompat.enable_picture_in_picture_override" = true;
            "extensions.webcompat.enable_shims" = true;
            "extensions.webcompat.perform_injections" = true;
            "extensions.webcompat.perform_ua_overrides" = true;
            "privacy.donottrackheader.enabled" = true;
            "signon.rememberSignons" = false;
            "browser.formfill.enable" = false;
            "signon.autofillForms" = false;
            "extensions.formautofill.addresses.enabled" = false;
            "extensions.formautofill.creditCards.enabled" = false;
            "extensions.formautofill.hueristics.enabled" = false;
          };
        };
      };
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

  homebrew = {
    enable = true;
    casks = [
      "karabiner-elements"
      "firefox"
    ];
  };
}

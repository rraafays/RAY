{ ... }:

{
  system.defaults = {
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
}

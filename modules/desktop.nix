{ pkgs, ... }:

{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      autotiling
      brightnessctl
      bluetui
      dunst
      foot
      grim
      htop
      imv
      kanshi
      mpv
      nwg-look
      pavucontrol
      playerctl
      polkit_gnome
      rofi
      slurp
      swaybg
      swayidle
      swaylock
      thunar
      waybar
      wdisplays
      wf-recorder
      xarchiver
      zathura
    ];
  };

  xdg.portal = {
    enable = true;
    wlr = {
      enable = true;
      settings.screencast = {
        chooser_type = "dmenu";
        chooser_cmd = "${pkgs.rofi}/bin/rofi -dmenu -p 'Select Output:'";
      };
    };
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common.default = [
        "wlr"
        "gtk"
      ];
      sway = {
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        "org.freedesktop.impl.portal.Screenshot" = "wlr";
      };
    };
  };

  services.displayManager.ly.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
  programs.starship.enable = true;

}

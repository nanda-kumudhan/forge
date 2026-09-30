{ config, pkgs, ... }:

{
  # Sway and the utilities used by the Wayland desktop session.
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      autotiling
      foot
      grim
      htop
      imv
      dunst
      mpv
      kanshi
      nwg-look
      brightnessctl
      bluetui
      pavucontrol
      polkit_gnome
      slurp
      swaybg
      swayidle
      swaylock
      thunar
      waybar
      wdisplays
      wf-recorder
      zathura
      playerctl
      rofi
      xarchiver
    ];
  };

  # XDG portals provide screenshots, screencasts, and desktop integration.
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    wlr.settings.screencast = {
      chooser_type = "dmenu";
      chooser_cmd = "${pkgs.rofi}/bin/rofi -dmenu -p 'Select Output:'";
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [ "wlr" "gtk" ];
      sway = {
        "org.freedesktop.impl.portal.ScreenCast" = "wlr";
        "org.freedesktop.impl.portal.Screenshot" = "wlr";
      };
    };
  };

  # PipeWire provides ALSA, PulseAudio, and JACK compatibility.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.blueman.enable = true;

  # Ly provides the graphical login screen for the Sway session.
  services.displayManager.ly.enable = true;
}

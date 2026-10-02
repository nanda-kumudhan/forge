{
  config,
  pkgs,
  lib,
  ...
}:

let
  guestUid = 1500;

  wipeHome = pkgs.writeShellScript "guest-wipe-home" ''
    ${pkgs.findutils}/bin/find /home/guest -mindepth 1 -delete
  '';
in
{
  services.desktopManager.plasma6.enable = true;
  xdg.portal.config.kde.default = [
    "kde"
    "gtk"
  ];

  users.groups.guest.gid = guestUid;
  users.users.guest = {
    isNormalUser = true;
    description = "Guest";
    uid = guestUid;
    group = "guest";
    hashedPassword = "";
  };

  services.displayManager.ly.enable = lib.mkForce false;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.displayManager.defaultSession = "plasma";
  services.displayManager.autoLogin = {
    enable = true;
    user = "guest";
  };

  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.sddm.allowNullPassword = true;
  security.pam.services.kde.allowNullPassword = true;

  fileSystems."/home/guest" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [
      "size=2G"
      "mode=0700"
      "uid=${toString guestUid}"
      "gid=${toString guestUid}"
      "nosuid"
      "nodev"
    ];
  };

  systemd.services."user@${toString guestUid}" = {
    overrideStrategy = "asDropin";
    serviceConfig.ExecStopPost = "+${wipeHome}";
  };

  environment.systemPackages =
    (with pkgs.kdePackages; [
      ark
      elisa
      filelight
      gwenview
      kate
      kcalc
      kdeconnect-kde
      kolourpaint
      okular
      spectacle
    ])
    ++ (with pkgs; [
      firefox
      libreoffice-qt
      vlc
    ]);
}

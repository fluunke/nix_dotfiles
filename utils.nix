{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # tools
    wget
    killall
    unrar
    unzip
    zip
    p7zip
    fd
    kalker

    # polkit stuff
    polkit
    mate.mate-polkit
  ];
}

{pkgs, ...}: {
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    jetbrains-mono
    fira
    fira-code
  ];
}

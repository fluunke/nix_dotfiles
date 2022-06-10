{
  config,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod;

    # # make the system awfully slow instead of completely freezing while downloading big files
    # kernel.sysctl = {
    #   "vm.dirty_background_bytes" = 16777216;
    #   "vm.dirty_bytes" = 50331648;
    # };
  };
}

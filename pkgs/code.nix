{
  pkgs,
  config,
  ...
}: {
  config.environment.systemPackages = with pkgs; [
    gcc
    clang

    cargo
    cargo-edit
    cargo-bloat
    cargo-watch

    rustc
    rustfmt
    clippy
    pkg-config
    bintools-unwrapped
    openssl_3_0
    mold
    nodejs
  ];

  config.environment.variables = {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };

  config.home-manager.users.domi = {
    programs = {
      git = {
        enable = true;
        delta.enable = true;
        userEmail = "flrk@tuta.io";
        userName = "fluunke";
        extraConfig = {
          init.defaultBranch = "main";
        };
      };

      gitui.enable = true;

      vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
          matklad.rust-analyzer
          tamasfe.even-better-toml
          yzhang.markdown-all-in-one
          vadimcn.vscode-lldb
          svelte.svelte-vscode
          kamadorueda.alejandra
          bradlc.vscode-tailwindcss
          github.copilot
        ];
      };
    };
  };
}

{
  pkgs,
  config,
  ...
}: {
  config.environment.systemPackages = with pkgs; [
    gcc
    cargo
    rustc
    rustfmt
  ];

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

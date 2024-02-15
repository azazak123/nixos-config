{ pkgs, pkgs-unstable, vscodeExt }:

{
  enable = true;
  package = pkgs-unstable.vscode;
  extensions = with pkgs-unstable.vscode-extensions; [
    vadimcn.vscode-lldb
    esbenp.prettier-vscode
    ms-azuretools.vscode-docker
    mkhl.direnv
    wakatime.vscode-wakatime
    vscodevim.vim
    usernamehw.errorlens
    streetsidesoftware.code-spell-checker
    serayuzgur.crates
    pkief.material-icon-theme
    naumovs.color-highlight
    ms-vsliveshare.vsliveshare
    ms-vscode.hexeditor
    ms-vscode-remote.remote-ssh
    grapecity.gc-excelviewer
    editorconfig.editorconfig
    dbaeumer.vscode-eslint

    ms-python.vscode-pylance
    ms-python.python

    ms-toolsai.jupyter
    ms-dotnettools.csharp
    mads-hartmann.bash-ide-vscode
    llvm-vs-code-extensions.vscode-clangd
    ms-vscode.cmake-tools
    haskell.haskell
    justusadam.language-haskell
    jnoortheen.nix-ide
    golang.go
    elmtooling.elm-ls-vscode
    rust-lang.rust-analyzer
    redhat.vscode-yaml
    tamasfe.even-better-toml
    ocamllabs.ocaml-platform
    graphql.vscode-graphql-syntax
    graphql.vscode-graphql

    github.vscode-pull-request-github
    mhutchie.git-graph
    eamodio.gitlens

    yzhang.markdown-all-in-one
    shd101wyy.markdown-preview-enhanced
    davidanson.vscode-markdownlint
  ] ++ (with vscodeExt.vscode-marketplace; [
    whizkydee.material-palenight-theme
    aaron-bond.better-comments
    eww-yuck.yuck
    znck.grammarly
    cschlosser.doxdocgen
    hbenl.vscode-test-explorer
    ms-vscode.test-adapter-converter

    mtxr.sqltools
    mtxr.sqltools-driver-pg

    odiriuss.rust-macro-expand
    lorenzopirro.rust-flash-snippets
    jscearcy.rust-doc-viewer

    ms-vscode.remote-explorer
    ms-vscode-remote.remote-ssh-edit
    ms-vscode-remote.remote-containers
    visualstudioexptteam.intellicode-api-usage-examples
    visualstudioexptteam.vscodeintellicode

    bamboo.idris2-lsp
    pgourlain.erlang
    csharpier.csharpier-vscode
    vue.volar
    vue.vscode-typescript-vue-plugin
  ]);

  userSettings = {
    "extensions.autoUpdate" = false;
    "extensions.autoCheckUpdates" = false;
    "editor.fontSize" = 18;
    "editor.formatOnSave" = true;
    "workbench.colorTheme" = "Palenight Theme";
    "workbench.iconTheme" = "material-icon-theme";
    "terminal.integrated.defaultProfile.linux" = "fish";
    "files.autoSave" = "afterDelay";
    "window.titleBarStyle" = "custom";
    "editor.rulers" = [ 80 ];
    "editor.fontFamily" =
      "'JetBrainsMono Nerd Font', 'Droid Sans Mono', 'monospace', monospace, 'EmojiOne Color'";
    "python.analysis.inlayHints.functionReturnTypes" = true;
    "python.analysis.inlayHints.variableTypes" = true;
    "python.analysis.typeCheckingMode" = "strict";
    "python.linting.pylintEnabled" = true;
    "python.linting.flake8Enabled" = true;

    # Formatters
    "[jsonc]"."editor.defaultFormatter" = "vscode.json-language-features";
    "[csharp]"."editor.defaultFormatter" = "csharpier.csharpier-vscode";
    "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[typescriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[vue]"."editor.defaultFormatter" = "vue.volar";
    "sqltools.format" = {
      "linesBetweenQueries" = "preserve";
      "reservedWordCase" = "upper";
    };
  };
}


{ pkgs, pkgsUnstable, vscodeExt }:

{
  enable = true;
  extensions = with pkgsUnstable.vscode-extensions; [
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
    oderwat.indent-rainbow
    naumovs.color-highlight
    ms-vsliveshare.vsliveshare
    ms-vscode.hexeditor
    ms-vscode-remote.remote-ssh
    grapecity.gc-excelviewer
    editorconfig.editorconfig
    dbaeumer.vscode-eslint

    ms-python.vscode-pylance
    ms-python.python
    ms-pyright.pyright

    ms-toolsai.jupyter
    ms-dotnettools.csharp
    mads-hartmann.bash-ide-vscode
    llvm-vs-code-extensions.vscode-clangd
    ms-vscode.cpptools
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
  ]);

  userSettings = {
    "extensions.autoUpdate" = false;
    "extensions.autoCheckUpdates" = false;
    "window.zoomLevel" = 1.2;
    "editor.fontSize" = 18;
    "editor.formatOnSave" = true;
    "workbench.colorTheme" = "Palenight Theme";
    "workbench.iconTheme" = "material-icon-theme";
    "terminal.integrated.defaultProfile.linux" = "fish";
    "[jsonc]"."editor.defaultFormatter" = "vscode.json-language-features";
    "files.autoSave" = "afterDelay";
  };
}


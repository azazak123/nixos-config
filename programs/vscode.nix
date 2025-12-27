{
  pkgs,
  pkgs-unstable,
  vscodeExt,
}:

let
  lib = pkgs.lib;
  hasAttrByPath = lib.attrsets.hasAttrByPath;
  getAttrFromPath = lib.attrsets.getAttrFromPath;
in
{
  enable = true;
  package = pkgs-unstable.vscode;
  profiles.default.extensions =
    let
      get-extensions =
        {
          extensions,
          exceptions ? [ ],
        }:
        map (
          ext:
          let
            path = lib.splitString "." ext;
          in
          if hasAttrByPath path pkgs-unstable.vscode-extensions && !(builtins.elem ext exceptions) then
            getAttrFromPath path pkgs-unstable.vscode-extensions
          else
            getAttrFromPath path vscodeExt.vscode-marketplace
        ) extensions;

      theme-extensions = get-extensions {
        extensions = [
          "pkief.material-icon-theme"
          "whizkydee.material-palenight-theme"
        ];
      };

      visual-extensions = get-extensions {
        extensions = [
          "aaron-bond.better-comments"
          "usernamehw.errorlens"
          "naumovs.color-highlight"
        ];
      };

      rust-extensions = get-extensions {
        extensions = [
          "rust-lang.rust-analyzer"
          "odiriuss.rust-macro-expand"
          "lorenzopirro.rust-flash-snippets"
          "jscearcy.rust-doc-viewer"
        ];
      };

      c-extensions = get-extensions {
        extensions = [
          "llvm-vs-code-extensions.vscode-clangd"
          "twxs.cmake"
          "ms-vscode.cmake-tools"
        ];
      };

      js-extensions = get-extensions {
        extensions = [
          "vue.volar"
          "dbaeumer.vscode-eslint"
          "esbenp.prettier-vscode"
        ];
      };

      csharp-extensions = get-extensions {
        extensions = [
          "csharpier.csharpier-vscode"
          "ms-dotnettools.csharp"
        ];
      };

      haskell-extensions = get-extensions {
        extensions = [
          "haskell.haskell"
          "justusadam.language-haskell"
        ];
      };

      sql-extensions = get-extensions {
        extensions = [
          "mtxr.sqltools"
          "mtxr.sqltools-driver-pg"
        ];
      };

      python-extensions = get-extensions {
        extensions = [
          "ms-python.python"
          "ms-python.vscode-pylance"
        ];
        exceptions = [ "ms-python.python" ]; # hash mismatch
      };

      other-languages-extensions = get-extensions {
        extensions = [
          "bamboo.idris2-lsp"
          "amauryrabouan.new-vsc-prolog"
          "pgourlain.erlang"
          "elmtooling.elm-ls-vscode"
          "redhat.vscode-yaml"
          "tamasfe.even-better-toml"
          "ocamllabs.ocaml-platform"
          "golang.go"
          "jnoortheen.nix-ide"
          "ms-toolsai.jupyter"
          "mads-hartmann.bash-ide-vscode"
          "graphql.vscode-graphql-syntax"
          "graphql.vscode-graphql"
          "betterthantomorrow.calva"
        ];
      };

      git-extensions = get-extensions { extensions = [ "mhutchie.git-graph" ]; };

      other-extensions = get-extensions {
        extensions = [
          "mkhl.direnv"
          "wakatime.vscode-wakatime"
          "streetsidesoftware.code-spell-checker"
          "fill-labs.dependi"
          "ms-vsliveshare.vsliveshare"
          "ms-vscode.hexeditor"
          "grapecity.gc-excelviewer"
          "editorconfig.editorconfig"
          "vadimcn.vscode-lldb"
          "cschlosser.doxdocgen"
          "visualstudioexptteam.intellicode-api-usage-examples"
          "visualstudioexptteam.vscodeintellicode"
          "codeium.codeium"
        ];
      };
    in
    pkgs.lib.concatLists [
      theme-extensions
      visual-extensions
      rust-extensions
      c-extensions
      js-extensions
      csharp-extensions
      haskell-extensions
      sql-extensions
      python-extensions
      other-languages-extensions
      git-extensions
      other-extensions
    ];

  profiles.default.userSettings = {
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
    "nix.serverPath" = "nil";
    "nix.serverSettings" = {
      "nil" = {
        "formatting" = {
          "command" = [
            "nix"
            "fmt"
            "--"
            "-"
          ];
        };
      };
    };

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
    "nix.formatterPath" = [
      "nix"
      "fmt"
      "--"
      "-"
    ];
  };
}

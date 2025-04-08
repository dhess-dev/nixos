let
  aliases = {
    ll = "ls -l";
    gs = "git status";
    ".." = "cd ..";
  };
in
  {pkgs, ...}: {
    programs.bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = aliases;
    };

    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting = {
        enable = true;
      };
      oh-my-zsh = {
        plugins = ["git" "sudo" "docker"];
      };
      shellAliases = aliases;
      initExtra = ''
        zstyle ':completion:*' menu select

        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        bindkey "^H" backward-kill-word
        bindkey "^[[OH" beginning-of-line
        bindkey "^[[OF" end-of-line
      '';
    };
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
  }

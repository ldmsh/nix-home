{ config, lib, pkgs, ... }:

with lib;
let
  homeDir = builtins.getEnv ("HOME");
  cfg = config.programs.workivaShell;
in {
  options.programs.workShell = { enable = mkEnableOption "workivaShell"; };

  config = {
    home-manager.users.yuanwang.programs.zsh.initExtra = mkAfter ''
      eval "$(pyenv init -)"
      export PYENV_ROOT="$HOME/.pyenv" # needed by pipenv

      #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
      export SDKMAN_DIR="${homeDir}/.sdkman"
      [[ -s "${homeDir}/.sdkman/bin/sdkman-init.sh" ]] && source "${homeDir}/.sdkman/bin/sdkman-init.sh"
    '';
  };
}
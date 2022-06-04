{ config, lib, pkgs, ... }:

with lib;
let cfg = config.programs.python;
in {
  options.programs.python = { enable = mkEnableOption "python"; };

  config = mkIf cfg.enable {
    home-manager.users.${config.my.username}.home.packages = [
      (pkgs.python3.withPackages (ps:
        with ps; [
          pip
          #ipython
          black
          pandas
          isort
          setuptools
          pylint
          matplotlib
          nose
          # poetry
          pytest
          pyflakes
          # pylsp-mypy
          virtualenv
          virtualenvwrapper
        ]))
    ];
  };
}

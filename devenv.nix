{ inputs, pkgs, ... }:

{
  packages = [
    inputs.patchmill.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.git
    pkgs.gh
  ];

  languages.javascript = {
    enable = true;
    package = pkgs.nodejs_24;
    npm.enable = true;
  };

  enterShell = ''
    printf '\nPatchmill skills-first kernel test repository (21e1ff8).\n'
    printf 'Read E2E.md before running live tests. No models run on shell entry.\n\n'
  '';
}

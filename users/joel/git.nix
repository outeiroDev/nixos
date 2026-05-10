{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Joel Outeiro";
        email = "joel@outeiro.com";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };
}

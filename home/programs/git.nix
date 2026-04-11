{ ... }:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "Volodymyr Antonov";
      email = "azazaka2002@gmail.com";
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Volodymyr Antonov";
        email = "azazaka2002@gmail.com";
      };
      ui.conflict-marker-style = "git";
    };
  };

  programs.difftastic = {
    enable = true;
    git.enable = true;
    jujutsu.enable = true;
  };

  programs.mergiraf = {
    enable = true;
    enableGitIntegration = true;
    enableJujutsuIntegration = true;
  };
}

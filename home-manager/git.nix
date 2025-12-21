{
  programs.git = {
    enable = true;
    settings = {
      user.name = "David Ochsner";
      # do not set email, so I'm forced to decide per repo
      core = {
        autocrlf = false;
      };
      rerere = {
        enabled = true;
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}

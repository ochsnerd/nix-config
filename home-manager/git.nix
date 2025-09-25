{
  programs.git = {
    enable = true;
    userName = "David Ochsner";
    # do not set email, so I'm forced to decide per repo
    extraConfig = {
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

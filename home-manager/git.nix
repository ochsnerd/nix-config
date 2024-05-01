{
  programs.git = {
    enable = true;
    userName = "David Ochsner";
    extraConfig = {
      core = {
        autocrlf = true;
      };
      rerere = {
        enabled = true;
      };
    };
  };
}

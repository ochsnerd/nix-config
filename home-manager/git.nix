{
  programs.git = {
    enable = true;
    userName = "David Ochsner";
    extraConfig = {
      core = {
        autocrlf = false;
      };
      rerere = {
        enabled = true;
      };
    };
  };
}

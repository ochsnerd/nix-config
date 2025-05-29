{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    functions = {
      remarkable_stream = ''
        firefox "https://$argv[1]:2001/?portrait=true" &
        ssh root@$argv[1] "pgrep goMarkableStream | xargs kill; RK_SERVER_USERNAME=david RK_SERVER_PASSWORD=david ./goMarkableStream"
      '';

      custom_confirm = ''
        set command $argv[1]
        set phrase $argv[2]

        echo "Enter the phrase '$phrase' to confirm:"
        read input

        if test "$input" = "$phrase"
          eval "$command"
        else
          echo "Confirmation failed. Command not executed."
        end
      '';

      confirm_with_timestamp = ''
        custom_confirm "$argv[1]" "Its "(date +'%H:%M')" and $argv[2]"
      '';

      ff-yt = ''confirm_with_timestamp "firefox -P youtube" "I want to watch youtube"'';
    };
    shellAbbrs = {};
  };
}

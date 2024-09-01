{
  programs.bash.enable = true;
  # TODO: This is not really the correct place for this (dotfile manager)
  programs.bash.initExtra = ''
  remarkable_stream() {
    firefox "https://''$1:2001/?portrait=true" &
    ssh root@''$1 "pgrep goMarkableStream | xargs kill; RK_SERVER_USERNAME=david RK_SERVER_PASSWORD=david ./goMarkableStream"
  }

  custom_confirm() {
    local command="$1"
    local phrase="$2"
    local input

    echo -n "Enter the phrase '$phrase' to confirm: "
    read -r input

    if [ "$input" = "$phrase" ]; then
        eval "$command"
    else
        echo "Confirmation failed. Command not executed."
    fi
  }

  confirm_with_timestamp() {
    custom_confirm "$1" "Its $(date +'%H:%M') and $2"
  }
'';
  programs.bash.shellAliases = {
    # TODO: relative path in repo?
    rebuild = "sudo nixos-rebuild switch --flake ~/nix-config";
    fix-zenzone = "systemctl restart bluetooth; sleep 2; bluetoothctl connect AC:BF:71:82:B2:ED";
    teams = "chromium https://teams.microsoft.com/v2/";
    ff = "firefox -P David";
    ff-cudos = "firefox -P cudos";
    ff-yt = ''confirm_with_timestamp "firefox -P youtube" "I want to watch youtube"'';
  };
}

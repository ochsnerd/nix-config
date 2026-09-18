{
  programs.zellij.enable = true;

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

      cudos-claude = "ANTHROPIC_API_KEY=(cat ~/anthropic.key) claude $argv";

      new-random-ghostty = ''
        set -l themes "Dracula" "Gruvbox Dark" "Nord" "Rose Pine" "Matrix" "3024 Night" "Alien Blood" "Banana Blueberry" "Belafonte Day" "Blue Berry Pie" "Coffee Theme" "Earthsong" "Grey Green"

        set -l selected_theme (random choice $themes)
        ghostty --theme="$selected_theme" &
        disown
      '';

      "__workspace_project_root" = {
        description = "Print the nearest ancestor directory containing layout.kdl";
        body = ''
          set -l dir $argv[1]
          test -n "$dir"; or set dir (pwd)
          set dir (path resolve $dir)

          while true
            if test -f $dir/layout.kdl
              echo $dir
              return 0
            end
            set -l parent (path dirname $dir)
            test "$parent" = "$dir"; and return 1
            set dir $parent
          end
        '';
      };

      "__workspace_current" = {
        description = "Print the workspace containing the current directory";
        body = ''
          set -l root $argv[1]
          if test -z "$root"
            set root (__workspace_project_root)
            test -n "$root"; or return 1
          end
          set -l cwd (path resolve .)
          set -l rel (string replace -- $root/ "" $cwd)
          # no replacement happened => cwd is the root itself (or outside it)
          test "$rel" = "$cwd"; and return 1
          string split -f1 / $rel
        '';
      };

      "__workspaces" = {
        description = "List workspace directory names in a project root";
        body = ''
          set -l root $argv[1]
          if test -z "$root"
            set root (__workspace_project_root)
            test -n "$root"; or return 1
          end

          set -l entries $root/*
          path basename (path filter -d $entries)
        '';
      };

      "__workspace_session_name" = {
        description = "Canonical zellij session name for <root> <workspace>";
        body = ''
          set -l name (string replace -ra '[^a-zA-Z0-9_-]' '-' (path basename $argv[1])-$argv[2])
          string sub -l 24 -- $name
        '';
      };

      workspace-start = {
        description = "Start a zellij session for a project workspace.";
        body = ''
          set -l root (__workspace_project_root)
          if test -z "$root"
            echo "workspace-start: no layout.kdl in "(pwd)" or any parent directory" >&2
            return 1
          end
          set -l workspaces (__workspaces $root)

          set -l name
          switch (count $argv)
            case 0
              set name (__workspace_current $root)
              if test -z "$name"
                echo "workspace-start: not inside a workspace (cwd is the project root)" >&2
                echo "usage: workspace-start [workspace]" >&2
                echo "workspaces: $workspaces" >&2
                return 1
              end
            case 1
              set name (path basename $argv[1])
            case '*'
              echo "usage: workspace-start [workspace]" >&2
              echo "project root: $root" >&2
              echo "workspaces:   $workspaces" >&2
              return 1
          end

          set -l wsdir $root/$name
          if not test -d $wsdir
            echo "workspace-start: no workspace '$name' in $root" >&2
            echo "workspaces: $workspaces" >&2
            return 1
          end
          set -l session (__workspace_session_name $root $name)
          pushd $wsdir
          zellij attach --create $session options --default-layout $root/layout.kdl
          set -l rc $status
          popd
          return $rc
        '';
      };
    };

    shellAbbrs = { };
  };

  xdg.configFile."fish/completions/workspace-start.fish".text = ''
    complete -c workspace-start -f -a "(__workspaces)"
  '';
}

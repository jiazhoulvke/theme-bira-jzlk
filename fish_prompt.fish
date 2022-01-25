# name: bira-jzlk
# this theme based on bira theme from https://github.com/oh-my-fish/theme-bira

function __user_host
  set -l content
  if [ (id -u) = "0" ];
    echo -n (set_color red)
  else
    echo -n (set_color cyan)
  end
  echo -n $USER(set_color white)@(set_color yellow)(hostname|cut -d . -f 1) (set_color normal)
end

function __current_path
  set -g fish_prompt_pwd_dir_length 0
  echo -n (set_color green)\[(prompt_pwd)\](set_color normal) 
end

function __current_time
  echo -n (set_color white) \((date +"%Y-%m-%d %H:%M:%S")\)(set_color normal)
end

function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function __git_status
  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)

    if [ (_git_is_dirty) ]
      set git_info '<'\uE0A0$git_branch"*"'>'
    else
      set git_info '<'\uE0A0$git_branch'>'
    end

    echo -n (set_color yellow) $git_info(set_color normal) 
  end
end

function fish_prompt
  echo -n (set_color white)"╭─"(set_color normal)
  __user_host
  __current_path
  __git_status
  # __current_time
  echo -e ''
  echo (set_color white)"╰─\$ "(set_color normal)
end

function fish_right_prompt
  set -l st $status

  if [ $st != 0 ];
    echo (set_color red) ↵ $st(set_color normal)
  end
end

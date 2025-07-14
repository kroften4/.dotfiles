if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx vk_xwayland_wait_ready false
set -gx MESA_VK_WSI_PRESENT_MODE immediate
set -gx JAVA_HOME /opt/graalvm-jdk-21.0.7+8.1/
set -gx MANPAGER "nvim +Man!"
set -gx EDITOR "nvim"

alias todo "nvim /home/krft/Desktop/todo.txt"
alias config "python ~/Utilities/config.py"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME'


SESSIONNAME="cpong"
tmux has-session -t $SESSIONNAME &> /dev/null

if [ $? != 0 ]
then
    tmux new-session -s $SESSIONNAME -c "/home/krft/Github/cpong" -d
    tmux new-window -n nvim -c "/home/krft/Github/cpong"
    tmux send-keys "nvim" C-m
    tmux new-window -n play -c "/home/krft/Github/cpong"
    tmux send-keys -l "bin/server 8889"
    tmux split-window -h -c "/home/krft/Github/cpong"
    tmux send-keys -l "bin/client localhost 8889"
    tmux split-window -v -c "/home/krft/Github/cpong"
    tmux send-keys -l "bin/client localhost 8889"
fi

tmux attach -t $SESSIONNAME


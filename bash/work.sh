#create session with jump window
tmux new-session -s work -d -n notes
tmux send-keys "ssh " Enter
tmux new-window -n jump
tmux send-keys "cd ~/notes/" Enter
tmux split-window -v 
tmux split-window -h
tmux split-window -h

tmux attach-session -t work 

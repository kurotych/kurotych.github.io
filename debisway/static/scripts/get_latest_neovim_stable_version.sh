curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep "tag_name" | awk '{print $2}' | tr -d '",'

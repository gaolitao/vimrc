#!/bin/bash
set -e

# Configuration
USER_NAME="${1:-Litao Gao}"
USER_EMAIL="${2:-litao.gao@windriver.com}"

# Skip git config if already set to any value
[ -n "$(git config --global user.name)" ] || git config --global user.name "$USER_NAME"
[ -n "$(git config --global user.email)" ] || git config --global user.email "$USER_EMAIL"
[ -n "$(git config --global core.editor)" ] || git config --global core.editor "vim"

# Go tools installation (skip if Go not installed)
if command -v go &> /dev/null; then
    echo "Installing Go tools..."
    go install golang.org/x/tools/cmd/guru@latest
    go install golang.org/x/tools/gopls@latest
else
    echo "Go not found, skipping Go tools installation"
fi

# Backup existing configs
backup_configs() {
    [ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.backup.$(date +%s)
    [ -d ~/.vim ] && mv ~/.vim ~/.vim.backup.$(date +%s)
}

# Create symlinks
backup_configs
ln -sf "$(readlink -f vimrc)" ~/.vimrc
ln -sf "$(readlink -f vim)" ~/.vim

# Handle git submodules
find . -type d -name '.git' -exec mv {} {}2 \; 2>/dev/null || true

# Setup coc.nvim if Node.js is available
if command -v npm &> /dev/null; then
    echo "Setting up coc.nvim..."
    cd vim/bundle/coc.nvim
    npm install
    npm run build
    cd - > /dev/null
    echo "coc.nvim setup complete. Run ':CocInstall coc-python coc-go coc-tsserver' in vim to install language servers."
else
    echo "Node.js not found, skipping coc.nvim setup"
    echo "To install Node.js:"
    echo "  Ubuntu/Debian: sudo apt install nodejs npm"
    echo "  CentOS/RHEL:   sudo yum install nodejs npm"
    echo "  Or visit:      https://nodejs.org/"
    echo "Then re-run this script to setup coc.nvim"
fi

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "1. Start vim and install coc language servers:"
echo "   :CocInstall coc-python coc-go coc-tsserver coc-json coc-pairs"
echo ""
echo "2. Configure coc.nvim settings:"
echo "   :CocConfig"
echo "   Add recommended configuration:"
echo "   {"
echo "     \"suggest.noselect\": false,"
echo "     \"suggest.floatEnable\": true,"
echo "     \"coc.preferences.diagnostic.displayByAle\": false"
echo "   }"
echo ""
echo "3. Optional: Add coc keybindings to your vimrc:"
echo "   - Tab for completion"
echo "   - gd for go to definition"
echo "   - K for documentation"
echo "   - [g ]g for diagnostics navigation"
echo ""
echo "4. If you encounter Python plugin errors:"
echo "   - Disable python-mode: mv vim/bundle/python-mode vim/bundle/python-mode.disabled"
echo "   - Use coc-python instead for better Python support"
echo ""
echo "Enjoy your enhanced vim setup!"

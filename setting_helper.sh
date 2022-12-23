

git config --global user.name "Litao Gao"
git config --global user.email "litao.gao@windriver.com"
git config --global core.editor "vim"


# required by golang features
go install golang.org/x/tools/cmd/guru@latest
go install golang.org/x/tools/gopls@latest


# symlink to myself
mv ~/.vimrc ~/vimrc.backup
mv ~/.vim ~/vim.backup

ln -s `readlink -f vimrc` ~/.vimrc
ln -s `readlink -f vim` ~/.vim

# used for skip git submodule check for the plugins in bundle folder
find . -type d -name '.git' | xargs -I {} mv {} {}2


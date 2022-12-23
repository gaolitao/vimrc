

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

# coc setting
## 1. nodejs install 
curl -L https://git.io/n-install --output n-install
chmod +x n-install
yes y | ./n-install
sudo $HOME/n/bin/n 14.17.0

## 2. build coc plugin
cd bundle/coc.nvim
yarn install
yarn build

## 3. coc config, vim command line `:CocConfig` 
{
    "languageserver": {
        "golang": {
            "command": "gopls",
            "rootPatterns": [
                "go.mod"
            ],
            "filetypes": [
                "go"
            ]
        }
    },
    "suggest.noselect": false,
    "coc.preferences.diagnostic.displayByAle": true,
    "suggest.floatEnable": true
}

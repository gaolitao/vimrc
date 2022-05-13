" Modeline and Notes {
"
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker :

"	This is the personal .vimrc file of Steve Francia.
"	While much of it is beneficial for general use, I would
"	recommend picking out the parts you want and understand.
"
"	You can find me at http://spf13.com
" }

" Environment {
	" Basics {
		set nocompatible 		" must be first line
		"set background=dark     " Assume a dark background
        "set guifont=Consolas:h11:cANSI
	" }

	" Windows Compatible {
		" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
		" across (heterogeneous) systems easier. 
		if has('win32') || has('win64')
		  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
		endif
	" }
    " 
	" Setup Bundle Support {
	" The next two lines ensure that the ~/.vim/bundle/ system works
        filetype off
		"runtime! autoload/pathogen.vim
        call pathogen#infect()
		call pathogen#helptags()
		"silent! call pathogen#runtime_append_all_bundles()
		"call pathogen#runtime_append_all_bundles()
	" }

" }

" General {
	"set background=dark         " Assume a dark background
    if !has('win32') && !has('win64')
        "set term=$TERM       " Make arrow and other keys work
    endif
	syntax on 					" syntax highlighting
    filetype on
	filetype plugin indent on  	" Automatically detect file types.
	"set mouse=a					" automatically enable mouse usage
	"set autochdir 				" always switch to the current file directory.. Messes with some plugins, best left commented out
	" not every vim is compiled with this, use the following line instead
	" If you use command-t plugin, it conflicts with this, comment it out.
     "autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
	scriptencoding utf-8
    set encoding=utf8
    let $LANG = 'en_US'
    if has('win32') || has('win64')
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
    endif

    "set langmenu=en_US.UTF-8
    "set langmenu=zh_CN.UTF-8

	" set autowrite                  " automatically write a file when leaving a modified buffer
	set shortmess+=filmnrxoOtT     	" abbrev. of messages (avoids 'hit enter')
	set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
	set virtualedit=onemore 	   	" allow for cursor beyond last character
	set history=1000  				" Store a ton of history (default is 20)
	"set spell 		 	        	" spell checking on
	
    " No sound on errors
    set noerrorbells
    set novisualbell
    set vb t_vb=
    set tm=500

    " Disable backup and swap files
    set nobackup
    set nowritebackup
    set noswapfile

	" Setting up the directories {
		set backup 						" backups are nice ...
        " Moved to function at bottom of the file
		"set backupdir=$HOME/.vimbackup//  " but not when they clog .
		"set directory=$HOME/.vimswap// 	" Same for swap files
		"set viewdir=$HOME/.vimviews// 	" same for view files
		
		"" Creating directories if they don't exist
		"silent execute '!mkdir -p $HVOME/.vimbackup'
		"silent execute '!mkdir -p $HOME/.vimswap'
		"silent execute '!mkdir -p $HOME/.vimviews'
		au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
		au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)
	" }
" }

" Vim UI {
	"color solarized   	       		" load a colorscheme
	colorscheme desert                    " load a colorscheme
	set tabpagemax=15 				" only show 15 tabs
	set showmode                   	" display the current mode

	"set cursorline  				" highlight current line
	"hi cursorline guibg=gray "#333333 	" highlight bg color of current line
	"hi CursorColumn guibg=gray "#333333   " highlight cursor

	if has('cmdline_info')
		set ruler                  	" show the ruler
		set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
		set showcmd                	" show partial commands in status line and
									" selected characters/lines in visual mode
	endif

	if has('statusline')
        set laststatus=2

		" Broken down into easily includeable segments
        set statusline=%<%f\    " Filename
        set statusline+=%w%h%m%r " Options
        set statusline+=%{fugitive#statusline()} "  Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=\ [%{getcwd()}]          " current dir
        set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
	endif

	set backspace=indent,eol,start	" backspace for dummys
	set linespace=0					" No extra spaces between rows
	set nu							" Line numbers on
	set showmatch					" show matching brackets/parenthesis
	set incsearch					" find as you type search
	set hlsearch					" highlight search terms
	set winminheight=0				" windows can be 0 line high 
	set ignorecase					" case insensitive search
	set smartcase					" case sensitive when uc(upper case characters) present
	set wildmenu					" show list instead of just completing
	set wildmode=list:full	        " command <Tab> completion, list matches, then longest common part, then all.
	set whichwrap=b,s,h,l,<,>,[,]	" backspace and cursor keys wrap to
	set scrolljump=5 				" lines to scroll when cursor leaves screen
	set scrolloff=3 				" minimum lines to keep above and below cursor
	set foldenable  				" auto fold code
	set foldmethod=indent           " 
	set foldlevel=99                " 
	"set gdefault					" the /g flag on :s substitutions by default
    "set list                       
    "set listchars=tab:>.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace

" }

" Formatting {
    "set lbr
    "set tw=500
	set wrap                     	" wrap long lines
	set autoindent                 	" indent at the same level of the previous line
	set smartindent                 
	set shiftwidth=4               	" use indents of 4 spaces
	set expandtab 	  	     		" tabs are spaces, not tabs
	set tabstop=4 					" an indentation every four columns
	set softtabstop=4 				" let backspace delete indent
	"set matchpairs+=<:>            	" match, to be used with % 
	"nopaste turns off all the autoindenting and autocommenting that happens
	set pastetoggle=<F12>          	" pastetoggle (sane indentation on pastes)
	"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
	" Remove trailing whitespaces and ^M chars
	"autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))


    "Delete trailing white space, useful for Python ;)
    func! DeleteTrailingWS()
        exe "normal mz"
        %s/\s\+$//ge
        exe "normal `z"
    endfunc
    autocmd BufWrite *.py :call DeleteTrailingWS()

    " 第80列往后加下划线
    au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

" }

" Search {
"
    " Really useful!
    "  In visual mode when you press * or # to search for the current selection
    vnoremap <silent> * :call VisualSearch('f')<CR>
    vnoremap <silent> # :call VisualSearch('b')<CR>

    " When you press gv you vimgrep after the selected text
    vnoremap <silent> gv :call VisualSearch('gv')<CR>
    map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


    function! CmdLine(str)
        exe "menu Foo.Bar :" . a:str
        emenu Foo.Bar
        unmenu Foo
    endfunction

    " From an idea by Michael Naumann
    function! VisualSearch(direction) range
        let l:saved_reg = @"
        execute "normal! vgvy"

        let l:pattern = escape(@", '\\/.*$^~[]')
        let l:pattern = substitute(l:pattern, "\n$", "", "")

        if a:direction == 'b'
            execute "normal ?" . l:pattern . "^M"
        elseif a:direction == 'gv'
            call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
        elseif a:direction == 'f'
            execute "normal /" . l:pattern . "^M"
        endif

        let @/ = l:pattern
        let @" = l:saved_reg
    endfunction

" }


" Motion {
    let g:EasyMotion_do_mapping = 0 " Disable default mappings

    " Jump to anywhere you want with minimal keystrokes, with just one key binding.
    " `s{char}{label}`
    nmap s <Plug>(easymotion-overwin-f)
    " or
    " `s{char}{char}{label}`
    " Need one more keystroke, but on average, it may be more comfortable.
    nmap s <Plug>(easymotion-overwin-f2)

    " Turn on case-insensitive feature
    let g:EasyMotion_smartcase = 1

    " JK motions: Line motions
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
" }

" Key (re)Mappings {

	"The default leader is '\', but many people prefer ',' as it's in a standard
	"location
    " With a map leader it's possible to do extra key combinations
    " like <leader>w saves the current file
	let mapleader = ','
	let g:mapleader = ","

    " Fast saving
    nmap <leader>w :w!<cr>
    imap <leader>w <Esc>:w!<CR>i

    nmap <leader>q :q<cr>
    imap <leader>w <Esc>:q<CR>i

    " Fast editing of the .vimrc
	if has('win32') || has('win64')
	    map <leader>e :e! $VIM/_vimrc<cr>
		" When vimrc is edited, reload it
        autocmd! bufwritepost _vimrc source $VIM/_vimrc
    else 
	    map <leader>e :e! ~/.vimrc<cr>
		" When vimrc is edited, reload it
        autocmd! bufwritepost vimrc source ~/.vimrc
	endif

    


    " Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
    nnoremap ; :


	" Easier moving in tabs and windows
	" use <C-j>= to equalize all windows
	"map <C-J> <C-W>j<C-W>_
	"map <C-K> <C-W>k<C-W>_
	"map <C-L> <C-W>l<C-W>_
	"map <C-H> <C-W>h<C-W>_
	
	map <C-J> <C-W>j
	map <C-K> <C-W>k
	map <C-L> <C-W>l
	map <C-H> <C-W>h

    " Wrapped lines goes down/up to next row, rather than next line in file.
    ":nnoremap j gj
    "nnoremap k gk

    " quick reach the { or }
    nnoremap <silent> <C-d> [{
    nnoremap <silent> <C-x> ]}

    " insert mode cursor movement shortcut
    "inoremap <C-h> <Left>
    inoremap <C-j> <Down>
    inoremap <C-k> <Up>
    inoremap <C-l> <Right>
    inoremap <C-d> <DELETE>

    " command line mode 
    cnoremap <C-A> <Home>
    cnoremap <C-E> <End>
    cnoremap <C-B> <Left>
    cnoremap <C-F> <Right>
    cnoremap <C-P> <Up>
    cnoremap <C-N> <Down>

    " Smart mappings on the command line
    "cno $h e ~/
    "cno $d e ~/Desktop/
    "cno $j e ./
    "cno $c e <C-\>eCurrentFileDir("e")<cr>
    

    " The following two lines conflict with moving to top and bottom of the
    " screen
	" If you prefer that functionality, comment them out.
	"map <S-H> gT          
	"map <S-L> gt

	" Stupid shift key fixes map it in comand mode(cmap)
	"cmap W w
	cmap WQ wq
	cmap wQ wq
	"cmap Q q
	cmap Tabe tabe

	" Yank from the cursor to the end of the line, to be consistent with C and D.
	nnoremap Y y$
		
	""" Code folding options
	nmap <leader>f0 :set foldlevel=0<CR>
	nmap <leader>f1 :set foldlevel=1<CR>
	nmap <leader>f2 :set foldlevel=2<CR>
	nmap <leader>f3 :set foldlevel=3<CR>
	nmap <leader>f4 :set foldlevel=4<CR>
	nmap <leader>f5 :set foldlevel=5<CR>
	nmap <leader>f6 :set foldlevel=6<CR>
	nmap <leader>f7 :set foldlevel=7<CR>
	nmap <leader>f8 :set foldlevel=8<CR>
	nmap <leader>f9 :set foldlevel=9<CR>

    "clearing highlighted search
    nmap <leader><leader>c :nohlsearch<CR>

	" Shortcuts
	" Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
	cmap cd. lcd %:p:h

	" visual shifting (does not exit Visual mode)
	vnoremap < <gv
	vnoremap > >gv 

	" Fix home and end keybindings for screen, particularly on mac
	" - for some reason this fixes the arrow keys too. huh.
	map [F $
	imap [F $
	map [H g0
	imap [H g0
		
	" For when you forget to sudo.. Really Write the file.
	cmap w!! w !sudo tee % >/dev/null

	" tab page
    map <leader>tn :tabnew<cr>
    map <leader>te :tabedit
    map <leader>tc :tabclose<cr>
    map <leader>tm :tabmove

    " When pressing <leader>cd switch to the directory of the current open buffer
    map <leader>cd :cd %:p:h<cr>


	" ctrl+p and ctrl+n, make them choose the 1st one as default
	inoremap <expr> <C-p>      pumvisible() ? "\<C-p>" : "\<C-p><C-p>"
	inoremap <expr> <C-n>      pumvisible() ? "\<C-n>" : "\<C-n><C-n>"

    " quickfix related
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Cope
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Do :help cope if you are unsure what cope is. It's super useful!
    map <leader>cc :botright cope<cr>
    map <leader><leader>w :cw<cr>
    map <leader><leader>n :cn<cr>
    map <leader><leader>p :cp<cr>
	
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Spell checking
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Pressing ,sc will toggle and untoggle spell checking
    map <leader>sc :setlocal spell!<cr>

    "Shortcuts using <leader>
    map <leader>sn ]s
    map <leader>sp [s
    map <leader>sa zg
    map <leader>s? z=


    "PHP -> shortcut
    inoremap .. ->

    	
" }

" FileType {

    " Python {
        let python_highlight_all = 1
        au FileType python syn keyword pythonDecorator True None False self

        au BufNewFile,BufRead *.jinja set syntax=htmljinja
        au BufNewFile,BufRead *.mako set ft=mako

        au FileType python inoremap <buffer> $r return
        au FileType python inoremap <buffer> $i import
        au FileType python inoremap <buffer> $p print
        au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
        au FileType python map <buffer> <leader>1 /class
        au FileType python map <buffer> <leader>2 /def
        au FileType python map <buffer> <leader>C ?class
        au FileType python map <buffer> <leader>D ?def
    " }
    
    " Javascript {
        au FileType javascript call JavaScriptFold()
        au FileType javascript setl fen
        au FileType javascript setl nocindent

        au FileType javascript imap <c-t> AJS.log();<esc>hi
        au FileType javascript imap <c-a> alert();<esc>hi

        au FileType javascript inoremap <buffer> $r return
        au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi

        function! JavaScriptFold()
            setl foldmethod=syntax
            setl foldlevelstart=1
            syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

            function! FoldText()
                return substitute(getline(v:foldstart), '{.*', '{...}', '')
            endfunction
            setl foldtext=FoldText()
        endfunction
    " }

    " PHP {
        au BufRead,BufNewFile *.{php} set filetype=php.html
    " }
    

" }

" Plugins {

	" VCSCommand {
"		let b:VCSCommandMapPrefix=',v'
"		let b:VCSCommandVCSType='git'
	" } 
	
	" PIV {
		"let g:DisableAutoPHPFolding = 0
		"let cfu=phpcomplete#CompletePHP
	" }
	
	" Supertab {
		"let g:SuperTabDefaultCompletionType = "context"
		"let g:SuperTabContextDefaultCompletionType = '<c-x><c-o>'
	" }

	" Misc { 
		:map <C-F10> <Esc>:vsp<CR>:VTree<CR>
		" map Control + F10 to Vtree

        noremap <leader><F5> :CheckSyntax<cr>
		let g:checksyntax_auto = 1

		"comment out line(s) in visual mode -RB: If you do this, you can't
        "switch sides of the comment block in visual mode.
		"vmap  o  :call NERDComment(1, 'toggle')<CR>
		let g:NERDShutUp=1

		let b:match_ignorecase = 1
	" }
	
	" ShowMarks {
		let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
		" Don't leave on by default, use :ShowMarksOn to enable
		let g:showmarks_enable = 0
		" For marks a-z lowercase
		highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=Blue
		" For marks A-Z uppercase
		highlight ShowMarksHLu gui=bold guibg=LightRed guifg=DarkRed
		" For all other marks
		highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow
		" For multiple marks on the same line.
		highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen
	" }
	
	" Command-t {
        "let g:CommandTSearchPath = $HOME . '/Code'
        let g:CommandTMaxHeight = 15
        set wildignore+=*.o,*.obj,.git,*.pyc
        "noremap <leader>j :CommandT<cr>
        "noremap <leader>y :CommandTFlush<cr>
	" }

	" OmniComplete {
		"if has("autocmd") && exists("+omnifunc")
			"autocmd Filetype *
				"\if &omnifunc == "" |
				"\setlocal omnifunc=syntaxcomplete#Complete |
				"\endif
		"endif

		" Popup menu hightLight Group
		"highlight Pmenu	ctermbg=13	guibg=DarkBlue
        "highlight PmenuSel	ctermbg=7	guibg=DarkBlue		guifg=LightBlue
		"highlight PmenuSbar ctermbg=7	guibg=DarkGray
		"highlight PmenuThumb			guibg=Black

		"hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
		"hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
		"hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

		" some convenient mappings 
		inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
		inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
		inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
		inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
		inoremap <expr> <C-d>	   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
		inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " and make sure that it doesn't break supertab
        let g:SuperTabCrMapping = 0
        
		" automatically open and close the popup menu / preview window
		au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
		set completeopt=menu,preview,longest

        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        " => Omni complete functions
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        autocmd FileType css set omnifunc=csscomplete#CompleteCSS
        autocmd FileType python set omnifunc=pythoncomplete#Complete
   " }
   "
   " Neocomplcache {
   "
       
       "let g:neocomplcache_disable_auto_complete = 1
       "let g:neocomplcache_enable_auto_select = 1

       "inoremap <expr><C-h> neocomplcache#smart_close_popup(). "\<C-h>"
       "inoremap <expr><BS> neocomplcache#smart_close_popup(). "\<C-h>"
       "inoremap <expr><CR> neocomplcache#smart_close_popup() . "<CR>"

       "inoremap <expr><TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : "\<C-x>\<C-u>"
       "function! s:check_back_space()"{{{
           "let col = col('.') - 1
           "return !col || getline('.')[col - 1] =~ '\s'
       "endfunction"}}

   " }
	
	" Delimitmate {
		au FileType * let b:delimitMate_autoclose = 1

		" If using html auto complete (complete closing tag)
        au FileType xml,html,xhtml let b:delimitMate_matchpairs = "(:),[:],{:}"
	" }
	
	" AutoCloseTag {
		" Make it so AutoCloseTag works for xml and xhtml files as well
		"au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
	" }

	" SnipMate {
		"Note: SnipMate cannot work with pathogen in windows due to after
        "directory issue, so just copy 'after' directory to vimfiles or vim72

		"let g:snips_trigger_key = '<C-CR>'

		" Setting the author var
        " If forking, please overwrite in your .vimrc.local file
		let g:snips_author = 'ltgao <ltgao@juniper.net>'
		" Shortcut for reloading snippets, useful when developing
		nnoremap ,smr <esc>:exec ReloadAllSnippets()<cr>
	" }

	" NerdTree {
		map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
		"map <leader>e :NERDTreeFind<CR>
		nmap <leader>nt :NERDTreeFind<CR>

		let NERDTreeShowBookmarks=1
		let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
		let NERDTreeChDirMode=0
		let NERDTreeQuitOnOpen=1
		let NERDTreeShowHidden=1
		let NERDTreeKeepTreeInNewTab=1
	" }

    " NerdCommenter {

        " http://www.vim.org/scripts/script.php?script_id=1218
        " Toggle单行注释/“性感”注释/注释到行尾/取消注释
        map <leader>cc ,c<space>
        map <leader>cs ,cs
        "map <leader>c$ ,c$
        map <leader>cC ,c$
        map <leader>cu ,cu
    " }
    
    " WinManager {
        let g:winManagerWindowLayout='FileExplorer|TagList'
        nnoremap <silent> <F7> :WMToggle<cr>
	" wm map will introduce the latency for cursor movement
        "nnoremap <silent> wm :WMToggle<cr>
    " }
	
	" MRU {
	    nmap <Leader><Leader>m :MRU<CR>
        let MRU_Window_Height = 20
	    let MRU_Max_Entries = 100
	    let MRU_Max_Menu_Entries = 20
	    let MRU_Max_Submenu_Entries = 15
	" }

	" Zencoding {
	    " do not use inoremap, since <C-y> has his functionality: replicates
	    " upper line character by character
	    "imap <C-y>u <C-y>,
		"let g:user_zen_expandabbr_key = '<c-e>'
		let g:use_zen_complete_tag = 1
	    imap ;; <C-y>, 
	    map ;; <C-y>, 
	" }
    
	" Tabularize {
	    if exists(":Tabularize")
		nmap <Leader>a= :Tabularize /=<CR>
		vmap <Leader>a= :Tabularize /=<CR>
		nmap <Leader>a: :Tabularize /:<CR>
		vmap <Leader>a: :Tabularize /:<CR>
		nmap <Leader>a:: :Tabularize /:\zs<CR>
		vmap <Leader>a:: :Tabularize /:\zs<CR>
		nmap <Leader>a, :Tabularize /,<CR>
		vmap <Leader>a, :Tabularize /,<CR>
		nmap <Leader>a| :Tabularize /|<CR>
		vmap <Leader>a| :Tabularize /|<CR>
	    endif
	" }

	" Jsbeautify {
		"jsbeautify.vim 优化js代码，并不是简单的缩进，而是整个优化
		nmap <silent> <leader>js :call g:Jsbeautify()<cr>
	"}

	" Richard's plugins {
		" Fuzzy Finder {
			""" Fuzzy Find file, tree, buffer, line
			nmap <leader>ff :FufFile **/<CR>
			nmap <leader>ft :FufFile<CR>
			nmap <leader>fb :FufBuffer<CR>
			nmap <leader>fl :FufLine<CR>
			nmap <leader>fr :FufRenewCache<CR>
		" }

		" Session List {
			set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
			nmap <leader>sl :SessionList<CR>
			nmap <leader>ss :SessionSave<CR>
		" }
		
		" Buffer explorer {
			nmap <leader>b :BufExplorer<CR>
            let g:bufExplorerDefaultHelp=0       " Do not show default help.
            let g:bufExplorerShowRelativePath=1  " Show relative paths.
            let g:bufExplorerSortBy='mru'        " Sort by most recently used.
            let g:bufExplorerSplitRight=0        " Split left.
            let g:bufExplorerSplitVertical=1     " Split vertically.
            let g:bufExplorerSplitVertSize = 30  " Split width
            let g:bufExplorerUseCurrentWindow=1  " Open in new window.
        " }

        " VCS commands {
			nmap <leader>vs :VCSStatus<CR>
			nmap <leader>vc :VCSCommit<CR>
			nmap <leader>vb :VCSBlame<CR>
			nmap <leader>va :VCSAdd<CR>
			nmap <leader>vd :VCSVimDiff<CR>
			nmap <leader>vl :VCSLog<CR>
			nmap <leader>vu :VCSUpdate<CR>
		" }
		
		" php-doc commands {
			nmap <leader>pd :call PhpDocSingle()<CR>
			vmap <leader>pd :call PhpDocRange()<CR>
		" }
		
		" Debugging with VimDebugger {
			map <F11> :DbgStepInto<CR>
			map <F10> :DbgStepOver<CR>
			map <S-F11> :DbgStepOut<CR>
			map <F5> :DbgRun<CR>
			map <F6> :DbgDetach<CR>
			"map <F8> :DbgToggleBreakpoint<CR>
			map <S-F8> :DbgFlushBreakpoints<CR>
			map <F9> :DbgRefreshWatch<CR>
			map <S-F9> :DbgAddWatch<CR>
		" }

		" Taglist Variables {
            let Tlist_Ctags_Cmd = 'ctags'
			let Tlist_Auto_Highlight_Tag = 1
			let Tlist_Auto_Update = 1
			let Tlist_Exit_OnlyWindow = 1
			let Tlist_File_Fold_Auto_Close = 1
			let Tlist_Highlight_Tag_On_BufEnter = 1
			"let Tlist_Use_Right_Window = 1
			let Tlist_Use_SingleClick = 1
            nnoremap <silent> <F8> :Tlist<CR>

			let g:ctags_statusline=1
			" Override how taglist does javascript
			let g:tlist_javascript_settings = 'javascript;f:function;c:class;m:method;p:property;v:global'
		 " }

         " Cscope {
         "     "设定是否使用quickfix窗口显示cscope结果  
               "set cscopequickfix=s-,c-,d-,i-,t-,e-,f- 
               nmap <leader><leader>k :cscope kill 0<cr>
               nmap <leader><leader>a :cscope add cscope.out<cr>

         " }
         "

		 " JSON {
			nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
		 " }
		 
	" }
    
    " Tasklist {
        map <leader>td <Plug>TaskList
    " }

    " Revision History {
        map <leader>gr :GundoToggle<CR>
    " }

    " Obsolete, Rope can handle all of these !!
    " Python enhancement {
        "flake8
        "autocmd FileType python map <buffer> <F3> :call Flake8()<CR>
        "autocmd BufWritePost *.py call Flake8()
        "let g:flake8_builtins="_,apply"
        "pydiction
        let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
    " }

    " Rope {
        " some customization for Rope
        "
    "}

    " CtrlP {
        let g:ctrlp_max_files = 30000
        let g:ctrlp_match_window = ''
        let g:ctrlp_follow_symlinks=1
    "}

    " Python-mode {
        "let g:pymode_rope_completion_bind = '<S-Space>'
        "let g:pymode_rope_completion_bind = "<c-x><c-o>"
        let g:pymode_rope_goto_definition_cmd = 'vnew'
        let g:pymode_breakpoint_cmd = ''
    " }

    " Powerline {
        "require vim compiled with flag --with-features=big, not enabled now
        "let g:Powerline_symbols = 'fancy'
    " }
" }

" GUI Settings {
	" GVIM- (here instead of .gvimrc)
	if has('gui_running')
        set guioptions-=m           " remove the menu
		set guioptions-=T          	" remove the toolbar
		set lines=40               	" 40 lines of text instead of 24,
		"set transparency=5          " Make the window slightly transparent

    map <silent> <F2> :if &guioptions =~# 'T' <Bar>
            \set guioptions-=T <Bar>
            \set guioptions-=m <bar>
        \else <Bar>
            \set guioptions+=T <Bar>
            \set guioptions+=m <Bar>
        \endif<CR>
	else
		"set term=builtin_ansi       " Make arrow and other keys work
	endif

    "窗口自动最大化，Linux下需要安装wmctrl
    if has("win32")
        au GUIEnter * simalt ~x
    else
        function Maximize_Window()
            silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
        endfunction
        au GUIEnter * call Maximize_Window()
    endif

    "记录上一次离开文件时cursor的位置
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" |
    \ endif

" }

function! InitializeDirectories()
  let separator = "."
  let parent = $HOME 
  let prefix = '.vim'
  let dir_list = { 
			  \ 'backup': 'backupdir', 
			  \ 'views': 'viewdir', 
			  \ 'swap': 'directory' }

  for [dirname, settingname] in items(dir_list)
	  let directory = parent . '/' . prefix . dirname . "/"
	  if exists("*mkdir")
		  if !isdirectory(directory)
			  call mkdir(directory)
		  endif
	  endif
	  if !isdirectory(directory)
		  echo "Warning: Unable to create backup directory: " . directory
		  echo "Try: mkdir -p " . directory
	  else  
          let directory = substitute(directory, " ", "\\\\ ", "")
          exec "set " . settingname . "=" . directory
	  endif
  endfor
endfunction
"call InitializeDirectories() 

function! NERDTreeInitAsNeeded()
    redir => bufoutput
    buffers!
    redir END
    let idx = stridx(bufoutput, "NERD_tree")
    if idx > -1
        NERDTreeMirror
        NERDTreeFind
        wincmd l
    endif
endfunction

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" Fixme {
    set nospell
    nnoremap <Leader><Leader>c :colorscheme default<CR>
"}

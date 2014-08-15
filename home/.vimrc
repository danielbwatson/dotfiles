let mapleader = ","

set nocompatible  " be iMproved

set title "show the file editing stuff in the console title

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

set undodir=~/tmp/vim_undo//
set backupdir=~/tmp/vim_backup//
set directory=~/tmp/vim_swp//

"omni-completion
filetype on
filetype plugin on
filetype plugin indent on
filetype indent on
set ofu=syntaxcomplete#Complete

"move on splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

"tabs
set tabstop=4
set shiftwidth=4
set autoindent
set shiftround
set smartindent
set expandtab " Replace tabs with spaces

set pastetoggle=<F12>

" Numbers
set number
set numberwidth=5

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1

" configure CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'

"Charles' somewhat weird vimrc

"don't emulate vi
set nocompatible

"show the file editign stuff in the console title
set title

let mapleader=","

"behaviors
set splitright 			" put split window on the right
set encoding=utf-8

"make searches case insensitive unless they have capitals in them
set ignorecase
set smartcase

"Treat Y as C and D work
map Y y$

"nnoremap <Esc> :noh<CR><Esc>

"select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

"short messages
set shortmess=atI

"See whitespace
set listchars=tab:>-,trail:.,eol:$,nbsp:.
nmap <silent> <leader>w :set nolist!<CR>

"sudo I forget you
cmap w!! %!sudo tee > /dev/null %

"edit vimrc and reload it
map <leader>e :e! ~/.vimrc<cr>
map <leader>s :source ~/.vimrc<cr>

map <leader>c :let @/ = ""<cr>
"remap tab keys to buffer to remain consistent
"map gt :bn<cr>
"map gT :bp<cr>

set hidden

"reformat lines
map <leader>v 0ma}b:'a,.j<CR>0100 ? <CR>i<CR><Esc>

"autoload vimrc
autocmd BufWritePost $MYVIMRC,~/.vimrc,$MYVIMRC.local nested :source $MYVIMRC

"show syntax highlighting
syntax on



"lines can only be so long for now
"set textwidth=119

"don't beep at me ever
set noerrorbells
set visualbell
set t_vb=

"keep two rows when scrolling
set scrolloff=2

"set t_Co=256
set number

if has('gui_running')
    "columns    width of the display
    set background=dark
endif

"spelling
"map <C-w> <Esc>:setlocal spell spelllang=en_us<CR>
"map <C-z> <Esc>:setlocal nospell<CR>

"perl
autocmd Filetype perl set makeprg=$VIMRUNTIME/tools/efm_perl.pl\ -c\ %\ $*
autocmd Filetype perl set errorformat=%f:%l:%m
"filetype on
"doesn't seem to read tex file properly
autocmd BufNewFile,BufRead *.tex set filetype=tex


set wildignore=*.swp
set wildignore+=*.bak
set wildignore+=*.class
set wildignore+=*.gz
set wildignore+=*.o
set wildignore+=*.pyc
set wildignore+=*.tmp
set wildignore+=*.zip
set wildignore+=*/.git/*
set wildignore+=*/.hg/*
set wildignore+=*/.svn/*
set wildignore+=*/build/*
set wildignore+=*/dist/*
set wildignore+=*/target/*

"Plugins

"Solarized
set background=dark
let g:solarized_termcolors = 256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_diffmode = "high"
colorscheme solarized

"ctrlp
map <leader>t :CtrlP<CR>
let g:ctrlp_dotfiles = 1
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others']
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

"buffergator
let g:buffergator_suppress_keymaps = 1
map <leader>b :BuffergatorToggle<CR>

"NerdTree
map <leader>n :NERDTreeToggle<CR>

"Gundo
map <leader>g :GundoToggle<CR>

"match it
ru macros/matchit.vim

"airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"syntastic
let g:syntastic_check_on_open=1
let g:syntastic_python_checker = 'pyflakes'

let g:syntastic_mode_map = { 'mode': 'active',
                            \ 'active_filetypes': [],
                            \ 'passive_filetypes': ['html'] }

augroup filetypedetect
    au BufNewFile,BufRead *.pig  set filetype=pig  syntax=pig
    au BufNewFile,BufRead *.hive set filetype=hive syntax=plsql
augroup END

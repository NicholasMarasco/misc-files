" Use Vim settings instead of Vi
" This isn't even necessary in most cases
set nocompatible

" === Pathogen ===
try
  execute pathogen#infect()
endtry

" === Vundle (Eventually) ===
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
endif
autocmd BufNewFile,BufRead *.vundle set filetype=vim

" Import user defined functions if available
if filereadable(expand("~/.vimfunc"))
  source ~/.vimfunc
endif

" === General ===
set number                     " show line numbers
set backspace=eol,start,indent " allow backspace in insert mode
set history=1000               " how much cmdline history to keep
set showcmd                    " show command in bottom bar
set showmode                   " show current mode at bottom
set guicursor=a:blinkon0       " no cusor blink
set noerrorbells               " no error notifications
set visualbell                 " no sounds
set t_vb=                      " no terminal visualbell
set autoread                   " reload file when changed externally
set hidden                     " hide buffers from view

let mapleader=","              " more easily accessible leader

" === Turn Off Swap Files ===
set noswapfile
set nobackup
set nowritebackup

" === Syntax Highlighting ===
syntax on                      " set syntax highlighting
set background=dark            " dark default for no colorscheme
try
  colorscheme best             " set custom colorscheme if exists
endtry

" === Persistent Undo ===
" Keep undo across sessions
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" === Indentation ===
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
" au! FileType python setl nosi " turn off smart indent for python

" Auto indent pasted text
nnoremap p p=`]<C-O>
nnoremap P P=`]<C-O>

filetype indent on  " load filetype specific indent files
filetype plugin on  " load filetype specific plugin files

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap          " don't hard wrap lines
set linebreak       " wrap lines at convenient places
set textwidth=71    " specificaly around this width





" UI Config
set ruler           " show column and row numbers
set cursorline      " highlight current line
set scrolloff=10    " keep 10 lines above and below cursor
set wildmenu        " visual autocomplete
set lazyredraw      " redraw only when needed
set showmatch       " highlight matching braces
set mouse=a         " enable mouse by default
set incsearch       " jump to search word as typed
set ignorecase      " ignore case when searching
set smartcase       " no ignorecase when capital is used
set fdm=marker      " marker method folding
" indent folding for python
au! FileType python set fdm=indent
set foldnestmax=2   " don't fold too deep

" make backspace work like other editors
" cursor moving can wrap to next line
set whichwrap+=<,>,h,l
"
" make vim regex act more like perl
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

" Space for easy folding
nnoremap <space> za
vnoremap <space> zf

nnoremap <F3> :wq<CR>
nnoremap gf <C-w>gf

" ignore files that I never want to edit in vim
set wildignore=*.class,*.o,*.obj,*.png,*.jpg,*.pyc,*.pdf,*.ods,*.zip,*.tar,*.odt

" linebreak at 80 characters
set lbr
set tw=80

set wrap " wrap lines

" Commands
command Q q         " I'm lazy so I fix typos
command W w
command Wq wq
command WQ wq

" Attempt at arm syntax highlighting
au BufRead,BufNewFile *.s,*.S set filetype=arm " arm = armv7/7

" Automatically comment out lines
au FileType c,cpp,java,javascript,cs let b:comment_leader = '// '
au FileType bash,zsh,sh,python,perl,make,conf,gitcommit let b:comment_leader = '# '
au FileType haskell,vhdl,ada let b:comment_leader = '-- '
au FileType vim let b:comment_leader = '" '
au FileType tex let b:comment_leader = '% '
au FileType fortran,xdefaults let b:comment_leader = '! '
if !exists("b:comment_leader")
  let b:comment_leader = '# ' " common default
endif
noremap <silent> g/ :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> g- :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

" Auto commands
"{
" Change directory into one that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
" Remove trailing whitespace in file
autocmd FileType markdown let b:noStripWhitespace=1
autocmd BufWritePre * call StripTrailingWhitespace()
"}
autocmd BufRead * retab

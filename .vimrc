" General
set history=500     " set number of history lines to remember
filetype indent on  " load filetype specific indent files
filetype plugin on  " load filetype specific plugin files
set autoread        " auto read when file is changed externally

" UI Config
set nocompatible    " generally not necessary
set number          " show line numbers
set ruler           " show column and row numbers
set showcmd         " show command in bottom bar
set cursorline      " highlight current line
set scrolloff=10    " keep 10 lines above and below cursor
set wildmenu        " visual autocomplete
set lazyredraw      " redraw only when needed
set showmatch       " highlight matching braces
set mouse=a         " enable mouse by default
set incsearch       " jump to search word as typed
set ignorecase      " ignore case when searching
set smartcase       " no ignorecase when capital is used
set hid             " hide buffer when not used
set fdm=marker      " marker method folding
" indent folding for python
au! FileType python set fdm=indent
set foldnestmax=2   " don't fold too deep

" no error sounds/effects
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" make backspace work like other editors
set backspace=eol,start,indent
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

" ignore files that I never want to edit in vim
set wildignore=*.class,*.o,*.obj,*.png,*.jpg,*.pyc,*.pdf,*.ods,*.zip,*.tar,*.odt

syntax enable       " set syntax highlighting
try
  colorscheme best  " try to set colorscheme
  set background=dark
catch
  set background=dark " darken background
endtry

set noswapfile      " swap files are annoying

" Spaces and Tabs
set expandtab       " tabs are spaces
set shiftwidth=2    " number of spaces used in auto indent
set tabstop=2       " number of spaces per tab
set softtabstop=2   " number of spaces in tab when editing

" linebreak at 80 characters
set lbr
set tw=80

set ai " auto indent
set si " smart indent
au! FileType python setl nosi " turn off smart indent for python
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
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
"}
autocmd BufRead * retab

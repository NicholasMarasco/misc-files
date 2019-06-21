" Use Vim settings instead of Vi
" This isn't even necessary in most cases
set nocompatible

" ========== Pathogen ==========
try
  execute pathogen#infect()
endtry

" ========== Vundle (Eventually) ==========
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
endif
autocmd BufNewFile,BufRead *.vundle set filetype=vim

" ========== User functions ==========
" Import user defined functions if available
if filereadable(expand("~/.vim/.vimfunc"))
  source ~/.vim/.vimfunc
endif
autocmd BufNewFile,BufRead .vimfunc set filetype=vim

" ========== General ==========
set number                     " show line numbers
set relativenumber             " show relative line numbers
set cursorline                 " highlight current line
set backspace=eol,start,indent " allow backspace in insert mode
set whichwrap+=<,>,h,l         " cursor moving can wrap
set history=1000               " how much cmdline history to keep
set showcmd                    " show command in bottom bar
set showmode                   " show current mode at bottom
set showmatch                  " highlight matching braces
set guicursor=a:blinkon0       " no cusor blink
set noerrorbells               " no error notifications
set visualbell                 " no sounds
set t_vb=                      " no terminal visualbell
set autoread                   " reload file when changed externally
set hidden                     " hide buffers from view
set lazyredraw                 " redraw only when needed
set mouse=a                    " enable mouse by default
set formatoptions-=o           " don't continue comments on pushing /O
set nostartofline              " don't jump to column 0 when possible

let mapleader=","              " more easily accessible leader

" ========== Status Line Config ==========
" outsourced to a file because it was large and unsightly
if filereadable(expand("~/.vim/.vimsline"))
  source ~/.vim/.vimsline
endif
autocmd BufNewFile,BufRead .vimsline set filetype=vim

" Recalculate warnings while idle and after saving
au CursorHold,BufWritePost * unlet! b:statusline_tab_warning
au CursorHold,BufWritePost * unlet! b:statusline_trailing_space_warning
au CursorHold,BufWritePost * unlet! b:statusline_long_line_warning

" ========== Turn Off Swap Files ==========
set noswapfile
set nobackup
set nowritebackup

" ========== Syntax Highlighting ==========
syntax on                      " set syntax highlighting
set background=dark            " dark default for no colorscheme
try
  colorscheme best             " set custom colorscheme if exists
endtry

" Attempt at arm syntax highlighting
au BufRead,BufNewFile *.s,*.S set filetype=arm " arm = armv7/7

" ========== Persistent Undo ==========
" Keep undo across sessions
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ========== Indentation ==========
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Makefiles require tabs, so don't expand
autocmd FileType make setlocal noexpandtab

" I had this on for some reason before, I don't remember why
" au! FileType python setl nosi " turn off smart indent for python

" Auto indent pasted text
nnoremap p p=`]<C-O>
nnoremap P P=`]<C-O>

filetype indent on             " load filetype specific indent files
filetype plugin on             " load filetype specific plugin files

" Display tabs and trailing spaces visually
set list listchars=tab:▷·,trail:·,nbsp:·

set nowrap                     " don't hard wrap lines
set linebreak                  " wrap lines at convenient places
set textwidth=71               " specificaly around this width

" ========== Folding ==========
set foldmethod=indent          " fold based on indentation
set foldnestmax=3              " only fold 3 levels deep
set nofoldenable               " don't fold by default

" Space for easy folding
nnoremap <space> za
vnoremap <space> zf

" ========== Tab Completion ==========
set wildmode=list:longest
set wildmenu                   " allow ctrl+n and ctrl+p for scrolling
" Set which filetypes to ignore while completing
set wildignore=*.o,*.obj,*.class,*.pyc
set wildignore+=*.zip,*.tar
set wildignore+=*.pdf,*.ods,*.odt
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*~,__pycache__/**

" ========== Scrolling ==========
set scrolloff=10                " keep 10 lines on the screen
set sidescrolloff=15            " keep 15 columns on the screen
set sidescroll=1

" ========== Search ==========
set incsearch                   " find match while typing
set hlsearch                    " highlight searches
set ignorecase                  " ignore case while typing
set smartcase                   " unless a capital is typed

" ========== Misc Mappings ==========
" make vim regex act more like perl
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

" typo correction instead of typing better
command Q q
command W w
command Wq wq
command WQ wq

" make wrapped lines easier to navigate
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

" unmap arrow key in normal mode to enforce better habits
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" function key mappings
nnoremap <F3> :wq<CR>          " ibm habits die hard
com! -complete=shellcmd -nargs=+ Shell call RunShellCommand(<q-args>)
nnoremap <F6> :call GitLogLine()<CR>

noremap gf <C-W>gf             " open file in new tab
" Clear highlighting with a redraw
noremap <silent> <C-L> :nohlsearch<CR><C-L>

" ========== Misc Autocommands ==========
" Automatically comment out lines
au FileType c,cpp,java,javascript,cs let b:comment_leader = '// '
au FileType bash,zsh,sh,python,perl let b:comment_leader = '# '
au FileType make,conf,gitcommit let b:comment_leader = '# '
au FileType haskell,vhdl,ada let b:comment_leader = '-- '
au FileType vim let b:comment_leader = '" '
au FileType tex let b:comment_leader = '% '
au FileType fortran,xdefaults let b:comment_leader = '! '
if !exists("b:comment_leader")
  let b:comment_leader = '# ' " common default
endif
noremap <silent> g/ :call CommentLine()<CR>
noremap <silent> g- :call UncommentLine()<CR>

" Change directory into one that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
" Remove trailing whitespace in file
autocmd FileType markdown let b:noStripWhitespace=1
autocmd BufWritePre * call StripTrailingWhitespace()
" Fix tabbing when opening file
autocmd BufRead * retab

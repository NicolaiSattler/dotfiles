if v:progname =~? "evim"
  finish
endif

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'rkulla/pydiction'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'hdima/python-syntax'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Shougo/vimproc.vim'
Plugin 'Quramy/tsuquyomi'

call vundle#end()

set nocompatible
set backspace=indent,eol,start 							" allow backspacing over everything in insert mode
set title
set history=1000														" keep 1000 lines of command line history
set ruler																		" show the cursor position all the time
set clipboard+=unnamed											" yanked text will go to system clipboard
set spelllang=en_us
set mouse=a																	" make mouse work properly
set showcmd																	" display incomplete commands
set showmatch
set ignorecase 			" case insensitive matching
set smartcase 			" smart case matching
set ts=2						" make tabs 2 spaces
set smarttab
set autoread				" realtime monitor changes:
set incsearch				" do incremental searching
set noundofile
set noswapfile
set nowritebackup
set nu								" line numbering
set relativenumber
set foldmethod=indent	" Enabled folding
set foldnestmax=10
set foldlevel=2
set nofoldenable
set guioptions-=r			" disable scrolling
set guioptions-=R
set guioptions-=l
set guioptions-=L
set hlsearch
set path+=./** 				" Search down into subfolders
set wildmenu 					" Display all matching files when we tab complete
set background=dark
set laststatus=2
colorscheme PaperColor

syntax on

" Flag Whitespace
au BufNewFile, BugRead *.py,*pyw,*.c,*.h,*.cs,*.ts,*.js match BadWhitespace /\s\+$/

" Tab indentation
au BufNewFile, BufRead *.js,*.ts,*.html,*.py,*.cs
	\ set tabstop=2
	\ set softtabstop=2
	\ set shiftwidth=2
au BufNewFile, BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType typescript :set makeprg=tsc

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost 	 l* nested lwindow

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" override * to search other files in directory
map <leader>* :Ggrep --untracked <cword><CR><CR> 


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Also switch on highlighting the last used search pattern.
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

filetype plugin on


" Python
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'	" https://github.com/rkulla/pydiction.git
let g:pydiction_menu_height = 3

" Markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh'] 	" plugin vim-markdown --> syntax highlighting for vim
let g:markdown_minlines = 100

let g:netrw_banner=0 
" let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s)\zs\.\S\+'

" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit

"	NERD TREE
let g:NERDTreeWin = "right"
let g:NerdTreeWinSize=35
let NERDTreeShowHidden=0
let NERDTreeIgnore= ['\.pyc$','__pycache__']

"	Airline
let g:airline_powerline_fonts = 1 
let g:airline#extensions#tabline#enabled = 1 
let g:airline_theme='papercolor'
let g:PaperColor_Theme_Options = { 
	\	'language' : { 
	\		'python' : {
	\ 			'hightlight_builitins' : 1 
	\		} 
	\	}
	\ }
"	Python syntax highlighting
let python_highlight_all = 1

" TypeScript
let g:typescript_compiler_binary = 'tsc'
"let g:typescript_compiler_options = '--lib es6'
let g:typescript_indent_disable = 1 

" fzf
let g:fzf_preview_window= 'right:60%'
let g:fzf_buffers_jump=1


" Jumping through files with tags
" ctrl-] = go to file
" ctrl-t = return to previous file
" ctrl-n = autocomplete due to ctags is more complete :) 
" note: ctrl-p previous in autocomplete list --> install exuburant-ctags
command! MakeTags !ctags -R .

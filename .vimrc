" This configuration is used for VSCode. :)
map <Space> <Leader>

set relativenumber
set scrolloff=8

inoremap jk <Esc>
" Keep cursor centered
nnoremap("<C-d>", "C-d>zz") 
nnoremap("<C-u>", "C-u>zz")
nnoremap n nzzzv
nnoremap N Nzzzv

"moving text in insert mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-1<CR>gv=gv

"moving text in virtual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
"moving text in insert mode
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
"moving text in normal mode
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==


call plug#begin()

Plug 'matze/vim-move' " Плагин для перемещения выделеного через Alt+hjkl
Plug 'tpope/vim-surround' " Вставка символа вокруг или удаление :cs
Plug 'tpope/vim-commentary' " Коментарии :gc
Plug 'tpope/vim-commentary' " +-~ на строках
Plug 'itchyny/lightline.vim' " statusline 
Plug 'junegunn/goyo.vim' " Быстрый фокус на куске 
Plug 'unblevable/quick-scope' " Подсвечивает уникальные буквы, помогает для fFtT
Plug 'vim-scripts/css_color.vim' " Подсветка hex цветовА
Plug 'dense-analysis/ale' "

call plug#end()


set laststatus=2
set noshowmode

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 1


set number
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

set tabstop=4
set shiftwidth=4
set expandtab

set list

syntax on
filetype plugin indent on

set hlsearch

set incsearch

set ignorecase
set smartcase

set backspace=indent,eol,start
set autoindent
set scrolloff=5

inoremap jk <Esc>

nnoremap ZX :w<CR>:Ex<CR>

nnoremap XZ :vs./<CR>


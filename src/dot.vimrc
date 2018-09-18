filetype plugin indent on
syntax on

set nocompatible
set number
set autoindent
set shiftwidth=2
set expandtab
set tabstop=2
set scrolloff=10
set backspace=eol,indent,start
set showcmd

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch

" Key mapping
noremap ; :
noremap : ;
noremap j  gj
noremap gj j
noremap k  gk
noremap gk k

" Remove trailing spaces
function! s:remove_trailing_spaces()
  let cursor = getpos(".")
  %s/\s\+$//ge
  call setpos(".", cursor)
  unlet cursor
endfunction
autocmd BufWritePre * call <SID>remove_trailing_spaces()

" Plugins

autocmd BufNewFile,BufRead Gemfile set filetype=ruby

" Disable vi compatibility.
set nocompatible

" Use bash for shell operations when we're running fish.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

let g:python3_host_prog = $HOME . '/.neovim-python3/bin/python'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Management
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Initialize vim-plug
call plug#begin('~/.vim/plugged')

" Vim Enhancements
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-vinegar'
Plug 'dense-analysis/ale'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

if has('python3')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" Syntax and Language Tools
Plug 'berdandy/AnsiEsc.vim'
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'hashivim/vim-terraform'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'pearofducks/ansible-vim'
Plug 'rodjek/vim-puppet'
Plug 'RobbieClarken/vim-haproxy'
Plug 'StanAngeloff/php.vim'
Plug 'dag/vim-fish'
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'

" Source Control
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Colorschemes
Plug 'icymind/NeoSolarized'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display
"   Default display and windowing options.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin on

" Enable syntax highlighting plugins
syntax enable

" Always show relative line numbers.
set number relativenumber

" Open new horizontal splits on the bottom.
set splitbelow

" Open new vertical splits on the right.
set splitright

" Disable background color erase.
set t_ut=

" Enable true color (!!)
if exists('+termguicolors')
  set termguicolors
endif

" Set default colorscheme.
colorscheme onedark
set background=dark
let g:neosolarized_contrast = "high"

" Highlight the active line.
set cursorline

" Mark 80 characters.
set colorcolumn=120

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Formatting
"   Default formatting-related options.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" How many columns to display tabs as.
set tabstop=2

" How many columns to use when adding tabs in insert mode.
set softtabstop=2

" How many columns to indent text with << and >>.
set shiftwidth=2

" Convert tabs to spaces.
set expandtab

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusbar
"   Status bar options and plugin configuration.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Force statusbar.
set laststatus=2

" Rely on the lightline plugin to inform us which mode we're in.
set noshowmode

" Minor lightline customization.
let g:lightline = {
  \  'colorscheme' : 'one',
  \  'active' : {
  \    'left' : [
  \      [ 'mode', 'paste' ],
  \      [ 'filename' , 'readonly', 'gitbranch', 'modified' ]
  \    ]
  \  },
  \  'component_function' : {
  \    'filename' : 'LightLineAbsoluteFilename',
  \    'gitbranch' : 'LightLineGitBranch'
  \  }
  \}

function! LightLineAbsoluteFilename()
  return expand('%:p')
endfunction

function! LightLineGitBranch()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Never automatically save.
set noautowrite
set noautowriteall

" Mousewheel scrolling. Note to self, to copy to system clipboard:
" OSX: Hold option while highlighting.
" Linux: Hold shift while highlighting.
set mouse=a

" Don't create swap files.
set noswapfile

" Fix delete key behavior on osx
let s:os = substitute(system("uname -s"), '\n', '', '')
if !v:shell_error && s:os == "Darwin"
  set backspace=indent,eol,start
endif

" Enable deoplete
if has('nvim') && has('python3')
  let g:deoplete#enable_at_startup = 1
endif

nmap <leader>t :TagbarOpenAutoClose<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Language Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\}

let g:ale_fix_on_save = 1

"
" ansible
"

au BufNewFile,BufRead *ansible/*.yml set filetype=yaml.ansible

" from 'pearofducks/ansible-vim'
let g:ansible_extra_syntaxes = "sh.vim"
let g:ansible_unindent_after_newline = 1

"
" golang
"
au FileType go setlocal noexpandtab
au FileType go setlocal shiftwidth=4
au FileType go setlocal softtabstop=4
au FileType go setlocal tabstop=4

" from 'fatih/vim-go'
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)

" from 'fatih/vim-go'
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_type_info = 1
"let g:go_auto_sameids = 1

"
" json
"

au FileType json setlocal foldmethod=syntax

" from 'elzr/vim-json'
" Disable concealment of doublequotes.
let g:vim_json_syntax_conceal = 0

"
" make
"

au FileType make setlocal noexpandtab
au FileType make setlocal shiftwidth=4
au FileType make setlocal softtabstop=4
au FileType make setlocal tabstop=4

"
" php
"

" from 'StanAngeloff/php.vim'
let g:php_html_load = 0
let g:php_sql_query = 0

"
" ruby
"

au FileType eruby,ruby setlocal re=1

"
" rust
"

let g:rustfmt_autosave = 1

"
" terraform
"

" from 'hashivim/vim-terraform'
let g:terraform_fmt_on_save = 1

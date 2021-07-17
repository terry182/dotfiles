" This vimrc is written by @daydreamer referencing amix/vimrc and also spf13/spf13-vim
" Last updated: 2019-03-27


" Plugin {
set nocompatible              " be iMproved, required
filetype off                  " required

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Switching to vim-plug
call plug#begin('~/.vim/plugged')

" let Vundle manage Vundle, required
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'powerline/fonts'
Plug 'trusktr/seti.vim'
Plug 'vim-syntastic/syntastic'
Plug 'lervag/vimtex'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/seoul256.vim'
"Plug 'heavenshell/vim-pydocstring'
Plug 'sirver/ultisnips',  { 'for': 'tex' }
Plug 'junegunn/goyo.vim'
Plug 'amix/vim-zenroom2'
Plug 'junegunn/limelight.vim'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" All of your Plugins must be added before the following line
call plug#end()            " required
" }
"
let g:deoplete#enable_at_startup = 1
call deoplete#custom#var('omni', 'input_patterns', {
            \ 'tex': g:vimtex#re#deoplete
            \})


" Airline settings
set laststatus=2
" let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='luna'
let g:airline_powerline_fonts=1
let g:airline#extensions#syntastic#enabled = 1  " Airline Syntastic 

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1  " Link Locations
let g:syntastic_auto_loc_list = 2             " Don't bother the list 
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" Latex settings
" let g:tex_flavor='latex'        
let g:vimtex_view_method='skim'
let g:vimtex_quick_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:vimtex_compiler_method='latexmk'
let g:vimtex_compiler_latexmk_engines = {'_':'-xelatex'}
let g:vimtex_compiler_latexmk = { 
        \ 'build_dir' : '',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable': 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [ 
        \   '-xelatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}


"Snippnet
set rtp+=~/.vim/ 
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'


filetype plugin indent on
syntax on
set mouse=a
set mousehide

" Set indent settings
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Split screen settings
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current


" Backspace worksss
set backspace=2

    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
	set history=1000
	" set spell
	set virtualedit=onemore " Allow for cursor beyond last character

" UI Settings {

    set encoding=utf8
    set background=dark     " Always a dark background isnt it
    " Colorscheme
    set t_Co=256
    let g:seoul256_background = 237
    colo seoul256
    
	set showmatch  					" Show bracket matching
 	set foldenable 					" Auto fold code
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace


	set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
	set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present


    " Line number
"    set relativenumber
    set number

    " Highlight the current line
    set cursorline

	" Searchings	
	set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms

    " Sometimes we encounter file that is big5
    set fileencodings=utf8,big5

" }


" Keyboard mappings {
    let mapleader = ','
    let maplocalleader = ','
    " Wrapped line moving 
    set wrap linebreak
    noremap j gj
    noremap k gk
    nnoremap <silent> <leader>z :Goyo<cr>
" }



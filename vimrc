" This vimrc is written by @daydreamer referencing amix/vimrc and also spf13/spf13-vim
" Last updated: 2015-11-26


" Plugin {
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'powerline/fonts'
Plugin 'jiangmiao/auto-pairs'
Plugin 'trusktr/seti.vim'
Plugin 'scrooloose/syntastic'
Plugin 'Shougo/neocomplete.vim'
Plugin 'lervag/vimtex'
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
" }

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

" Neocomplete settings{
		let g:neocomplete#enable_at_startup = 1  " Start neocomplete when vim start
		" Disable AutoComplPop.
		let g:acp_enableAtStartup = 0
		" Use neocomplete.
		let g:neocomplete#enable_at_startup = 1
		" Use smartcase.
		let g:neocomplete#enable_smart_case = 1
		" Set minimum syntax keyword length.
		let g:neocomplete#sources#syntax#min_keyword_length = 3
		let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
		
		" Define dictionary.
		let g:neocomplete#sources#dictionary#dictionaries = {
		    \ 'default' : '',
		    \ 'vimshell' : $HOME.'/.vimshell_hist',
		    \ 'scheme' : $HOME.'/.gosh_completions'
		        \ }
		
		" Define keyword.
		if !exists('g:neocomplete#keyword_patterns')
		    let g:neocomplete#keyword_patterns = {}
		endif
		let g:neocomplete#keyword_patterns['default'] = '\h\w*'
		
		" Plugin key-mappings.
		inoremap <expr><C-g>     neocomplete#undo_completion()
		inoremap <expr><C-l>     neocomplete#complete_common_string()
		
		" Recommended key-mappings.
		" <CR>: close popup and save indent.
		inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
		function! s:my_cr_function()
		  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
		  " For no inserting <CR> key.
		  "return pumvisible() ? "\<C-y>" : "\<CR>"
		endfunction
		" <TAB>: completion.
		inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
		" <C-h>, <BS>: close popup and delete backword char.
		inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
		inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
		" Close popup by <Space>.
		"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
		
		" AutoComplPop like behavior.
		"let g:neocomplete#enable_auto_select = 1
		
		" Shell like behavior(not recommended).
		"set completeopt+=longest
		"let g:neocomplete#enable_auto_select = 1
		"let g:neocomplete#disable_auto_complete = 1
		"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
		
		" Enable omni completion.
		autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
		autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
		autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
		autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
		autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
		
		" Enable heavy omni completion.
		if !exists('g:neocomplete#sources#omni#input_patterns')
		  let g:neocomplete#sources#omni#input_patterns = {}
		endif
		"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
		"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
		let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
		
		" For perlomni.vim setting.
		" https://github.com/c9s/perlomni.vim
		let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"}

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

    set background=dark     " Always a dark background isnt it
    " Colorscheme
    set t_Co=256
    colo smyck256
    
	set showmatch  					" Show bracket matching
 	set foldenable 					" Auto fold code
	set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

	set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
	set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present


    " Line number
    set relativenumber
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
    " Wrapped line moving 
    noremap j gj
    noremap k gk
" }


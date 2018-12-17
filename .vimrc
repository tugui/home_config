let mapleader=";"
" shorcut: 
" ; + t
" ; + tt
" ; + f
" ; + p
" :b#

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
	" alternatively, pass a path where Vundle should install plugins
	"call vundle#begin('~/some/path/here')

	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'

	" The following are examples of different formats supported.
	" Keep Plugin commands between vundle#begin/end.
	" plugin on GitHub repo
	Plugin 'tpope/vim-fugitive'
	" plugin from http://vim-scripts.org/vim/scripts.html
	" Plugin 'L9'
	" Git plugin not hosted on GitHub
	" The sparkup vim script is in a subdirectory of this repo called vim.
	" Pass the path to set the runtimepath properly.
	Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
	" Install L9 and avoid a Naming conflict if you've already installed a
	" different version somewhere else.
	" Plugin 'ascenator/L9', {'name': 'newL9'}
	
	Plugin 'Valloric/YouCompleteMe'

	Plugin 'Chiel92/vim-autoformat'

	Plugin 'powerline/fonts'

	Plugin 'scrooloose/syntastic'

	Plugin 'vim-airline/vim-airline'
	
	Plugin 'vim-airline/vim-airline-themes'

	Bundle 'majutsushi/tagbar'  

	Bundle 'scrooloose/nerdtree'

	Bundle 'scrooloose/nerdcommenter'
	
	Bundle 'Xuyuanp/nerdtree-git-plugin'

	Bundle 'ctrlpvim/ctrlp.vim'

	Bundle 'Lokaltog/vim-easymotion'

	" All of your Plugins must be added before the following line
	call vundle#end()            " required
	filetype plugin indent on    " required
	" To ignore plugin indent changes, instead use:
	"filetype plugin on
	"
	" Brief help
	" :PluginList       - lists configured plugins
	" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
	" :PluginSearch foo - searches for foo; append `!` to refresh local cache
	" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
	"
	" see :h vundle for more details or wiki for FAQ
	" Put your non-Plugin stuff after this line

set nu
set autochdir
set tags=tags;$HOME
set cindent
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Color scheme
let g:molokai_original=1
let g:rehash256=1

" Javascript syntax hightlight
syntax enable
syntax on

" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile Appraisals set filetype=ruby
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd Syntax javascript set syntax=jquery

colorscheme molokai
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" NERDtree
let NERDChristmasTree=0
let NERDTreeWinSize=20
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
nnoremap <leader>t :NERDTreeToggle<CR>

" Automatically open a NERDTree if no files where specified
autocmd vimenter * if !argc() | NERDTree | endif

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" apt-vim
execute pathogen#infect()
call pathogen#helptags()

" Tagbar
"
" shorcut: 
" switch - control+ww
" p - look at definition
" Enter - jump to definition
let g:tagbar_width=24
let g:tagbar_autofocus=1
let g:tagbar_ctags_bin='/usr/bin/ctags'
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
nnoremap <leader>tt :TagbarToggle<CR>

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_wq=0
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

function! SyntasticCheckHook(errors)
	if !empty(a:errors)
		let g:syntastic_loc_list_height = min([len(a:errors), 6])
	endif
endfunction

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Youcompleteme
let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_error_symbol='>>'
let g:ycm_warning_symbol='->'
let g:ycm_confirm_extra_conf=0
let g:ycm_complete_in_comments=1
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_collect_identifiers_from_tags_files=1

nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>ge :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gg :YcmDiags<CR>

" airline
set laststatus=2
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_theme="deus" 
let g:airline_detect_whitespace          = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>

if has('win32')
	set guifont=Hermit:h13
	set guifontwide=Microsoft_YaHei_Mono:h12
endif

" ctrlp
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

" easymotion
map <Leader> <Plug>(easymotion-prefix)

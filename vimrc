let mapleader=" "
syntax on
set number
set relativenumber
set wrap
set showcmd
set wildmenu
set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase
set signcolumn=number

set ruler
set cursorline
syntax enable
syntax on
set clipboard+=unnamedplus
set nocompatible
filetype off
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
set encoding=UTF-8
let &t_ut=''
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set scrolloff=4
set list
set listchars=tab:\|\ ,trail:▫


" Prevent auto line split
set tw=0
set indentexpr=
" Better backspace
set backspace=indent,eol,start

set foldmethod=indent
set foldlevel=99

let &t_EI = "\<Esc>[1 q"
let &t_SR = "\<Esc>[3 q"
let &t_SI = "\<Esc>[5 q"

noremap J 5j
noremap L 5l
noremap I 5i
noremap K 5k
noremap <LEADER><CR> :nohlsearch<CR>
map <LEADER><LEADER> <ESC>/<++><CR>:nolsearch<CR>c4l


" Compile function
map r :call CompileRunGc()<CR>
func! CompileRunGc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'java' 
    exec "!javac %" 
    exec "!java %<"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    set splitright
    ":vsp
    ":vertical resize-10
    :sp
    :term python3 %
  elseif &filetype == 'html'
    exec "Bracey"
  elseif &filetype == 'markdown'
    exec "MarkdownPreview"
  elseif &filetype == 'tex'
    exec "!xelatex %"
  endif
endfunc

map s <nop>
map S :w<CR>
map Q :q<CR>
noremap n nzz
noremap N Nzz
noremap <C-H> ^
noremap <C-l> $
noremap ; :
vnoremap Y "+y

map sv <C-w>s
map sh <C-w>v

noremap ' <C-w>
map w<up> :res +5<CR>
map w<down> :res -5<CR>
map w<left> :vertical resize-5<CR>
map w<right> :vertical resize+5<CR>

map <LEADER>t :tabe<CR>
map [ :-tabnext<CR>
map ] :+tabnext<CR>

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-bufferline'
Plugin 'vim-airline/vim-airline'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'sainnhe/everforest'
Plugin 'preservim/nerdtree'
Plugin 'ryanoasis/vim-devicons'
Plugin 'PhilRunninger/nerdtree-visual-selection'
Plugin 'turbio/bracey.vim'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

call vundle#end()

" YouCompleteMe
set completeopt-=preview
let g:ycm_clangd_binary_path = trim(system('brew --prefix llvm')).'/bin/clangd'
highlight YcmErrorLine guibg=#3f0000
nmap <LEADER>fw <Plug>(YCMFindSymbolInWorkspace)
nmap <LEADER>fd <Plug>(YCMFindSymbolInDocument)
let g:ycm_error_symbol = '#'
let g:ycm_warning_symbol = '#'
let g:ycm_enable_diagnostic_highlighting = 0

" vim theme
set background=dark
let g:everforest_background = 'soft'
let g:everforest_better_performance = 1
let g:airline_theme = 'everforest'

colorscheme everforest

" airline
let g:airline#extensions#tabline#enabled = 1

" nerdtree
autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
nnoremap <C-n> :NERDTreeToggle<CR>

" bracey
let g:bracey_refresh_on_save = 1

" Tagbar
nmap <F12> :TagbarToggle<CR>

" Snippets
let g:UltiSnipsExpandTrigger="<right>"
let g:UltiSnipsJumpForwardTrigger="<c-a>"
let g:UltiSnipsJumpBackwardTrigger="<c-d>"

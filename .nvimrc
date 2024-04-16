call plug#begin('~/.config/nvim/plugged')
" plugins
"Plug 'scrooloose/nerdtree'
"Plug 'jistr/vim-nerdtree-tabs'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'preservim/nerdcommenter'
"Plug 'kchmck/vim-coffee-script'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'scrooloose/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-fugitive'
"Plug 'tommcdo/vim-fubitive'
Plug 'yggdroot/indentline'
Plug 'gioele/vim-autoswap'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-obsession'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-surround'
Plug 'mileszs/ack.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" Plug 'ternjs/tern_for_vim'
Plug 'othree/javascript-libraries-syntax.vim'
"Plug 'Quramy/tsuquyomi'
"Plug 'leafgarland/typescript-vim'
Plug 'jparise/vim-graphql'
Plug 'ryanoasis/vim-devicons'
Plug 'int3/vim-extradite'
Plug 'rbong/vim-flog'
Plug 'idanarye/vim-merginal'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'jiangmiao/auto-pairs'
Plug 'EdenEast/nightfox.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'itchyny/lightline.vim'
Plug 'numToStr/Comment.nvim'
Plug 'tpope/vim-rhubarb'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ap/vim-css-color'

" All of your Plugins must be added before the following line
call plug#end()

" general settings
set autoindent
set number
set laststatus=2
set nowrap
set showmatch
set cursorline
set guioptions=
set hlsearch
set encoding=utf-8
set backupcopy=yes
set splitright
set noscrollbind
set clipboard+=unnamed
set backspace=indent,eol,start
set formatoptions+=j
syntax on
autocmd StdinReadPre * let s:std_in=1
lua require'nvim-tree'.setup {}
lua require('Comment').setup()
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" let g:deoplete#enable_at_startup = 1

" always shows another line after scrolling
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" autocomplete commands
set wildmenu
set wildmode=longest:full,full

" tab behavior
set expandtab
set tabstop=2
set shiftwidth=2
set smarttab

" backup path
set directory=~/.config/nvim/backup/swp/
set backupdir=~/.config/nvim/backup/backup/
set udf
set udir=~/.config/nvim/backup/undo/

" color scheme
set termguicolors
colorscheme nightfox
set background=dark

" enable italic and bold
highlight Statement gui=bold cterm=bold
highlight Comment gui=italic cterm=italic
highlight Identifier gui=italic cterm=italic

" statusline
"let g:airline_powerline_fonts = 1
"let g:airline_theme='molokai'
"let g:airline#extensions#tabline#enabled = 1
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}

" ctrlp behavior
let g:ctrlp_custom_ignore = 'node_modules\|bower_components\|.git\|public\|build\'
let g:ctrlp_cmd = 'CtrlP /Users/rui/dev'

" Ack behavior
cnoreabbrev ag Ack!
let g:ackprg = 'ag --vimgrep --smart-case'

" JS libraries support
let g:used_javascript_libs = 'underscore,react'

" key remap
nnoremap <Space> :
nnoremap <Enter> a<Enter><Esc>
"nnoremap ; :NERDTreeToggle<CR>
"nnoremap <A-;> :NERDTreeFind<CR>
nnoremap ; :NvimTreeToggle<CR>
nnoremap ;; :NvimTreeFindFile<CR>
"nnoremap <C-_> :call NERDComment(0, "toggle")<CR>
"vnoremap <C-_> :call NERDComment(0, "toggle")<CR>
tnoremap <Esc> <C-\><C-n>
nnoremap <C-n> :nohl<CR>

" normal mode spacing
nnoremap <a-h> i<Space><Esc>
nnoremap <a-j> o<Esc>
nnoremap <a-k> O<Esc>
nnoremap <a-l> a<Space><Esc>

" insert mode navigation
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>

" buffer navigation
nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>

" use system clipboard
inoremap <C-v> <ESC>"+pa<ESC>
vnoremap <C-c> "+y
vnoremap <C-x> "+d

" search for selected text in visual mode
vnoremap <Space> y:Ack! <C-r>"<C-b>
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" reload rc file
command! RC source ~/.config/nvim/init.vim

" extradite behavior
command! Ghistory Extradite!

" merginal behavior
command! Gbranch Merginal

" flog behavior
command! Gtree Flogsplit

" syntastic settings
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" delay gitgutter to prevent slowness
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" auto remove trailing whitespaces
autocmd BufWritePre *.coffee :Format
autocmd BufWritePre *.js :Format
autocmd BufWritePre *.jsx :Format
autocmd BufWritePre *.scss :Format
autocmd BufWritePre *.ts :Format
autocmd BufWritePre *.tsx :Format
autocmd BufWritePre *.graphql :Format

" apply macro on visually selected lines
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" adjust devicons alignment in NERDTree
"let g:WebDevIconsUnicodeGlyphDoubleWidth = 0
"let g:WebDevIconsNerdTreeGitPluginForceVAlign = 0

" enable NERDTree syntax highlighting for full name
"let g:NERDTreeFileExtensionHighlightFullName = 1
"let g:NERDTreeExactMatchHighlightFullName = 1
"let g:NERDTreePatternMatchHighlightFullName = 1

" reduce NERDTree lags from syntax highlighting
"let g:NERDTreeLimitedSyntax = 1
"let g:NERDTreeSyntaxEnabledExtensions = ['ejs', 'ts']
"let g:NERDTreeHighlightCursorline = 0

" delete integrity check from yarn.lock files
cnoreabbrev di g/integrity\ /d

" format JSON file
cnoreabbrev JSON %!python -m json.tool

" set up bufferline
lua << EOF
require("bufferline").setup{}
require('Comment').setup()
EOF

" lightline behavior
let g:lightline = {
\  'colorscheme': 'one',
\  'enable': {
\    'tabline': 0
\  }
\}

" coc extensions
let g:coc_global_extensions = [
\ 'coc-pairs',
\ 'coc-tsserver',
\ 'coc-graphql',
\ 'coc-json',
\ 'coc-prettier',
\ 'coc-eslint',
\]

" coc config
let g:coc_node_path = '/Users/rui/.volta/tools/image/node/18.13.0/bin/node'
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
" Symbol renaming.
nmap <C-m> <Plug>(coc-rename)

" Vim-plug setup {{{1
filetype off
call plug#begin('$XDG_DATA_HOME/nvim/plugged')


" Plugin 'Shougo/neocomplete.vim'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'roxma/nvim-completion-manager'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-ultisnips'

Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'majutsushi/tagbar'
Plug 'rking/ag.vim'
Plug 'chriskempson/base16-vim'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'honza/dockerfile.vim'
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'myusuf3/numbers.vim'
" Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'godlygeek/tabular'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'autozimu/LanguageClient-neovim', { 'tag': 'binary-*-x86_64-unknown-linux-musl' }
Plug 'junegunn/fzf.vim'
" Plug 'raimondi/delimitmate'
" Snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
" Org mode
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
" glsl
Plug 'tikhomirov/vim-glsl'
Plug 'dag/vim-fish'
"
" Haskell
"
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'bitc/vim-hdevtools', { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }

call plug#end()
filetype plugin indent on

" Setup {{{1
" colorscheme solarized
let base16colorspace=256
let g:solarized_base16=1
" set t_Co=256
colorscheme base16-atelier-dune
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
set mouse=a
" FZF mappings
nmap <c-p> :Files<cr>
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Options {{{1
set bg=dark
set cursorline
set expandtab
set foldmethod=marker
set hidden
set ignorecase
set list
" set listchars=tab:▸\ ,eol:¬
set noequalalways
" set nohlsearch
set nojoinspaces
set number
set pastetoggle=<leader>p
set shiftwidth=2
set smartcase
set smartindent
set softtabstop=2
set splitbelow
set splitright
" Kill the damned Ex mode.
nnoremap Q <nop>

" Completion {{{1
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c

au TextChangedI * call ncm2#auto_trigger()

" Haskell settings {{{1
au FileType haskell nnoremap <buffer> <leader>1 :GhcModType<CR>
au FileType haskell nnoremap <buffer> <silent> <leader>2 :GhcModTypeClear<CR>
au FileType haskell nnoremap <buffer> <silent> <leader>3 :GhcModInfoPreview<CR>
au FileType haskell nnoremap <buffer> <silent> <leader>4 :GhcModLint<CR>
au FileType haskell nnoremap <buffer> <silent> <leader>5 :GhcModCheck<CR>
au FileType haskell nnoremap <buffer> <silent> <leader>6 :GhcModCheckAndLintAsync<CR>
au FileType haskell nnoremap <buffer> <leader>t :GhcModTypeInsert<CR>
au FileType haskell nnoremap <buffer> <leader>f :GhcModSigCodegen<CR>
au FileType haskell let &formatprg="stylish-haskell"

let g:haskell_tabular = 1

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

set tags=tags;/,codex.tags;/

let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

" Generate haskell tags with codex and hscope
map <leader>tg :!codex update --force<CR>:call system("git-hscope -X TemplateHaskell")<CR><CR>:call LoadHscope()<CR>

map <leader>tt :TagbarToggle<CR>

set csprg=hscope
set csto=1 " search codex tags first
set cst
set csverb
nnoremap <silent> <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
" Automatically make cscope connections
function! LoadHscope()
  let db = findfile("hscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/hscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /*.hs call LoadHscope()

" Hoogle the word under the cursor
nnoremap <silent> <leader>hh :Hoogle<CR>

" Hoogle and prompt for input
nnoremap <leader>hH :Hoogle

" Hoogle for detailed documentation (e.g. "Functor")
nnoremap <silent> <leader>hi :HoogleInfo<CR>

" Hoogle for detailed documentation and prompt for input
nnoremap <leader>hI :HoogleInfo

" Hoogle, close the Hoogle window
nnoremap <silent> <leader>hz :HoogleClose<CR>

" }}}

" Syntastic {{{1
map <Leader>s :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" Supertab {{{1
" let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

" if has("gui_running")
"   imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
" else " no gui
"   if has("unix")
"     inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
"   endif
" endif

" let g:haskellmode_completion_ghc = 1
" autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc


" Mappings{{{1
" Type 1. something<C-j> for 2.
" inoremap <C-j> <esc>:exe "norm Ypf lDB\<C-a>"<cr>A
" Window handling
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
vnoremap <C-c> "+ygv"*y
" Buffer handling mappings
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <Space> za
" Leaders{{{1
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>z :wq<cr>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>bm :CtrlPMixed<CR>
nnoremap <leader>bs :CtrlPMRU<CR>
" NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>
" fugitive{{{1
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gp :Gpush<cr>
nnoremap <leader>gw :Gwrite<cr>
" Rust{{{1
" autocmd FileType rust let g:syntastic_rust_checkers = ['cargo']
let g:rustfmt_autosave = 1
let g:racer_cmd = "~/.cargo/bin/racer"
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ }
" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <leader>rr :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <leader>ru :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> <leader>rs :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <leader>rf :call LanguageClient_textDocument_formatting()<CR>
nnoremap <silent> <M-Enter> :call LanguageClient_textDocument_codeAction()<CR>

" Fzf{{{1
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

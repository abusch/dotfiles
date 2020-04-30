" Fish doesn't play all that well with others
set shell=/bin/bash
" let mapleader = "\<Space>"

" Enable true color
if has("termguicolors")
  set termguicolors
endif

" Vim-plug setup {{{1
filetype off
call plug#begin('$XDG_DATA_HOME/nvim/plugged')

" Semantic checking / LSP client / Completion engine
" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Theme
Plug 'arcticicestudio/nord-vim'
Plug 'myusuf3/numbers.vim'
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
Plug 'godlygeek/tabular'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Language support
Plug 'honza/dockerfile.vim'
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'cespare/vim-toml'
Plug 'tikhomirov/vim-glsl'
Plug 'dag/vim-fish'
" Snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()
filetype plugin indent on

" Setup {{{1
let g:nord_italic = 1
let g:nord_italic_comments = 1
colorscheme nord
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

" Options {{{1
set mouse=a
set bg=dark
set cursorline
set expandtab
set foldmethod=syntax
set hidden
set ignorecase
set list
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
set completeopt=noinsert,menuone,noselect
set shortmess+=c

" Mappings{{{1
" Type 1. something<C-j> for 2.
" inoremap <C-j> <esc>:exe "norm Ypf lDB\<C-a>"<cr>A
" Window handling
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l
" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

" imap <C-h> h
" imap <C-j> j

" Copy to system clipboard
vnoremap <C-c> "+ygv"*y
" Buffer handling mappings
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
" nnoremap <Space> za
" Leaders{{{1
" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>z :wq<cr>
nmap <leader>bq :bp <BAR> bd #<CR>
nnoremap <leader>bb :Buffers<CR>
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
let g:rustfmt_autosave = 1
let g:racer_cmd = "~/.cargo/bin/racer"

" Fzf{{{1
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
nmap <c-p> :Files<cr>
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

let g:UltiSnipsExpandTrigger="<c-tab>"

"CoC{{{1
" coc settings
" Completion
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)


" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

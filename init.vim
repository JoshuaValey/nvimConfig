"Commond Github Repos
"https://github.com/neovim/nvim-lspconfig
"

"---------------------- Plug section ---------------------
"---------------------------------------------------------
call plug#begin('~/AppData/Local/nvim/plugged')
" THEMES 
Plug 'tomasr/molokai', {'as':'molokai'}
" END THEMES

Plug 'jiangmiao/auto-pairs',
Plug 'vim-airline/vim-airline' "Barra de modos 
Plug 'vim-airline/vim-airline-themes'  
Plug 'neovim/nvim-lspconfig' " LSP
Plug 'tpope/vim-surround' "Cambiar los caracquetes (') que encierran una frace // cs<actchar><newchar>
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Auto Completado
Plug 'neoclide/coc-css'
Plug 'davidhalter/jedi-vim' "Python plugin
Plug 'nvim-lua/completion-nvim'
Plug 'SirVer/ultisnips'
Plug 'mattn/emmet-vim'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary' " easy comments with `gc` or `gcc`

"Js Plugins
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'mlaursen/vim-react-snippets'
"React Plugins
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

call plug#end() 

"--------------------- End Plug section ----------------------


"--------------------- Set section ---------------------
"-------------------------------------------------------
syntax enable
set number
set rnu
set noswapfile
set mouse =a 
set showcmd "Mostrar comandos"
set encoding=utf-8
set showmatch "Mostrar donde termina un parentesis, corchete, etc..."
set background =dark
set cursorline
set incsearch "marchar busquedas in y hl "
set hlsearch
set list
let mapleader=" "
nnoremap <SPACE> <Nop>
"set listchars=tab:›\ ,eol:¬,trail:⋅
set listchars=tab:›\ ,trail:⋅ "Llenar espacios con puntos
set splitright

"Set Tab config
set autoindent
set expandtab
set softtabstop =4
set shiftwidth =4
set shiftround
" End Tab config

"--------------------- End Set section ---------------------

"--------------------- General Config --------------------
"---------------------------------------------------------
colorscheme molokai
let g:molokai_original = 1

"---- LSP Configuration

lua << EOF
require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach} 
require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach} 
require'lspconfig'.dartls.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.emmet_ls.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.java_language_server.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.csharp_ls.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.jsonls.setup{on_attach=require'completion'.on_attach}
EOF

"Mover una linea arriba y abajo
nnoremap <c-k>  :m .-2<CR>== "Mover la linea actual hacia arriba
nnoremap <c-j>  :m .+1<CR>==  "Mover la linea actual hacia abajo
vnoremap <c-k>:m '<-2<CR>gv=gv
vnoremap <c-j> :m '>+1<CR>gv=gv

"Snippets Configuration
let g:UtilSnipsExpandTrigger = "<c-g>"

"Emmet Configuration
let g:user_emmet_mode='n'
let g:user_emmet_leader_key =',' "Usar el <space> 2 veces para contruir las etiquetas HTML
let g:user_emmet_settings={
 \'javascript':{
    \'extends':'jsx'
\    }
\}

"Pretiier Configuration
command! -nargs=0 Prettier :CocCommand Prettier.formatFile
nnoremap <c-f> :Prettier<CR>
inoremap <c-f> :Prettier<CR>

"Commentary Configuration
nnoremap <c-c> :Commentary<CR>
inoremap <c-c> :Commentary<CR>
vnoremap <c-c> :Commentary<CR>

"Airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
nnoremap <leader>1 :bp<CR>
nnoremap <leader>2 :bn<CR>


"NERDTREE Configuration
"nnoremap <silent> <F1>: NERDTreeFind<CR> 
"nnoremap <leader> <F2>: NERDTreeToggle<CR> 
let NERDTreeQuitOnOpen=1

"Activar cuando se use JS o TS Buffers
"autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
"autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

"Config Coc
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

" auto completar archivos css
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"---------------------------- COC Recommended Config ------------------
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "<TAB>" :
      \ <SID>check_back_space() ? "<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
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
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

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

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

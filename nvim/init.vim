" Many lines taken from
" https://github.com/godlygeek/vim-files/blob/master/init.vim

""" Plugins
call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'phanviet/vim-monokai-pro'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()


""" Settings
"""" Leader
let mapleader = ' '

"""" Plugins
""" nerdtree
noremap <leader>nt :NERDTree<CR>


""" vim-monokai-pro
set termguicolors
colorscheme monokai_pro
hi Normal guibg=#222222
hi WhiteSpace guifg=white guibg=#2b2b2b
hi SpecialKey guibg=#222222
hi NonText guibg=#222222
hi EndOfBuffer guibg=#222222
hi SignColumn guibg=#191919
hi LineNr guibg=#191919 guifg=#43454a
hi WinSeparator guibg=#222222 guifg=#222222
hi MsgArea guibg=#191919

" Comments are a mild fuschia
hi Comment guifg=#b04fc6

set cursorline " Highlight current line
hi CursorLine guibg=#2b2b2b

""" vim-airline
let g:airline_theme='badwolf'
let g:airline_section_z = "%p%% \u2630 %l/%L \u33d1:%v"

""" coc.nvim
" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first choice and notify coc.nvim to format on
" enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use tab to trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? pumnext(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? pumprev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
"""" Mouse, Keyboard, Terminal
set mouse=nv                " Allow mouse use in normal and visual mode.
set timeoutlen=2000         " Wait 2 seconds before timing out a mapping
set lazyredraw              " Avoid redrawing the screen mid-command.

"""" Titlebar
set title                   " Turn on titlebar support

"  Titlebar string: hostname> ${PWD:s/^$HOME/~} || (view|vim) filename ([+]|)
let &titlestring  = hostname() . '> ' . '%{expand("%:p:~:h")}'
                \ . ' || %{&ft=~"^man"?"man":&ro?"view":"nvim"} %f %m'

"""" Moving Around/Editing
set whichwrap=b,s,h,l,<,>   " <BS> <Space> h l <Left> <Right> can change lines
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set showmatch               " Briefly jump to a paren once it's balanced
set matchtime=2             " (for only .2 seconds).

"""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.

"""" Windows, Buffers, Tabs
set noequalalways           " Don't keep resizing all windows to the same size
set hidden                  " Hide modified buffers when they are abandoned
set swb=useopen,usetab      " Allow changing tabs/windows for quickfix/:sb/etc
set splitright              " New windows open to the right of the current one

" Function to open a buffer in right split
function VerticalSplitBuffer(buffer)
    execute "vert belowright sb" a:buffer
endfunction

" Vertical Split Buffer Mapping
command -nargs=1 Vbuf call VerticalSplitBuffer(<f-args>)

" Map <leader>b[,.] to switch between open buffers
nnoremap <silent> <leader>bh :bn<CR>
nnoremap <silent> <leader>bl :bp<CR>

" Map <leader>w[hl] to switch between windows
nnoremap <silent> <leader>wh <C-w>h
nnoremap <silent> <leader>wl <C-w>l

" Map <leader>t[,.] to switch between tabs
nnoremap <leader>th :tabp<CR>
nnoremap <leader>tl :tabn<CR>

"""" Insert completion
set completeopt=menuone     " Show the completion menu even if only one choice

"""" Text Formatting
set formatoptions=q         " Format text with gq, but don't format as I type.
set formatoptions+=j        " When joining lines, remove comment leaders.
set formatoptions+=n        " gq recognizes numbered lists, and will try to
set formatoptions+=1        " break before, not after, a 1 letter word

"""" Display
set number                  " Display line numbers
set relativenumber          " and relative line numbers
set numberwidth=1           " using only 1 column (and 1 space) while possible
set signcolumn=number       " and drawing signs in the number column
set display+=uhex           " Use <03> rather than ^C for non-printing chars
set inccommand=nosplit      " Preview :s commands incrementally as you type

" In visual mode, make the cursor an underbar 15% of the cell high,
" and make it blink off for 100ms every 300ms.
set guicursor+=v:hor15-blinkon300-blinkoff100-blinkwait300

set list                    " visually represent certain invisible characters:
set listchars=              " Don't use the default markers; instead:
set listchars+=nbsp:⋅       " Use U+22C5 DOT OPERATOR for non-breaking spaces
set listchars+=trail:⋅      " and for trailing spaces at EOL,
set listchars+=tab:▷⋅       " and U+25B7 WHITE RIGHT-POINTING TRIANGLE plus
                            " zero or more DOT OPERATOR for a tab character.

"""" Messages, Info, Status
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set shortmess+=I            " Don't care about Ugandan children


"""" Tabs/Indent Levels
set tabstop=8               " Real tab characters are 8 spaces wide,
set shiftwidth=4            " but an indent level is 4 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes all 4 spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.

"""" Tags
set showfulltag             " Show more information while completing tags.
set cscopetag               " When using :tag, <C-]>, or "vim -t", try cscope:
set cscopetagorder=0        " try ":cscope find g foo" and then ":tselect foo"

"""" Reading/Writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.

"""" Backups/Swap Files
set writebackup             " Make a backup of the original file when writing
set backup                  " and don't delete it after a succesful write.
set backupskip=             " There are no files that shouldn't be backed up.
set updatetime=2000         " Write swap files after 2 seconds of inactivity.
set backupext=~             " Backup for "file" is "file~"
set backupdir^=~/.backup    " Backups are written to ~/.backup/ if possible.

"""" Command Line
set wildmenu                " Menu completion in command mode on <Tab>

"""" Per-Filetype Scripts
" NOTE: These define autocmds, so they should come before any other autocmds.
"       That way, a later autocmd can override the result of one definedhere.
filetype on                 " Enable filetype detection,
filetype indent on          " use filetype-specific indenting where available,
filetype plugin on          " also allow for filetype-specific plugins,
syntax on                   " and turn on per-filetype syntax highlighting.

""" Toggle Comment Command
"let current_ft = &ft
"noremap f


"""" Colemak bindings
" noremap f e
" noremap F E
" noremap p r
" noremap P R
" noremap g t
" noremap G T
" noremap j y
" noremap J Y
" noremap l u
" noremap L U
" noremap u i
" noremap U I
" noremap y o
" noremap Y O
" noremap ; p
" noremap : P
" noremap r s
" noremap R S
" noremap s d
" noremap S D
" noremap t f
" noremap T F
" noremap d g
" noremap D G
" noremap n j
" noremap N J
" noremap e k
" noremap E K
" noremap i l
" noremap I L
" noremap o ;
" noremap O :
" noremap k n
" noremap K N

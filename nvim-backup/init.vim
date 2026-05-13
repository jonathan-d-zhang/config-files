" Many lines taken from
" https://github.com/godlygeek/vim-files/blob/master/init.vim

""" Plugins
call plug#begin()
"Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
"Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.1.*'}
Plug 'lervag/vimtex'
Plug 'loctvl842/monokai-pro.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kiyoon/jupynium.nvim', { 'do': 'pip3 install --user .' }
call plug#end()


""" Settings
"""" Leader
let mapleader = ' '
let maplocalleader = ' '

"""" Python 3 Provider
let g:python3_host_prog = '~/.pyenv/versions/nvim/bin/python'

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
set signcolumn=yes          " and drawing signs in the number column
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

""" Tex
autocmd FileType tex setlocal spell

""" F#
" Needs `dotnet tool install --global fsautocomplete`
autocmd BufNewFile,BufRead *.fs,*.fsx,*.fsi set filetype=fsharp

"""" Plugin Config
""" vimtex
let g:vimtex_quickfix_open_on_warning = 0 " Don't warn me about warnings
let g:vimtex_view_method = "zathura"
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

"""" Python Environment
" venv created with `pyenv virtualenv 3.11.5 nvim`
let g:python3_host_prog = '/home/jz9/.pyenv/versions/nvim/bin/python'

"""" Plugin Config
""" vimtex
let g:vimtex_quickfix_open_on_warning = 0 " Don't warn me about warnings
let g:vimtex_view_method = "zathura"
nmap <localleader>v <plug>(vimtex-view)

""" LuaSnip
" Expand or jump in insert mode
imap <silent><expr> jk luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : 'jk'

" Jump forward through tabstops in visual mode
smap <silent><expr> jk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'jk'

" Jump backward through snippet tabstops with Shift-Tab.
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

lua <<EOF
require("luasnip").config.set_config({ -- Setting LuaSnip config
    -- Enable autotriggered snippets
    enable_autosnippets = true,

    -- Make stuff update as I type
    update_events = 'TextChanged,TextChangedI',

    -- Use Tab to trigger visual selection
    store_selection_keys = "<Tab>",
})

-- Lazy-load snippets
require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip/"})
EOF

""" nerdtree
noremap <leader>nt :NERDTree<CR>

""" vim-monokai-pro
set termguicolors


colorscheme monokai-pro

set cursorline " Highlight current line
hi CursorLine guibg=#2b2b2b

hi Normal guibg=#222222
hi WhiteSpace guifg=white guibg=#2b2b2b
hi SpecialKey guibg=#222222
hi NonText guibg=#222222
hi EndOfBuffer guibg=#222222
hi SignColumn guibg=#191919
hi LineNr guibg=#191919 guifg=#43454a
hi WinSeparator guibg=#222222 guifg=#222222
hi MsgArea guibg=#191919
hi CocInlayHint guifg=#b04fc6

" Comments are a mild fuschia
"hi Comment guifg=#b04fc6
hi Comment guifg=#e234da

""" tree-sitter
lua <<EOF
require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "vim", "python", "rust", "yaml" },
    sync_install = false,
    highlight = {
        enable = true,
        disable = function(lang, buf)
            local max_filesize = 100 * 1024  -- 100KiB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = false
    },
}
EOF

""" vim-airline
let g:airline_theme='badwolf'
" Alternative character, looks like 'ln' \u33d1
let g:airline_section_z = "%p%% \u2630 %l/%L:%v"

"""" Completions
lua <<EOF
local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file

-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)


-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")

-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})


-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then

        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {

    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"

})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })


-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)



-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)

keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)

keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)



-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})



-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})


-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")


-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands

keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item
keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)

-- Use `[g` and `]g` to navigate diagnostics
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '[g', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']g', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Language Servers
-- local lsp = require "lspconfig"

-- vim.g.coq_settings = {
--     -- Must be set before we import coq
--     auto_start = true,
--     completion = {
--         always = true,
--         skip_after = {},
--         smart = true,
--     },
--     keymap = {
--         -- <C-space> acts weird
--         manual_complete = "<C-s>",
--         -- Doesn't make sense outside insert mode
--         manual_complete_insertion_only = true,
--     },
--     ["limits.completion_auto_timeout"] = 0,
--
--     -- I don't mind slightly outdated results
--     ["display.pum.fast_close"] = true,
-- }
--
--
-- local coq = require "coq"
--
-- lsp.pyright.setup(coq.lsp_ensure_capabilities {})
-- lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities {
--     settings = {
--         ['rust-analyzer'] = {
--             cargo = {
--                 extraEnv = {
--                     RUSTFLAGS = "-L/usr/local/lib"
--                 }
--             },
--             server = {
--                 extraEnv = {
--                     RA_LOG = "info"
--                 }
--             },
--         }
--     }
-- })
-- lsp.ocamllsp.setup(coq.lsp_ensure_capabilities {})
--lsp.jdtls.setup(coq.lsp_ensure_capabilities {})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--   callback = function(ev)
--     -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
--
--     -- Buffer local mappings.
--     -- See `:help vim.lsp.*` for documentation on any of the below functions
--     local opts = { buffer = ev.buf }
--     vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
--     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--     vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--     vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--     vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
--     vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
--     vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
--     vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--     vim.keymap.set('n', '<space>f', function()
--       vim.lsp.buf.format { async = true }
--     end, opts)
--   end,
-- })
EOF



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


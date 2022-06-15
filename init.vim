syntax on

set ma
set mouse=a
set cursorline
set tabstop=4
set shiftwidth=4
set noexpandtab
set autoread
set nobackup
set nowritebackup
set noswapfile
set relativenumber
set foldlevelstart=99
set encoding=UTF_8
syntax enable
set scrolloff=7
set clipboard+=unnamedplus
set number
set hidden
set confirm
set autowriteall
set wildmenu wildmode=full
set splitright
set cursorline
set cursorcolumn
call plug#begin('~/.config/nvim/plugged/')

"Colour Scheme
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'shaunsingh/nord.nvim', {'as': 'nord'}
Plug 'sainnhe/edge', {'as': 'edge'}
Plug 'folke/tokyonight.nvim',{'branch': 'main'}
"Syntax plugin
Plug 'vim-syntastic/syntastic'

"Auto complete
Plug 'Pocco81/AutoSave.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'
Plug 'neovim/nvim-lspconfig'
"Nav plugins
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'preservim/NERDTree'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'preservim/tagbar'

"Git

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
"Comment Plugin
Plug 'preservim/nerdcommenter'

"Auto-format plugin
Plug 'sbdchd/neoformat'

"Code Folding
Plug 'tmhedberg/SimpylFold'

"Web
Plug 'turbio/bracey.vim'
call plug#end()
 " Important!!
        if has('termguicolors')
          set termguicolors
        endif

let g:tokyonight_transparent = 1
let g:tokyonight_italic_function = 1
colorscheme tokyonight
let mapleader = " "
inoremap ;; <Esc>

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
    endif

"Disable relative number

nnoremap <silent> <leader>ln :set rnu!<CR>


"Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"Tagbar
nnoremap <silent> <leader>tb :TagbarToggle<CR>
nnoremap <silent> <leader>nt :NERDTreeToggle<CR>


"Buffers
nnoremap <silent> <leader>cb :bd<CR>
"To use `ALT+{h,j,k,l}` to navigate windows from any mode:
    :tnoremap <A-h> <C-\><C-N><C-w>h
    :tnoremap <A-j> <C-\><C-N><C-w>j
    :tnoremap <A-k> <C-\><C-N><C-w>k
    :tnoremap <A-l> <C-\><C-N><C-w>l
    :inoremap <A-h> <C-\><C-N><C-w>h
    :inoremap <A-j> <C-\><C-N><C-w>j
    :inoremap <A-k> <C-\><C-N><C-w>k
    :inoremap <A-l> <C-\><C-N><C-w>l
    :nnoremap <A-h> <C-w>h
    :nnoremap <A-j> <C-w>j
    :nnoremap <A-k> <C-w>k
    :nnoremap <A-l> <C-w>l


" Auto start NERD tree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
	TagbarClose
	NERDTreeClose
       

    else
	set foldcolumn=0
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2 
        set showcmd
	NERDTree
	" NERDTree takes focus, so move focus back to the right
	" (note: "l" is lowercase L (mapped to moving right)
	wincmd l
	TagbarOpen

    endif
endfunction

nnoremap <silent> <leader>h :call ToggleHiddenAll()<CR>

lua << EOF
local autosave = require("autosave")

autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
EOF

"     _   __                _         
"    / | / /__  ____ _   __(_)___ ___ 
"   /  |/ / _ \/ __ \ | / / / __ `__ \
"  / /|  /  __/ /_/ / |/ / / / / / / /
" /_/ |_/\___/\____/|___/_/_/ /_/ /_/ 
                                    
" NEOVIM CONFIG (~/.config/nvim/init.vim)
" -------------------------------------------------

" PLUGIN STUFF
set termguicolors

call plug#begin('~/.config/nvim/plugged')
  Plug 'valloric/youcompleteme'                         " Autocompletion
  Plug 'vimsence/vimsence'                              " Discord Presence
  Plug 'jiangmiao/auto-pairs'                           " Auto-pair (insert brackets, quotes, etc. in pair)
  Plug 'ghifarit53/tokyonight-vim'                      " Tokyo Night colorscheme
  Plug 'norcalli/nvim-colorizer.lua'                    " Colorize hex codes
  Plug 'itchyny/lightline.vim'                          " Lightline status Bar
"  Plug 'drewtempelmeyer/palenight.vim'                  " Palenight colorscheme
"  Plug 'dracula/vim', { 'as': 'dracula' }               " Dracula colorscheme
call plug#end()

" Tokyo Night
let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_enable_italic = 1 " available: 0, 1

" Set colorscheme
colorscheme tokyonight

" Lightline colorscheme
let g:lightline = {'colorscheme': 'tokyonight'}

" Required by Colorizer
lua require'colorizer'.setup()

" Vimsence
let g:vimsence_small_text = 'NeoVim'
let g:vimsence_small_image = 'neovim'
let g:vimsence_editing_details = 'Making bugs in: {}'
let g:vimsence_editing_state = 'Directory: {}'
" -------------------------------------------------

" GENERAL
set number relativenumber " Line numbers
set nobackup              " No backup file
set noswapfile            " No swap file

set expandtab             " Use spaces instead of tabs.
set smarttab              " Be smart using tabs ;)
set shiftwidth=4          " One tab == four spaces.
set tabstop=4             " One tab == four spaces.

set nowrap                " Disable text wrapping
set nohlsearch            " Don't highlight after search
set incsearch             " Highlight live while searching
set scrolloff=10          " Scroll screen when cursor is 10 lines away
" -------------------------------------------------

" KEY CONFS

" Set leader key to space
let mapleader = ' '

" F1/F2 to move up/down 5 lines
noremap <F1> 5k<CR>
noremap <F2> 5j<CR>

" Directory operations
nnoremap <leader>f :Explore<CR>
nnoremap <leader>p :!pwd<CR>
nnoremap <leader>l :!ls<CR>

" Make line above/below current one whithout changing cursor position
nnoremap <leader><Enter> o<Esc>2k<CR>
nnoremap <leader><Backspace> O<Esc><CR>

" Splits
nnoremap <leader>v :vs<CR>
nnoremap <leader>h :sp<CR>

" Discord presence
nnoremap <leader>dr :DiscordReconnect<CR>
nnoremap <leader>dd :DiscordDisconnect<CR>

" Misc
noremap <leader>t :YcmC GetType<CR>
nnoremap <leader>n :set relativenumber!<CR>
nnoremap <leader>c :set cursorline!<CR>
" -----------------------------------------------

" SPLITS
set splitbelow splitright

" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make adjusing split sizes a bit more friendly
noremap <C-Right> :vertical resize -3<CR>
noremap <C-Left> :vertical resize +3<CR>
noremap <C-Up> :resize +3<CR>
noremap <C-Down> :resize -3<CR>

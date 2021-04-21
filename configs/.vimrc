" .vimrc
" Jack Weil

" 'zR' to unfold all, 'zM' to fold all

"{{{ Plugin Options
let g:native_status_line = 1  " use native (custom) status line, set this to 0 if we were using a plugin here

let g:ale_enabled = 0                               " make ALE off by default, enabled with ALEEnable or ALEToggle
let g:ale_open_list = 1                             " use quickfix list instead of location list
let g:ale_lint_on_text_changed = 'never'            " wait for save to lint
let g:ale_echo_msg_format = '[%linter% %code%] %s'  " show which linter to distinguish errors
let g:ale_python_flake8_options = '--ignore=E402,W503'   " ignore import at top of file error

" Set root directory to store text files
" Set syntax version
" Set text file extensions
let g:vimwiki_list = [{'path': '~/notes/vimwiki/', 'syntax': 'default', 'ext': '.wiki'}]

" Enable basic fzf integration
set rtp+=~/.local/src/fzf
"}}}

"{{{ Vim Options
syntax enable                  " enable syntax highlighting
filetype on                    " try and recognize filetype and trigger FileType event
filetype indent on             " load runtimepath indent.vim file for detected filetype
filetype plugin on             " load runtimepath plugin.vim file for detected filetype
set number                     " enable line numbering
set so=10                      " dont let curser scroll to edge of screen
set tabstop=4                  " define tab to be 4 columns
set softtabstop=4              " how far to move curser on tab keypress
set shiftwidth=4               " define >> width
set expandtab                  " expand tabs into spaces
set cursorline                 " highlight current line
set wildmenu                   " visual autocomplete for command menu
set lazyredraw                 " redraw only when needed
set showmatch                  " highlight matching parentheses/brackets
set incsearch                  " search as characters are entered
set hlsearch                   " highlight search matches
set hidden                     " allow switching from an edited buffer w/o losing changes
set clipboard=unnamedplus      " yank into the system clipboard (+ vim register is the CLIPBOARD X11 buffer)
set foldenable                 " enable code folding (section minimize/maximize)
set foldlevelstart=10          " effectively always start with folds open (up to 10 levels deep)
set foldnestmax=10             " prevent anything this goofy
set foldmethod=indent          " automatically fold based on indent level
set modeline                   " enable per-file options with modeline
set ignorecase                 " ignore case by default in search
set smartcase                  " override ignorecase when upper case found in search term
set smartindent                " reacts to syntax
set autoindent                 " automatic indenting for buffers not associated with a filetype
set backspace=indent,eol,start " backspace over autoindents, eol chars, over the start of insert
set laststatus=2               " show the statusline always
set showtabline=0              " never display tabline
set noshowmode                 " no mode text in the command bar at the bottom
set tags=./tags                " enable ctags (use the database in current dir)
set ff=unix                    " windows line endings are evil

" Enable persistent undo information, but save it in a common directory
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

" Subtle marker at 120 char column mark
highlight ColorColumn ctermbg=gray
set colorcolumn=120

" use the builtin functionality to jump from 'if' to 'else' with %
runtime macros/matchit.vim

" Auto-resize panes equally when vim window size changes
augroup auto_resize_panes
    autocmd VimResized * wincmd =
augroup END
"}}}

"{{{ Key Mappings
let mapleader=' '

" move vertically by visual line (wrapped lines)
nnoremap j gj
nnoremap k gk

" unmap ZZ (force exit)
nnoremap ZZ <nop>

" remap basic fzf command to ctrl+p
nnoremap <C-p> :FZF<CR>

" toggle relative line numbering
nnoremap <leader>rn :set relativenumber!<CR>

" clear highlighted search resutls
nnoremap <leader>/ :noh<CR>

" remove trailing spaces
nnoremap <leader>dt :%s/\s\+$//e<CR>

" mappings for ALE plugin
nnoremap <leader>at :ALEToggle<CR>
nnoremap <leader>ar :ALEEnable<CR>:ALELint<CR>

" rebuild ctags database
nnoremap <leader>ct :!ctags -R .

" Grep (ripgrep) for the current word under the cursor, facilitated by fzf.vim
nnoremap <leader>g :execute "Rg " . expand("<cword>")<CR>

" Change buffers
nnoremap J :bn<CR>
nnoremap K :bp<CR>
"}}}

"{{{ Appearance
set background=dark

silent! colorscheme gruvbox " fail silently if colorscheme doesn't exist
"}}}

""{{{ Status Line
augroup status
    autocmd!
    autocmd VimEnter * let &statusline = status#Active()
    autocmd VimEnter * call status#Autocmd()
augroup end

" set fold method to marker for this file only, open with all folds closed (foldlevel=0)
"" vim:fdm=marker:fdl=0

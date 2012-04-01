" Hide the vim splash screen
set shortmess+=I

syntax on
filetype plugin indent on
nnoremap ; :
                  " allow commands to be run with ;
set hidden
set nowrap        " don't wrap lines
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set tags=./tags;  " Set the tag file search order
set iskeyword-=_  " Use _ as a word-separator
set grepprg=ack   " Use Ack instead of grep
set nobackup      " no backup files
set nowritebackup " only in case you don't want a backup file while editing
set noswapfile    " no swap files
set wildmode=longest,list,full
" ==========================================
" windows and splits
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>l <ESC>:vsp .<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ==========================================
" ctags

set tags=.tags,gems.tags,.gems.tags
noremap <leader>pt :!ctags -V --languages=ruby -f .gems.tags `gem env gemdir` && ctags -f .tags -RV . <cr>

" ==========================================
" Color scheme settings:

set background=light
colorscheme solarized

" ==========================================
" Vimrc settings:

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" ==========================================
" Command shortcuts:

" Force save files that require root permission
cmap w!! %!sudo tee > /dev/null %

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" ==========================================
" Tab settings

set ts=2 sts=2 sw=2 expandtab "set two spaces by default
" ==========================================
" File settings:
function TrimWhiteSpace()
  %s/\s\+$//e
:endfunction

autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 4
autocmd BufWritePre *.rb :call TrimWhiteSpace() " remove trailing whitespace on write
" ==========================================
" Make Rspec files work with MakeGreen
autocmd BufNewFile,BufRead *_spec.rb compiler rspec

" ==========================================
" iTerm and screen/tmux settings

if has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    " for some reason, doing this directly with 'set ttymouse=xterm2'
    " doesn't work -- 'set ttymouse?' returns xterm2 but the mouse
    " makes tmux enter copy mode instead of selecting or scrolling
    " inside Vim -- but luckily, setting it up from within autocmds
    " works
    autocmd VimEnter * set ttymouse=xterm2
    autocmd FocusGained * set ttymouse=xterm2
    autocmd BufEnter * set ttymouse=xterm2
  endif
endif
set ttimeoutlen=50

if &term =~ "xterm" || &term =~ "screen"
  let g:CommandTCancelMap     = ['<ESC>', '<C-c>']
  let g:CommandTSelectNextMap = ['<C-n>', '<C-j>', '<ESC>OB']
  let g:CommandTSelectPrevMap = ['<C-p>', '<C-k>', '<ESC>OA']
endif
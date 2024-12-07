-- old vimrc contents
vim.cmd([[
"" general vim settings
set nocompatible
syntax enable
set encoding=utf-8
set showcmd
filetype plugin indent on
set number relativenumber

"" whitespace
set nowrap
set tabstop=4 shiftwidth=4
set softtabstop=4
set expandtab
set backspace=indent,eol,start

"" searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set laststatus=2

"" wrapping text at 95 chars
set textwidth=95
"" but for tex files, have it wrap at 80 chars
autocmd Filetype tex setlocal textwidth=80
set formatoptions-=t

""" kolor colour scheme
"" Enable italic. Default: 1
"let g:kolor_italic=1
"
"" Enable bold. Default: 1
"let g:kolor_bold=1
"
"" Enable underline. Default: 0
"let g:kolor_underlined=0
"
"" Gray 'MatchParen' color. Default: 0
"let g:kolor_alternative_matchparen=0
"
"" White foreground 'MatchParen' color that might work better with some terminals. Default: 0
"let g:kolor_inverted_matchparen=0
"colorscheme kolor

"" transparency for kolor colourscheme
"hi Normal guibg=NONE ctermbg=NONE
"hi NonText ctermbg=none
"highlight LineNr ctermbg=none

" spell check for .tex files, taken from https://geraldo.dev/posts/vim-spell-checking/
autocmd BufRead,BufNewFile *.tex setlocal spell spelllang=en_gb
"" vimtex
let g:vimtex_view_general_viewer = 'zathura'
let g:tex_flavour = 'latex'

"" ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" highlight the entire line that the cursor is on
set cursorline

" vim-gitgutter config
set updatetime=100
let g:gitgutter_sign_added = '█|'
let g:gitgutter_sign_modified = '█⫶'
let g:gitgutter_sign_removed = '█▁'
let g:gitgutter_sign_removed_first_line = '█▔'
let g:gitgutter_sign_modified_removed = "█▟"

" statusline
" take from here: https://dustri.org/b/lightweight-and-sexy-status-bar-in-vim.html
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=\ %n\           " buffer number
set statusline+=%#Visual#       " colour
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=%#CursorIM#     " colour
set statusline+=%R                        " readonly flag
set statusline+=%M                        " modified [+] flag
set statusline+=%#Cursor#               " colour
set statusline+=%#CursorLine#     " colour
set statusline+=\ %t\                   " short file name
set statusline+=%=                          " right align
set statusline+=%#CursorLine#   " colour
set statusline+=\ %Y\                   " file type
set statusline+=%#CursorIM#     " colour
set statusline+=\ %3l:%-2c\         " line + column
set statusline+=%#Cursor#       " colour
set statusline+=\ %3p%%\                " percentage
]])

---- general vim settings
--vim.opt.encoding = "utf-8"
--vim.opt.number = "relativenumber"
--
---- whitespace
--vim.opt.tabstop = 4
--vim.opt.shiftwidth = 4

-- Disable code formatter on save by the zig.vim plugin (which is installed in neovim by
-- default I think?). See https://github.com/ziglang/zig.vim/issues/51#issuecomment-1871267725
-- 
-- Somehow this also seemed to get rid of the "loclist" which shows the compielrs errors that
-- the LSP sees in a separate thing, which is good.
vim.g.zig_fmt_autosave = 0

require("config.lazy")

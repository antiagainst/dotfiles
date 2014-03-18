" Vundle Plugin Management
" ========================

" using Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" theme, colorscheme
Bundle 'flazz/vim-colorschemes'

" motion, repeating
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-repeat'
Bundle 'matchit.zip'
Bundle 'tpope/vim-surround'
Bundle 'terryma/vim-multiple-cursors'
"Bundle 'L9'
"Bundle 'FuzzyFinder'
Bundle 'kien/ctrlp.vim'
"Bundle 'DrawIt'

" bash, tmux
Bundle 'tpope/vim-eunuch'
Bundle 'benmills/vimux'

" programming
Bundle 'Valloric/YouCompleteMe'
Bundle 'antiAgainst/cscope-macros.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'nathanaelkane/vim-indent-guides'

" language support
Bundle 'a.vim'
Bundle 'klen/python-mode'
"Bundle 'c.vim'
"Bundle 'rstacruz/sparkup'
"Bundle 'mattn/emmet-vim'
"Bundle 'vim-ruby/vim-ruby'
"Bundle 'tpope/vim-rails'
Bundle 'plasticboy/vim-markdown'

" tool support
Bundle 'tpope/vim-fugitive'
Bundle 'jcf/vim-latex'

" IDE
"Bundle 'scrooloose/nerdtree'
"Bundle 'winmanager'
Bundle 'fholgado/minibufexpl.vim'
"Bundle 'taglist.vim'


" Global Settings
" ===============

" set the <Leader>
"let mapleader=";"

" copy selected area to system clipboard
vnoremap <Leader>y "+y
" paste from system clipboard
nmap <Leader>p "+p

" go to the next spilt window
nnoremap <Leader>gs <C-W><C-W>

" A hidden buffer is a buffer with some unsaved modifications and is not
" displayed in a window. Hidden buffers are useful, if you want to edit
" multiple buffers without saving the modifications made to a buffer while
" loading other buffers. 
set hidden

" precede each line with its line number
set number

" show the line and column number of the cursor position
set ruler

" the kind of folding used for the current window
set foldmethod=syntax
" The higher the foldlevel, the more folded regions are open
" When set to 0, all folds are closed.
set foldlevel=100

" syntax highlighting
syntax on

" using 8/256 colors
"set t_Co=8
"set t_Co=256

" default colorscheme
"colorscheme murphy
"highlight Normal ctermbg=none
"highlight Constant cterm=bold ctermfg=5
"highlight Type term=underline cterm=bold ctermfg=6
"highlight Ignore cterm=bold ctermfg=0
" colorscheme for python
"autocmd FileType python colorscheme anotherdark

" colorscheme for 256 colors
set background=dark
colorscheme solarized
highlight Normal ctermbg=none
"colorscheme molokai

" enable filetype detection
filetype on
" enable loading the plugin files for specific file types
" The result is that when a file is edited its plugin file is loaded.
filetype plugin on
" enable loading the indent file for specific file types
" The result is that when a file is edited its indent file is loaded.
filetype indent on

" highlight search results
set hlsearch
" search as you typing
set incsearch
" case-insensitive when searching
set ignorecase

" autoindent	ai	Copy indent from current line when starting a new line.
" smartindnet	si	Do smart autoindenting when starting a new line.
set autoindent
set smartindent


" Programming Language Support
" ============================

" C/C++ programming helpers
augroup csrc
  au!
"  autocmd FileType *      set nocindent smartindent
  autocmd FileType c,cpp  set cindent
augroup END

" tabstop=X 	ts	Number of spaces that a <Tab> in the file counts for.
" shiftwidth=X 	sw	Number of spaces to use for each step of (auto)indent.
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab

augroup filetype
    au! BufRead,BufNewFile *.ll    set filetype=llvm
augroup END

augroup filetype
    au! BufRead,BufNewFile *.td     set filetype=tablegen
augroup END

augroup filetype
    au! BufRead,BufNewFile *Makefile* set filetype=make
augroup END

" In Makefiles, don't expand tabs to spaces, since we need the actual tabs.
autocmd FileType make set noexpandtab


" Encoding Settings
" =================

if has("multi_byte")
    " set fileencoding priority
    if getfsize(expand("%")) > 0
        set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
    else
        set fileencodings=cp936,big5,euc-jp,euc-kr,latin1
    endif

    " CJK environment detection and corresponding setting
    if v:lang =~ "^zh_CN"
        " use cp936 to support GBK, euc-cn == gb2312
        set encoding=cp936
        set termencoding=cp936
        set fileencoding=cp936
    elseif v:lang =~ "^zh_TW"
        " cp950, big5 or euc-tw
        " Are they equal to each other?
        set encoding=big5
        set termencoding=big5
        set fileencoding=big5
    elseif v:lang =~ "^ko"
        " copied from someone's dotfile, untested
        set encoding=euc-kr
        set termencoding=euc-kr
        set fileencoding=euc-kr
    elseif v:lang =~ "^ja_JP"
        " copied from someone's dotfile, unteste
        set encoding=euc-jp
        set termencoding=euc-jp
        set fileencoding=euc-jp
    endif
    " detect UTF-8 locale, and replace CJK setting if needed
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
        set encoding=utf-8
        set termencoding=utf-8
        set fileencoding=utf-8
    endif
else
    echoerr "Sorry, (g)vim was not compiled with multi_byte."
endif


" Plugin Configuration
" ====================

" powerline

"python from powerline.ext.vim import source_plugin; source_plugin()

" YouCompleteMe options

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 1

" new-omni-completion

" menu		Use a popup menu to show the possible completions.
" longest	Only insert the longest common text of the matches.
set completeopt=longest,menu
" completion preference used by <C-N>
set complete=.,w,b,u,t,i

" easymotion options

" rebinding the leader
"map <Leader> <Plug>(easymotion-prefix)

" minibufexpl options

map <Leader>beo :MBEOpen<cr>
map <Leader>bec :MBEClose<cr>
map <Leader>bet :MBEToggle<cr>

" ctrlp options

"let g:ctrlp_log = 1

" taglist options

" only show tags for the current file
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
nmap :tl :Tlist

" winmanager options

let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWidth=30
nmap :wm :WMToggle<CR>
nnoremap <silent> <F8> :WMToggle<CR>

" NERDTree options

" set NERDTree window width
let NERDTreeWinSize=30
" set NERDTree window position
let NERDTreeWinPos="right"
nmap :nt :NERDTreeToggle

" Vimux options

" Prompt for a command to run map
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane map
map <Leader>vi :VimuxInspectRunner<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane map
map <Leader>vs :VimuxInterruptRunner<CR>
" Clear the tmux history of the runner pane
map <Leader>vc :VimuxClearRunnerHistory<CR>
" Zoom the tmux runner page
map <Leader>vz :VimuxZoomRunner<CR>

" zencoding options

let g:user_zen_leader_key = '<c-y>'

" vim-indent-guide options

let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" python-mode options

let g:pymode_motion = 1
let g:pymode_doc = 1
let g:pymode_doc_bind = '<leader><leader>pd'
let g:pymode_run = 1
let g:pymode_run_bind = '<leader><leader>pr'
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pylint']

" latex-suite option

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

set exrc

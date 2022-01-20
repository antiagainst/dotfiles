" Vundle Plugin Management
" ========================

" using Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
set rtp+=~/.skim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" theme, colorscheme
Plugin 'flazz/vim-colorschemes'
Plugin 'kien/rainbow_parentheses.vim'

" status
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" motion, object
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-repeat'
Plugin 'matchit.zip'
Plugin 'tpope/vim-surround'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'wellle/targets.vim'

" searching
"Plugin 'L9'
"Plugin 'FuzzyFinder'
"Plugin 'kien/ctrlp.vim'
" Plugin 'rking/ag.vim'
" Plugin 'junegunn/fzf'
" Plugin 'lotabout/skim'   " contains :SK and skim#run
Plugin 'lotabout/skim.vim' " contains utilities built upon skim like :Files, :Buffers
Plugin 'jremmen/vim-ripgrep' " contains :Rg
Plugin 'dyng/ctrlsf.vim'

" tmux, shell
Plugin 'benmills/vimux'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'

Plugin 'google/vim-maktaba'
Plugin 'google/vim-glaive'
Plugin 'google/vim-syncopate'

" programming
Plugin 'Valloric/YouCompleteMe'
Plugin 'antiagainst/vim-rtags'
"Plugin 'antiagainst/cscope-macros.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'kana/vim-operator-user'
Plugin 'rhysd/vim-clang-format'

Plugin 'DrawIt'

" language support
Plugin 'a.vim'
"Plugin 'c.vim'
Plugin 'klen/python-mode'
Plugin 'fatih/vim-go'
Plugin 'rust-lang/rust.vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'plasticboy/vim-markdown'
"Plugin 'vim-ruby/vim-ruby'
"Plugin 'tpope/vim-rails'
Plugin 'tikhomirov/vim-glsl'
"Plugin 'antiagainst/llvm.vim'
"Plugin 'rstacruz/sparkup' " HTML
"Plugin 'mattn/emmet-vim' " HTML & CSS
Plugin 'jcf/vim-latex'
Plugin 'kbenzie/vim-spirv'
Plugin 'antiagainst/vim-tablegen'

" IDE
Plugin 'scrooloose/nerdtree'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'majutsushi/tagbar'
"Plugin 'taglist.vim'
"Plugin 'winmanager'
Plugin 'regedarek/ZoomWin'

call vundle#end()

" Detect OS
" =========
if !exists("g:os")
  if has("win64") || has("win32") || has("win16")
    let g:os = "Windows"
  else
    let g:os = substitute(system('uname'), '\n', '', '')
  endif
endif

" Global Settings
" ===============

" enable filetype detection
filetype on
" enable loading the plugin files for specific file types
" The result is that when a file is edited its plugin file is loaded.
filetype plugin on
" enable loading the indent file for specific file types
" The result is that when a file is edited its indent file is loaded.
filetype indent on

" how many lines of history VIM should remember
set history=1000

" auto read when a file is changed from the outside
set autoread

" when sole j, k, move cursor by display lines when wrapping
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" set the <Leader>
"let mapleader=";"

" copy selected area to system clipboard
vnoremap <Leader>y "+y
" paste from system clipboard
nmap <Leader>p "+p

" smart way to move between windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l
" go to the next spilt window
"nnoremap <Leader>gn <C-W><C-W>

" A hidden buffer is a buffer with some unsaved modifications and is not
" displayed in a window. Hidden buffers are useful, if you want to edit
" multiple buffers without saving the modifications made to a buffer while
" loading other buffers.
set hidden

" precede each line with its line number
set number
set relativenumber

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

set background=dark
let g:solarized_termcolors=256
colorscheme solarized
highlight Normal ctermbg=none
"colorscheme molokai

" highlight word under cursor
":autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))

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

set backspace=indent,eol,start

" Programming Language Support
" ============================

" tabstop=X 	ts	Number of spaces that a <Tab> in the file counts for.
" shiftwidth=X 	sw	Number of spaces to use for each step of (auto)indent.
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab

" C/C++ programming helpers
augroup csrc
  au!
"  autocmd FileType *      set nocindent smartindent
  autocmd FileType c,cpp  set cindent
augroup END

augroup filetype
    au! BufRead,BufNewFile *.ll    set filetype=llvm
augroup END

augroup filetype
    au! BufRead,BufNewFile *.td     set filetype=tablegen
augroup END

augroup filetype
    au! BufRead,BufNewFile *Makefile* set filetype=make
augroup END

augroup filetype
   au! BufRead,BufNewFile *.vert  set filetype=glsl
augroup END

augroup filetype
   au! BufRead,BufNewFile *.frag  set filetype=glsl
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

" airline

let g:airline_theme='dark'
let g:airline_powerline_fonts = 1
set laststatus=2

" YouCompleteMe options

let g:ycm_global_ycm_extra_conf = ''
let g:ycm_confirm_extra_conf = 0
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath("clangd")

autocmd FileType c,cpp,objc,objcpp nnoremap <Leader>gt :YcmCompleter GoTo<CR>
autocmd FileType c,cpp,objc,objcpp nnoremap <Leader>gi :YcmCompleter GoToInclude<CR>
autocmd FileType c,cpp,objc,objcpp nnoremap <Leader>gd :YcmCompleter GoToDefinition<CR>
autocmd FileType c,cpp,objc,objcpp nnoremap <Leader>gr :YcmCompleter GoToReferences<CR>

" clang-format options

let g:clang_format#code_style = 'llvm'
" map to <Leader>cf in C++ code
autocmd FileType c,cc,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cc,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cc,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)

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

" fzf/skim

"nmap <Leader>f :FZF<cr>
nmap <Leader>f :SK<cr>

" ag options
let g:ag_working_path_mode="r"

" CtrlSF options

let g:ctrlsf_ackprg = 'rg'

" taglist options

" only show tags for the current file
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
nmap :tl :Tlist

" winmanager options

let g:winManagerWindowLayout='NERDTree|Tagbar'
let g:winManagerWidth=30
nmap :wm :WMToggle<CR>
nnoremap <silent> <F8> :WMToggle<CR>

let g:NERDTree_title = "[NERDTree]"
function! NERDTree_Start()
  exe 'q'
  exe 'NERDTree'
endfunction

function! NERDTree_IsValid()
  return 1
endfunction

let g:Tagbar_title = "[Tagbar]"
function! Tagbar_Start()
  exe 'q'
  exe 'TagbarOpen'
endfunction

function! Tagbar_IsValid()
  return 1
endfunction

" NERDTree options
let NERDTreeWinSize=30
let NERDTreeWinPos="left"
nmap :nt :NERDTreeToggle

" Tagbar options
"let g:tagbar_left=1
"let g:tagbar_vertical = 30
let g:tagbar_width = 30
nmap :tb :TagbarToggle
"nnoremap <silent> <F5> :TagbarToggle<CR>

" ZoomWin options

"nmap <leader>o <c-w>o

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

"let g:user_zen_leader_key = '<c-y>'

" vim-indent-guide options

let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" rainbow-parantheses options

let g:rbpt_colorpairs = [
    \ ['brown', 'RoyalBlue3'],
    \ ['Darkblue', 'SeaGreen3'],
    \ ['darkgray', 'DarkOrchid3'],
    \ ['darkgreen', 'firebrick3'],
    \ ['darkcyan', 'RoyalBlue3'],
    \ ['darkred', 'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown', 'firebrick3'],
    \ ['gray', 'RoyalBlue3'],
    \ ['black', 'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue', 'firebrick3'],
    \ ['darkgreen', 'RoyalBlue3'],
    \ ['darkcyan', 'SeaGreen3'],
    \ ['darkred', 'DarkOrchid3'],
    \ ['red', 'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" python-mode options

if g:os == "Darwin"
  let g:python_host_prog="/Users/antiagainst/.homebrew/bin/python3"
elseif g:os == "Linux"
  let g:python_host_prog="/usr/bin/python3"
endif

let g:pymode_motion = 1
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>r'
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'pylint']
let g:pymode_lint_ignore = 'C0111,'

" vim-go

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)

au FileType go nmap <Leader>gs <Plug>(go-implements)
au FileType go nmap <Leader>gi <Plug>(go-info)
au FileType go nmap <Leader>gr <Plug>(go-rename)

"au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gh <Plug>(go-def-split)
au FileType go nmap <Leader>gv <Plug>(go-def-vertical)
au FileType go nmap <Leader>gt <Plug>(go-def-tab)

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 1

" vim-markdown options

let g:vim_markdown_folding_disabled=1
let g:vim_markdown_initial_foldlevel=1

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

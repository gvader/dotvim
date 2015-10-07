syntax enable
set background=dark

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set cindent
set cinoptions=N-1sl1g0
set rnu

if executable("flake8")
    set makeprg=flake8
endif

if has("win32") || has("win16")
    set backspace=2
endif

" two lines below highlight extra whitespace characters (tabs, spaces)
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" au InsertLeave * match ExtraWhitespace /\s\+$/

" set folding method
syntax match comment '\v(^\s*//.*\n)+' fold
set fdm=syntax

" history and undo memory to 700
set history=700
set undolevels=700

" config for vundle:
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
if has("win32") || has("win16")
    set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
    let path='$VIM/vimfiles/bundle'
    call vundle#rc(path)
else 
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#rc()
endif
" alternatively, pass a path where Vundle should install plugins
"let path = '~/some/path/here'
"call vundle#rc(path)

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between here and filetype plugin indent on.
" scripts on GitHub repos
" Plugin 'tpope/vim-fugitive'
" Plugin 'Lokaltog/vim-easymotion'
" Plugin 'tpope/vim-rails.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" scripts from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Plugin 'FuzzyFinder'
" scripts not on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" ...
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.
" Put your stuff after this line

Plugin 'tpope/vim-fugitive'
if has("win32") || has("win16")
    Plugin 'Shougo/neocomplete.vim'
    Plugin 'vim-scripts/OmniCppComplete'
else
    Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'vim-scripts/UltiSnips'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'honza/vim-snippets'
Plugin 'Lokaltog/vim-powerline'
Plugin 'majutsushi/tagbar'
Plugin 'rdnetto/YCM-Generator'

filetype plugin indent on     " required


" vim config for Cmake files
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime! indent/cmake.vim 
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in setf cmake
autocmd BufRead,BufNewFile *.ctest,*.ctest.in setf cmake

" config for other commonly used files
autocmd BufNewFile,BufRead [Mm]akefile setlocal noexpandtab
autocmd BufNewFile,BufRead *.{c,h}{,c,pp} setlocal noexpandtab formatprg=astyle cindent cinoptions=N-1sl1g0
autocmd BufNewFile,BufRead *.py setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class


" Allow to use Astyle formating by pressing Shift+F
map <S-F> <Esc>:%! astyle --options=/home/gvader/.astylerc

" map key for search and replace
map <esc>r :%s/\<<c-r><c-w>\>/<c-r><c-w>/g<left><left>
inoremap <expr> <esc>r ( pumvisible() ? '<c-e>' : '' ) . '<c-o>:%s/\<<c-r><c-w>\>/<c-r><c-w>/g<left><left>'
vmap    <esc>r :s/\<<c-r><c-w>\>/<c-r><c-w>/g<left><left>

" Tagbar
nmap <F8> :TagbarToggle<CR>

if has("win32") || has("win16")
    " NeoComplete
    let g:acp_enableAtStartup = 0           " Disable AutoComplPop.
    let g:neocomplete#enable_at_startup = 1 " Use neocomplete
    let g:neocomplete#enable_smart_case = 1 " Use smartcase
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    let g:neocomplete#sources#tags#cache_limit_size = 500000 
    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return neocomplete#close_popup() . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    
    " OmniCppComplete
    map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
    let OmniCpp_NamespaceSearch = 1
    let OmniCpp_GlobalScopeSearch = 1
    let OmniCpp_ShowScopeInAbbr = 1
    let OmniCpp_ShowPrototypeInAbbr = 1
    let OmniCpp_ShowAccess = 1
    let OmniCpp_MayCompleteDot = 1
    let OmniCpp_MayCompleteArrow = 1
    let OmniCpp_MayCompleteScope = 1
    let OmniCpp_DefaultNamespaces = ["std", "boost"]
    set tags=./tags,tags;C:
    set tags+=$VIM/stl.tags

    autocmd FileType cpp set omnifunc=omni#cpp#complete#Main

    " UltiSnips
    let g:UltiSnipsExpandTrigger="<TAB>"
else
    " YouCompleteMe
    let g:ycm_key_list_previous_completion=['<Up>']
    let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
    let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']
    let g:ycm_server_keep_logfiles = 1
    let g:ycm_server_log_level = 'debug'

    nnoremap y :YcmForceCompileAndDiagnostics
    nnoremap pg :YcmCompleter GoToDefinitionElseDeclaration
    nnoremap pd :YcmCompleter GoToDefinition
    nnoremap pc :YcmCompleter GoToDeclaration
    nnoremap pi :YcmCompleter GetDoc
    nnoremap pt :YcmCompleter GetType
    nnoremap pf :YcmCompleter FixIt

    " Ultisnips
    let g:UltiSnipsListSnippets="<C-S-Tab>"
    let g:UltiSnipsExpandTrigger="<c-j>"
endif

" Powerline
set nocompatible
set laststatus=2
set encoding=utf-8
set t_Co=256


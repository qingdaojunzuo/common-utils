set nocompatible
set nu
set hlsearch
set cursorline
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set sw=2
hi CursorLine cterm=underline
hi Search cterm=bold,underline ctermbg=darkblue ctermfg=darkblue guibg=darkblue guifg=white
sy on

set t_Co=256

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

"Bundle 'tsaleh/vim-matchit'
"Bundle 'fundon/vim-mou'
"Bundle 'terryma/vim-multiple-cursors'
"Bundle 'tpope/vim-rails'
"Bundle 'rking/vim-ruby-refactoring'
"Bundle 'justinmk/vim-sneak'
"Bundle 'garbas/vim-snipmate'
"Bundle 'Townk/vim-autoclose'
Bundle 'Valloric/YouCompleteMe'
Bundle 'VimClojure'
Bundle 'Lokaltog/vim-powerline'
Bundle 'majutsushi/tagbar'
Bundle 'gmarik/vundle'
Bundle 'vim-scripts/ColorX'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'rking/ag.vim'
Bundle 'lilydjwg/colorizer'
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/emmet-vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'plasticboy/vim-markdown'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'godlygeek/tabular'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-unimpaired'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'asux/vim-capybara'
Bundle 'kchmck/vim-coffee-script'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'henrik/vim-indexed-search'
Bundle 'digitaltoad/vim-jade'
Bundle 'itspriddle/vim-jquery'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'kana/vim-textobj-user'
Bundle 'flazz/vim-colorschemes'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'ternjs/tern_for_vim'
Bundle 'maksimr/vim-jsbeautify'
Bundle 'fatih/vim-go'
Bundle 'vim-scripts/c.vim'
Bundle 'reedes/vim-lexical'
Bundle 'pangloss/vim-javascript'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'othree/html5.vim'
Bundle 'elzr/vim-json'
Bundle 'derekwyatt/vim-scala'

call vundle#end()
" filetype plugin indent on
filetype plugin on

colorscheme badwolf "Tomorrow-Night-Eighties

" NERDTree configuration
nmap <F1> :NERDTreeFind<CR>
nmap <F2> :NERDTreeToggle<CR>
nmap <C-S-R> :CtrlPMixed<CR>
nmap <F3> :TagbarToggle<CR>

let NERDTreeShowHidden=1

"minibufexplorer
let g:miniBufExplMapWindowNavVim=1
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplModSelTarget=1
let g:miniBufExplMoreThanOne=0

function! MyCyclebuffer(forward)
  let l:origBuf = bufnr('%')
  if (a:forward == 1)
    bn!
  else
    bp!
  endif
  let l:curBuf = bufnr('%')
  while getbufvar(l:curBuf, '&modifiable') == 0 && l:origBuf != l:curBuf
    if (a:forward == 1)
      bn!
    else
      bp!
    endif
    let l:curBuf = bufnr('%')
  endwhile
endfunction

nnoremap <F4> :call MyCyclebuffer(0)<CR>
nnoremap <F5> :call MyCyclebuffer(1)<CR>
nnoremap <F6> :update<CR>
nnoremap <F7> :bd<CR>

" Javascript beautify
map <c-s-f> :call JsBeautify()<cr>
" Javascript configuration
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
set foldmethod=syntax

" Vim airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '>'
let g:airline_section_b = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'

" YouCompleteMe configuration
let g:ycm_key_list_select_completion = ['<c-n>']
let g:ycm_key_list_previous_completion = ['<c-p>']

set encoding=utf-8
set laststatus=2
let g:Powerline_symbols= "fancy"
let g:airline_powerline_fonts = 1

let g:ycm_confirm_extra_conf = 0
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_key_invoke_completion = '<M-;>'
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_python_binary_path = '/usr/bin/python3'
nmap <M-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>

" switch between *.c and *.h
map <C-h> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>

" Automatically determine indenting using fuzzy matching. e.g. the a line
" starting "(with-"
" will be indented two spaces.
let vimclojure#FuzzyIndent=1
" Highlight built-in functions from clojure.core and friends
let vimclojure#HighlightBuiltins=1
" Highlight functions from contrib
let vimclojure#HighlightContrib=1
" As new symbols are identified using VimClojure's dynamic features,
" automatically
" highlight them.
let vimclojure#DynamicHighlighting=1
" Color parens so they're easier to match visually
let vimclojure#ParenRainbow=1
" Yes, I want nailgun support
let vimclojure#WantNailgun = 1
" Full path to the nailgun client
let vimclojure#NailgunClient = "/root/bin/vimclojure-nailgun-client/ng"
" Set local leader to comma
let maplocalleader=","

" vim-lexical configuration from github
let g:lexical#spell = 1
let g:lexical#dictionary = ['/usr/share/dict/words',]
let g:lexical#spellfile = ['~/.vim/spell/en.utf-8.add',]
augroup lexical
  autocmd!
  autocmd FileType markdown,mkd,*.js,java,c,cpp,h,hpp,go,py,sh call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END

" vim-go configuration
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

" syntastic configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']

" vim json configuration
au! BufRead,BufNewFile *.json set filetype=json

augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set foldmethod=syntax
augroup END

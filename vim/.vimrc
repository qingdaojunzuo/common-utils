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

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

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
Bundle 'Townk/vim-autoclose'
Bundle 'asux/vim-capybara'
Bundle 'kchmck/vim-coffee-script'
Bundle 'jnwhiteh/vim-golang'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'henrik/vim-indexed-search'
Bundle 'digitaltoad/vim-jade'
Bundle 'itspriddle/vim-jquery'
"Bundle 'tsaleh/vim-matchit'
"Bundle 'fundon/vim-mou'
"Bundle 'terryma/vim-multiple-cursors'
"Bundle 'tpope/vim-rails'
"Bundle 'rking/vim-ruby-refactoring'
"Bundle 'justinmk/vim-sneak'
""Bundle 'garbas/vim-snipmate'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'kana/vim-textobj-user'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'flazz/vim-colorschemes'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'ternjs/tern_for_vim'
Bundle 'maksimr/vim-jsbeautify'
Bundle 'vim-scripts/c.vim'
Bundle 'reedes/vim-lexical'

call vundle#end()
filetype plugin indent on

colorscheme Tomorrow-Night-Eighties

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

map <c-s-f> :call JsBeautify()<cr>

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
nmap <M-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>

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
  autocmd FileType markdown,mkd,*.js,java,c,cpp,h,hpp call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END

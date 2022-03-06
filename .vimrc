scriptencoding utf-8
set encoding=utf-8

if has("syntax")
  syntax on
endif

set showcmd
set showmatch
set ignorecase
set smartcase
set incsearch
set autowrite
set hidden
set mouse=a
set number
set ruler
set list
set matchtime=3

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start
set wrap
set textwidth=0
set colorcolumn=80

" 前時代的スクリーンベルを無効化
set t_vb=
set novisualbell

set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" 検索結果をハイライトする
:set hlsearch

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tabをスペース４つにする
:set tabstop=4
:set autoindent
:set expandtab
:set shiftwidth=4

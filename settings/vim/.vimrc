"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dein.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deinのインストール先 
let s:dein_dir = expand('~/.cache/dein')

" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" アンインストールするときに使用
""call map(dein#check_clean(), "delete(v:val, 'rf')")
" execute 'call dein#recache_runtimepath()'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" init
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on 
filetype plugin indent on " required!
filetype indent on

set number
set nocompatible
set encoding=utf-8
" 保存時の文字コード
set fileencoding=utf-8 
" 読み込み時の文字コードの自動判別. 左側が優先される
set fileencodings=utf-8,cp932

" タブ入力を複数の空白入力に置き換える
set expandtab
" 画面上でタブ文字が占める幅
set tabstop=4
" 自動インデントでずれる幅
set shiftwidth=4 
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4
" 改行時に前の行のインデントを継続する
set autoindent

" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent

" ヤンクした時にクリップボードにコピーする
set clipboard+=unnamed,autoselect

" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch
" 検索パターンに大文字小文字を区別しない
set ignorecase
" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
" 検索結果をハイライト"
set hlsearch

set backspace=indent,eol,start
" 自動改行無効
set noeol


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keybind
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 行頭・行末移動方向をキーの相対位置にあわせる
nnoremap <C-a> <Home>
nnoremap <C-o> <End>

" insertモードから抜ける
""inoremap <silent> jj <ESC>

" 挿入モードでのカーソル移動
inoremap <silent> <C-j> <Down>
inoremap <silent> <C-k> <Up>
inoremap <silent> <C-h> <Left>
inoremap <silent> <C-l> <Right>

" カーソル前の文字削除
inoremap <silent> <C-b> <C-g>u<C-h>
" カーソル後の文字削除
inoremap <silent> <C-d> <Del>
" カーソルから行頭まで削除
inoremap <silent> <C-d>e <Esc>lc^
" カーソルから行末まで削除
inoremap <silent> <C-d>0 <Esc>lc$

" 引用符, 括弧の設定
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap <> <><Left>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ウィンドウ操作
" Reference: https://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 画面分割
nnoremap <silent> ss :<C-u>split<CR>
nnoremap <silent> sv :<C-u>vsplit<CR>

" 画面移動
nnoremap <silent> sh <C-w>h
nnoremap <silent> sj <C-w>j
nnoremap <silent> sk <C-w>k
nnoremap <silent> sl <C-w>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim indent  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indentLine_color_term = 111
let g:indentLine_color_gui  = '#708090'
let g:indentLine_char       = '' "use ¦, ┆ or │

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim unite  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_enable_start_insert        = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_mru_limit      = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
"nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-force.com  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:apex_properties_folder          = '$HOME/workspace/vim-force.com/properties'
let g:apex_temp_folder                = '/tmp/apex/gvim-deproyment'
let g:apex_deployment_error_log       = "/tmp/gvim-deployment-error.log"
let g:apex_tooling_force_dot_com_path = "$HOME/.ant/lib/tooling-force.com-0.4.7.0.jar"
let g:apex_workspace_path             = "$HOME/workspace/vim-force.com"
let g:apex_backup_folder              = "$HOME/workspace/vim-force.com/backup"
let g:apex_API_version                = "40.0"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-jsx-pretty  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:vim_jsx_pretty_colorful_config = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" salesforce  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufRead,BufNewFile *.cmp set filetype=html

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufRead,BufNewFile *.mkd set filetype=markdown
autocmd BufRead,BufNewFile *.md  set filetype=markdown
" For kannokanno/previm
nnoremap <silent> <C-p> :PrevimOpen<CR> 
" 自動で折りたたまないようにする
let g:vim_markdown_folding_disabled = 1
let g:previm_enable_realtime = 1
let g:previm_open_cmd = 'open -a Google\ Chrome'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Utility
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ackprg = 'ag --vimgrep'
nnoremap <silent> qj :<C-u>%!jq '.'<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightning-vim 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> rcon :<C-u>Rcon<CR>
nnoremap <silent> rcmp :<C-u>Rcmp<CR>
nnoremap <silent> rhel :<C-u>Rhelp<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" git  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-gitgutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

nnoremap <silent> gd :<C-u>Gdiff<CR>
nnoremap <silent> gb :<C-u>Gblame<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tab  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> te :<C-u>tabedit<CR>
nnoremap <silent> tc :<C-u>tabclose<CR>
nnoremap <silent> tl :<C-u>tabr<CR>
nnoremap <silent> tr :<C-u>tabl<CR>
nnoremap <silent> tn :<C-u>tabnext<CR>
nnoremap <silent> tp :<C-u>tabprevious<CR>

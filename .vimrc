set fenc=utf-8

set showcmd

set number

set cursorline

set smartindent

set tabstop=2

set title

set showmatch

set matchtime=1

nnoremap Y y$

set display=lastline

set shiftwidth=2

set noswapfile

" tabからスペース2
set expandtab
set tabstop=2
set shiftwidth=2

"keymap and setting
inoremap <silent> jj <ESC>

map <C-n> :NERDTreeToggle<CR>
map <S-t> :terminal<CR>

" 自動的に閉じ括弧を入力する
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

" color 
syntax enable
set background=dark
colorscheme solarized
let g:solarized_termtrans = 1
let g:solarized_termcolors= 256 
let g:solarized_underline = 1
    
" Rust set up.
let g:rustfmt_autosave = 1
let g:rustfmt_command = '$HOME/.cargo/bin/rustfmt'
set hidden
let g:racer_cmd = '$HOME/.cargo/bin/racer'
let g:racer_experimental_completer = 1

" OCaml set up.
" コード補完
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute 'set rtp+=' . g:opamshare . '/merlin/vim'
" syntacshit check
let g:syntastic_ocaml_checkers = ['merlin']
"ocp-indent setup
 execute 'set rtp^=' . g:opamshare . '/ocp-indent/vim'
function! s:ocaml_format()
	  let now_line = line('.')
		exec ':%! ocp-indent'
		exec ':' . now_line
endfunction

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'

augroup ocaml_format
	  autocmd!
		autocmd BufWrite,FileWritePre,FileAppendPre *.mli\= call s:ocaml_format()
augroup END

" golang setup
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"
" guruで急に定義元ジャンプできなくなる部分が出てきたので、https://github.com/fatih/vim-go/issues/1687
let g:go_def_mode = "godef"
" tagをsnakecaseまたは camelcaseに指定できる
let go_addtags_transform = 'camelcase'
" errの色を変える
autocmd FileType go :highlight goErr cterm=bold ctermfg=9
autocmd FileType go :match goErr /\<err\>/

" Haskell setup


" Note: Skip initialization for vim-tiny or vim-small.
 if 0 | endif

" " Required:
filetype plugin indent on

syntax on

" dein config
 let s:dein_dir = fnamemodify('~/.vim/dein/', ':p')
 let s:dein_repo_dir = s:dein_dir . 'repos/github.com/Shougo/dein.vim'

" dein.vim本体をランタイムパスに追加
 if &runtimepath !~# '/dein.vim'
	     execute 'set runtimepath^=' . s:dein_repo_dir
		 endif

call dein#begin(s:dein_dir)

call dein#add('scrooloose/nerdtree')
" if close file, NERDTree close at some time
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

call dein#add('Shougo/deoplete.nvim')
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif
let g:deoplete#enable_at_startup = 1

" Pass a dictionary to set multiple options
call deoplete#custom#option({
\ 'auto_complete_delay': 200,
\ 'smart_case': v:true,
\ })

call dein#add('fatih/vim-go')
call dein#add('racer-rust/vim-racer')
call dein#add('rust-lang/rust.vim')
call dein#add('Shougo/echodoc.vim')
call dein#add('Shougo/unite.vim')
call dein#add('tomtom/tcomment_vim')
call dein#add('tpope/vim-fugitive')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('tacahiroy/ctrlp-funky')
call dein#add('wakatime/vim-wakatime')
call dein#add('posva/vim-vue')
call dein#add('scrooloose/syntastic')
call dein#add('def-lkb/ocp-indent-vim')
call dein#add('buoto/gotests-vim')
call dein#add('rking/ag.vim')
" indent lineの設定
call dein#add('Yggdroot/indentLine')
let g:indentLine_char = '¦'
" set list listchars=tab:\¦\
let g:indentLine_fileTypeExclude = ['help', 'nerdtree']

call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('yonchu/accelerated-smooth-scroll')
let g:ac_smooth_scroll_du_sleep_time_msec = 3

" ag and unite set up
" insert modeで開始
let g:unite_enable_start_insert = 1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" lightline setup
call dein#add('itchyny/lightline.vim')
set laststatus=2
set t_Co=256
let g:lightline = {
			\ 'colorscheme': 'solarized',
			\ 'active': {
			\		'left': [ [ 'mode', 'paste' ],
			\		 					[ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
			\	},
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
			\		'gitbranch': 'fugitive#head',
			\	},
      \ }
function! LightlineFilename()
	  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
		        \ &filetype ==# 'unite' ? unite#get_status_string() :
		        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
		        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
let g:lightline.component = {}
let g:lightline.component.dir = '%.35(%{expand("%:h:s?\\S$?\\0/?")}%)'
let g:lightline.component.winbufnum = '%n%{repeat(",", winnr())}%<'
let g:lightline.component.rows = '%L'
let g:lightline.component.lineinfo = '%3l:%-3v'
let g:lightline.component.tabopts = '%{&et?"et":""}%{&ts}:%{&sw}:%{&sts},%{&tw}'
let g:lightline.component_function = {}
let g:lightline.component_function.fugitive = 'StlFugitive'

function! StlFugitive()
	  try
			    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
						      return fugitive#head()
					endif
		catch
		endtry
		return ''
endfunction

let g:lightline.component_function.cfi = 'StlCurrentFuncInfo'
function! StlCurrentFuncInfo()
	  if exists('*cfi#format')
			    return cfi#format('%.43s()', '')
		end
		return ''
endfunction

let g:lightline.component_function.currentfuncrow = 'StlCurrentFuncRow'
function! StlCurrentFuncRow()
	if &ft != 'vim'
		return ''
	end
	let funcbgn = search('^\s*\<fu\%[nction]\>', 'bcnW', search('^\s*\<endf\%[unction]\>', 'bcnW'))
	if funcbgn > 0
		let row = line('.') - funcbgn
		return row ? row : ''
	endif
	return ''
endfunction

let g:lightline.tab_component_function = {}
let g:lightline.tab_component_function.prefix = 'TalPrefix'
function! TalPrefix(n)
	  return lightline#tab#tabnum(a:n). TalTabwins(a:n)
endfunction
function! TalTabwins(n)
		return repeat(',', len(tabpagebuflist(a:n)))
endfunction

let g:lightline.tab_component_function.filename = 'TalFilename'
function! TalFilename(n)
	  return TalBufnum(a:n). '-'. substitute(lightline#tab#filename(a:n), '.\{16}\zs.\{-}\(\.\w\+\)\?$', '~\1', '')
endfunction
function! TalBufnum(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	return buflist[winnr - 1]
endfunction

let g:lightline.active = {}
let g:lightline.inactive = {}
let g:lightline.active.left = [['winbufnum'], ['dir'], ['filename'],
  \ ['filetype', 'readonly', 'modified'], ['currentfuncrow']]
let g:lightline.active.right = [['lineinfo'], ['percent'],
  \ ['fileformat', 'fileencoding'], ['cfi']]
let g:lightline.inactive.left = [['winbufnum'], ['dir'],
  \ ['filename'], ['filetype', 'readonly', 'modified']]
let g:lightline.inactive.right = [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
let g:lightline.tabline = {'right': [['rows'], ['cd'], ['tabopts'], ['fugitive']]}
let g:lightline.tab = {'active': ['prefix', 'filename']}
let g:lightline.tab.inactive = g:lightline.tab.active

" CtrlPの設定
let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100' " マッチウインドウの設定. 「下部に表示, 大きさ20行で固定, 検索結果100件」
let g:ctrlp_show_hidden = 1 " .(ドット)から始まるファイルも検索対象にする
let g:ctrlp_types = ['fil'] "ファイル検索のみ使用
let g:ctrlp_extensions = ['funky'] " CtrlPの拡張として「funky」と「commandline」を使用]])

" CtrlPFunkyの有効化
let g:ctrlp_funky_matchtype = 'path'

" 必須
call dein#end()
filetype plugin indent on
syntax enable

" プラグインのインストール
if dein#check_install()
  call dein#install()
endif

"バックスペースが効かないのを直す
set backspace=indent,eol,start



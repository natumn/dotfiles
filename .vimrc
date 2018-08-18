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

set ignorecase

set shiftwidth=2

set noswapfile

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
" let g:solarized_degrade = 1 
" let g:solarized_bold = 1
let g:solarized_underline = 1
" let g:solarized_contrast = "normal" 
" let g:solarized_visibility= "normal"
    
" Rust-vim.rust vim set up.
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
" execute 'set rtp^=' . g:opamshare . '/ocp-indent/vim'
" function! s:ocaml_format()
"	  let now_line = line('.')
"		exec ':%! ocp-indent'
"		exec ':' . now_line
"endfunction

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'

"augroup ocaml_format
"	  autocmd!
"		autocmd BufWrite,FileWritePre,FileAppendPre *.mli\= call s:ocaml_format()
"augroup END
"

" Note: Skip initialization for vim-tiny or vim-small.
 if 0 | endif

 if &compatible
	 set nocompatible               " Be iMproved
 endif

 " Required:
 set runtimepath+=~/.vim/bundle/neobundle.vim/

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!

 call neobundle#end()

 " Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck

 syntax on
" color dracula

" dein config
 let s:dein_dir = fnamemodify('~/.vim/dein/', ':p')
 let s:dein_repo_dir = s:dein_dir . 'repos/github.com/Shougo/dein.vim'

" dein.vim本体をランタイムパスに追加
 if &runtimepath !~# '/dein.vim'
	     execute 'set runtimepath^=' . s:dein_repo_dir
		 endif

call dein#begin(s:dein_dir)

"Plugins
" call dein#add('Shogo/neocomplete')
" nerdtree autocmd
call dein#add('scrooloose/nerdtree')
" if close file, NERDTree close at some time
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" autocmd VimEnter * execute 'NERDTree'

" vim-go setup
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"
" guruで急に定義元ジャンプできなくなる部分が出てきたので、https://github.com/fatih/vim-go/issues/1687を参考にgodefに修正した。直った理由はよくわからない
let g:go_def_mode = "godef"


" errの色を変える
autocmd FileType go :highlight goErr cterm=bold ctermfg=9
autocmd FileType go :match goErr /\<err\>/


call dein#add('fatih/vim-go')
call dein#add('racer-rust/vim-racer')
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

" " neocomplete・neosnippet・neosnippet-snippets（コードの自動補完）
" if has('lua')
" 	call dein#add('Shougo/neocomplete.vim')
" 	call dein#add('Shougo/neosnippet')
" 	call dein#add('Shougo/neosnippet-snippets')
" endif
"
" " neocomplete・neosnippetの設定
"
" " Vim起動時にneocompleteを有効にする
" let g:neocomplete#enable_at_startup = 1
"
" " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
" let g:neocomplete#enable_smart_case = 1
"
"  " 3文字以上の単語に対して補完を有効にする
" let g:neocomplete#min_keyword_length = 3
"
" " 区切り文字まで補完する
" let g:neocomplete#enable_auto_delimiter = 1
"
" " 1文字目の入力から補完のポップアップを表示
" let g:neocomplete#auto_completion_start_length = 1
"
" " バックスペースで補完のポップアップを閉じる
" inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"
"
" " エンターキーで補完候補の確定.スニペットの展開もエンターキーで確定・・・・・・②
" imap <expr><CR> neosnippet#expandable() ? <Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>")))
"
" " タブキーで補完候補の選択.スニペット内のジャンプもタブキーでジャンプ・・・・・・③
" imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>")))
"
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

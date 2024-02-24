" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" C 语言缩紧 
set cindent
" TAB 长度为4
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" 切换分屏
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l
" 自动补全括号
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {<CR>}<ESC>O

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.c,*.h,*.sh exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头
func SetTitle() 
	"如果文件类型为.sh文件 
	if expand("%:e") == 'sh'
        call setline(1, "#!/bin/bash")
        call append(line("."), "")
		call append(line(".")+1, "#*********************************************************************") 
		call append(line(".")+2, "# File Name: ".expand("%:t")) 
		call append(line(".")+3, "# Author: Lynn") 
		call append(line(".")+4, "# Created Time: ".strftime("%c")) 
		call append(line(".")+5, "#*********************************************************************") 
		call append(line(".")+6, "")
	else 
		call setline(1, "/*********************************************************************") 
		call append(line("."), "	> File Name: ".expand("%:t")) 
		call append(line(".")+1, "	> Author: Lynn") 
		call append(line(".")+2, "	> Created Time: ".strftime("%c")) 
		call append(line(".")+3, "*********************************************************************/") 
		call append(line(".")+4, "")
	endif
	if expand("%:e") == 'cpp'
		call append(line(".")+5, "#include <iostream>")
    	call append(line(".")+6, "using namespace std;")
		call append(line(".")+7, "")
	endif
	if expand("%:e") == 'c'
		call append(line(".")+5, "#include <stdio.h>")
		call append(line(".")+6, "")
	endif
    if expand("%:e") == 'h'
        call append(line(".")+5, "#ifndef ".toupper(expand("%:t:r"))."_H")
        call append(line(".")+6, "#define ".toupper(expand("%:t:r"))."_H")
        call append(line(".")+7, "")
        call append(line(".")+8, "")
        call append(line(".")+9, "")
        call append(line(".")+10, "#endif")
    endif
endfunc

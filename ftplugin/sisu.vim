"%% SiSU Vim ftplugin
" SiSU Maintainer: Ralph Amissah <ralph@amissah.com>
" SiSU Markup:     SiSU (sisu-0.38)
" an ftplugin setting defaults for editing sisu markup files
:syntax on
:filetype on
:filetype indent on
":let dialect='UK'
:if version >= 700
:  setlocal spell spelllang=en_us
:endif
:autocmd FileType sisu :set nonumber
:set encoding=utf-8 fileencodings=
:set ff=unix 
:set autowrite          " Automatically save before commands like :next and :make
:set nocompatible
:set tabstop=2
:set expandtab
:set shiftwidth=2
:set autoindent
:set showcmd            " Show (partial) command in status line.
:set showmatch          " Show matching brackets.
:set ignorecase         " Do case insensitive matching
:set smartcase
:set incsearch
:set hlsearch
:set gdefault
:set guioptions=agmr
:set paste
:set laststatus=2       " status line always on
"% textwrap
:set whichwrap=<,>,h,l,[,]
:set nolinebreak        " only affects display not buffer
:set wrap
:set wrapmargin=0
"% map
":let mapleader = ","    " consider
:map <leader>paste :set invpaste<cr>
"% wrap/formatting paragraph according to the current 'textwidth' with ^J (control-j):
:imap <C-J> <C-O>gqap
:nmap <C-J>      gqap
:vmap <C-J>      gq
"% save file, go to next file in buffer
:map <leader>nf :w <enter> :n <enter>
"% vimdiff q exits
:if &diff
:  cmap q qa
:endif
"% directory files, placed in vertical split window
:map <leader>dir :vs<cr><C-W><C-R> :Explore<cr>
:map <leader>nn :set nonumber paste<cr>
:map <leader>nu :set number paste<cr>
:map <leader>no :set number nopaste<cr>
"% vimdiff q exits
:if &diff
:  cmap q qa
:endif 
"% remapping lines make cursor jump a line at a time within wrapped text
:nnoremap j gj
:nnoremap k gk
:vnoremap j gj
:vnoremap k gk
:nnoremap <Down> gj
:nnoremap <Up> gk
:vnoremap <Down> gj
:vnoremap <Up> gk
:inoremap <Down> <C-o>gj
:inoremap  <Up> <C-o>gk
"% colorscheme slate
:map <C-C> :syntax on <cr> :colorscheme slate<cr>
"% search and replace
:map <C-S> :.,$s///c "search and replace down
:map <c-G> :%s///c "search and replace whole file
:map <c-X> :rubyd gsub!(//, "")
"% pwd t64 working directory set to that of the file you're editing
"changes pwd to directory of file in current buffer
:function! CHANGE_CURR_DIR()
:  let _dir = expand("%:p:h")
:    exec "cd " . _dir
:    unlet _dir
:endfunction
"% Change to the directory the file in your current buffer is in
:if has("autocmd")
   autocmd BufEnter * :lcd %:p:h
:endif
"% autocompletefilenames To search for files in the current directory
:set path=,,
"auto-completion for file to edit in current dir, used in normal mode
:map <leader>e :e <c-r>=expand("%:p:h") . "/" <cr>
:map <leader>pwd :exe 'cd ' . expand ("%:p:h")<cr>
"% searchhighlight t93: Toggle search highlight <C-n>
:function! ToggleHLSearched()
:  if &hls
:    set nohls
:  else
:    set hls
:  endif
:endfun
:nmap <silent> <C-n> :silent call ToggleHLSearched()<cr>
"%% SiSU vim folds
"% foldsearchx FoldSearch (opens result of search all else closed) t77
:map fs :set foldmethod=expr foldcolumn=2 foldlevel=0 <cr>
:map <C-F> :F<cr>  "consider, is a remapping
:map <leader>ff :F<cr>
:map <leader>fe :F<cr> zE
"% foldtoggle Fold Toggle mapped to <space>
:fun! ToggleFold()
:  if foldlevel('.') == 0
:    normal! l
:  else
:    if foldclosed('.') < 0
:      foldclose
:    else
:      foldopen
:    endif
:  endif
"  Clear status line
:  echo
:endfun
" Map this function to Space key.
:noremap <space> :call ToggleFold()<cr>
"% foldtype Fold? set foldtext
:set foldtext=v:folddashes.substitute(getline(v:foldstart),'\\=','','g',)
:set foldexpr=getline(v:lnum-1)!~@/&&getline(v:lnum)!~@/&&getline(v:lnum+1)!~@/
"% foldsearch t77: Fold on search result 
:function! FoldMake(search)
:  set fdm=manual
:  normal zE
:  normal G$
:  let folded = 0     "flag to set when a fold is found
:  let flags = "w"    "allow wrapping in the search
:  let line1 =  0     "set marker for beginning of fold
:  while search(a:search, flags) > 0
:    let  line2 = line(".")
:      if (line2 -1 > line1)
:        "echo line1 . ":" . (line2-1)
:        "echo "a fold goes here."
:        execute ":" . line1 . "," . (line2-1) . "fold"
:        let folded = 1       "at least one fold has been found
:     endif
:     let line1 = line2     "update marker
:     let flags = "W"       "turn off wrapping
:  endwhile
"  create the last fold which goes to the end of the file.
:  normal $G
:  let  line2 = line(".")
:  if (line2  > line1 && folded == 1)
:    execute ":". line1 . "," . line2 . "fold"
:  endif
:  normal 1G
:endfunction
"% folds Fold Patterns
:command! -nargs=+ -complete=command FMake call FoldMake(<q-args>)
:  if ( &filetype == "ruby" )
:    command! F FMake ^# ==\?\|^\s*\(\(def\|class\|module\)\s\|\(public\|protected\|private\|__END__\)\s*$\)\|\(^\s*\|\s\+\)#%\s
:    command! Fa FMake \(^# ==\?\|^\s*\(\(\(def\|class\|module\)\s\)\|\(\(public\|protected\|private\|__END__\)\(\s*$\)\)\)\)\|^[0-9]\~\|\([#%]\|^["]\)\{1,4\}\s*%\|{\({\|!!\)
:    command! FD FMake \(^# ==\?\|^\s*\(\(def\|class\|module\)\s\)\)\|^\s*\([#%"0-9]\{0,4\}\~\(%\+\s\|!!\)\|#\s\+=\+\s\+\)
:  else
"% folds :F Fold Patterns SiSU Markup :F
:    command! F FMake  ^\([1-8]\|:\?[A-C]\)\~\|\(^%\|\(^\|\s\+\)[#"]\)%\{1,2\}\(\s\|$\)\|^<<\s*|
:    command! Fa FMake ^\([1-8]\|:\?[A-C]\)\~\|\(^%\|\(^\|\s\+\)[#"]\)%\{1,2\}\(\s\|$\)\|^<<\s*|\|^\(Book\|Part\|Chapter\|Section\|Article\|BOOK\|PART\|CHAPTER\|SECTION\|ARTICLE\)\s
:    command! F0 FMake ^\(\s*0\~\|@\S\+:[+-]\?\s\+\)
:    command! FA FMake ^:\?A\~
:    command! FB FMake ^:\?[AB]\~
:    command! FC FMake ^:\?[A-C]\~
:    command! F1 FMake ^\(:\?[A-C]\|1\)\~
:    command! F2 FMake ^\(:\?[A-C]\|[12]\)\~
:    command! F3 FMake ^\(:\?[A-C]\|[1-3]\)\~
:    command! F4 FMake ^[1-4]\~
:    command! F5 FMake ^[4-5]\~
:    command! F6 FMake ^[4-6]\~
:    command! Fc FMake ^[%]\+\s\+ 
:  endif
"% folds Fold Patterns misc
":command! Fp FMake ^\s*[A-Za-z0-9#]
:command! Fp FMake ^\s*\S
:command! Fo FMake ^[%\"]\s*[{>]

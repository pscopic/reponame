if has("autocmd")
  filetype plugin indent on    " Enabled file type detection and include indent files
  let b:gzflag = 1
  unlet b:gzflag
" change directory to the directory containing file
  au BufEnter * :lcd %:p:h
  au FileType python set complete+=kC:~/.vim/pydiction iskeyword+=.,(
  au Filetype html,xml,xsl source ~/.vim/scripts/closetag.vim
endif " has ("autocmd")

function! FT_Diff()
        if v:version >= 600
                setlocal foldmethod=expr
                setlocal foldexpr=DiffFoldLevel(v:lnum)
        else
        endif
endf

" ---------------------------------------------------------------------------
" no folds in vimdiff

function! NoFoldsInDiffMode()
        if &diff
                :silent! :%foldopen!
        endif
endf

augroup Diffs
  autocmd!
  autocmd BufRead,BufNewFile *.patch :setf diff
  autocmd BufEnter           *       :call NoFoldsInDiffMode()
  autocmd FileType           diff    :call FT_Diff()
augroup END

if has("autocmd")
   augroup filetype
    au BufRead reportbug.*      set ft=mail
    au BufRead reportbug-*      set ft=mail
   augroup END
endif

" Vim syntax file
" Language:     text (pajama)
" Maintainer:   Tony Mechelynck <antoine.mechelynck <at> skynet.be>
" Last Change:  2006 Feb 15
" ------------------------------------------------------------------------
" --                              HEADER                                --
" ------------------------------------------------------------------------
" For version 5.x: Clear all syntax items
" For version 6.x or later: Quit if a syntax file was already loaded
if !exists("main_syntax")
        if version < 600
                syntax clear
        elseif exists("b:current_syntax")
                finish
        endif
        let main_syntax = "text"
endif
" ------------------------------------------------------------------------
" --                    BODY: define pajama syntax                      --
" ------------------------------------------------------------------------
if &bg == "light"
        hi default Oddlines     term=NONE    ctermbg=yellow    guibg=#FFFF99
        hi default Evenlines    term=reverse ctermbg=magenta   guibg=#FFCCFF
else
        hi default Oddlines     term=NONE    ctermbg=blue      guibg=#000080
        hi default Evenlines    term=reverse ctermbg=darkgreen guibg=#008000
endif

syn match Oddlines  "^.*$\n" nextgroup=Evenlines skipnl
syn match Evenlines "^.*$\n" nextgroup=Oddlines  skipnl

" the following makes sure that odd lines are highlighted with Oddlines,
" even lines with Evenlines; not the opposite.
syn sync fromstart

" WARNING: $VIMRUNTIME/vimrc_example.vim has an autocommand which sets
" 'textwidth' to 78 when a file's filetype is set to "text".
" That autocommand can be disabled by adding to your vimrc (after
" sourcing the vimrc_example) the line
"       au! vimrcEx FileType text

" ------------------------------------------------------------------------
" --                              TRAILER                               --
" ------------------------------------------------------------------------
let b:current_syntax = "text"

if main_syntax == "text"
        unlet main_syntax
endif

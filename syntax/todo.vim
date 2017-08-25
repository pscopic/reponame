" Vim script to set syntax highlighting for a todo list.

" A todo list is recognized by file names of the form *.todo,
" OR files that contain #todo as the first line of a file,
" OR files with modelines that contain ft=todo

" Header lines              - Lines starting at column 0.
" Normal priority items     - Non-header lines that start with a 'o'.
" High priority items       - .... with a '+'.
" Low priority items        - .... with a '-'.
" Items completed           - ... with a 'd'.
" Items ignored             - ... with a 'x'.
" Comments                  - Stuff enclosed in '[' and ']' or any line
"                             that is none of the above.

" See the file test.todo for sample entries.

" Bugs
" o The syntax highlighting needs to be colorscheme indpendent.
"   Currently it works with light backgrounds (e.g., delek)
" o Marking a multi-line item as completed by appending :done doesn't
"   change the color. But changing the prefix to 'D' seems to work.

if exists("b:current_syntax")
  finish
endif

syn case ignore

" Header lines to start sections.
syn match todoHeader1    "^[^o+\-? \t].*:$"
syn match todoHeader2    "\(^\s\s*\)\@<=[^o+\-?].*:$"
" Comments embedded in todo items.
syn region todoComment   start="\[" end="\]" contained

" Normal priority items.
syn region todoNormalPri start="\(^\s*\)\@<=o\s"        end="\(^\s*[o\-+?dxi]\s\|\n\n\+\)"he=s-1,me=s-1 contains=todoComment keepend
" High priority items.
syn region todoHiPri     start="\(^\s*\)\@<=+\s"        end="\(^\s*[o\-+?dxi]\s\|\n\n\+\)"he=s-1,me=s-1 contains=todoComment keepend
" Low pri 
syn region todoLowPri    start="\(^\s*\)\@<=-\s"        end="\(^\s*[o\-+?dxi]\s\|\n\n\+\)"he=s-1,me=s-1 contains=todoComment keepend
" Unprioritized items.
syn region todoQuestion     start="\(^\s*\)\@<=?\s"        end="\(^\s*[o\-+?dxi]\s\|\n\n\+\)"he=s-1,me=s-1 contains=todoComment keepend
" Items completed.
syn region todoDone      start="\(^\s*\)\@<=d\s"     end="\(^\s*[o\-+?dxi]\s\|\n\n\+\)"he=s-1,me=s-1 contains=todoComment keepend
" Items ignored/won't do.
syn region todoIgnore    start="\(^\s*\)\@<=[xi]\s"   end="\(^\s*[o\-+?dxi]\s\|\n\n\+\)"he=s-1,me=s-1 contains=todoComment keepend

" Fix this to handle multi-line items.
syn match todoIgnore    "\(^\s*\)\@<=[o+\-?].*:ignore$" contains=todoComment
syn match todoDone      "\(^\s*\)\@<=[o+\-?].*:done$" contains=todoComment

syn case match

"--------------------------------------------------------------------------
" Specify colors and effects for each region here.
"--------------------------------------------------------------------------

hi todoHeader1          gui=bold
hi todoHeader2          gui=bold
 
hi todoHiPri            guifg=Red
hi todoNormalPri        guifg=Orange
hi todoLowPri           guifg=Blue
 
hi todoDone             guifg=Green
hi todoIgnore           guifg=Gray
" hi todoQuestion         guifg=Brown gui=bold
hi def link todoQuestion    Todo

"
" TODO: Define a highlight set that
" works with all colorschemes.
"
"hi default link todoHeader1 Underlined
"hi default link todoHeader2 Underlined
"hi default link todoHiPri Special
"hi default link todoNormalPri Typedef
"hi default link todoLowPri Define
"hi default link todoDone Constant
"hi default link todoIgnore Ignore
"hi default link todoQuestion Todo
"--------------------------------------------------------------------------
" End colors and effects specification.
"--------------------------------------------------------------------------

let b:current_syntax = "todo"

" vim: ts=18

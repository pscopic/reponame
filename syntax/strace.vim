" Vim syntax file
" This is a GENERATED FILE. Please always refer to source file at the URI below.
" Language: strace output
" Maintainer: David Ne\v{c}as (Yeti) <yeti@physics.muni.cz>
" Last Change: 2001-04-26
" URI: http://physics.muni.cz/~yeti/download/strace.vim


" Setup
if version >= 600
  if exists("b:current_syntax")
    finish
  endif
else
  syntax clear
endif

syn case match

" Parse the line
syn match straceSpecialChar "\\\d\d\d\|\\." contained
syn region straceString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=straceSpecialChar oneline
syn match straceNumber "\W[+-]\=\(\d\+\)\=\.\=\d\+\([eE][+-]\=\d\+\)\="lc=1
syn match straceNumber "\W0x\x\+"lc=1
syn match straceNumberRHS "\W\(0x\x\+\|-\=\d\+\)"lc=1 contained
syn match straceOtherRHS "?" contained
syn match straceConstant "[A-Z_]\{2,}"
syn region straceVerbosed start="(" end=")" matchgroup=Normal contained oneline
syn region straceReturned start="\s=\s" end="$" contains=StraceEquals,straceNumberRHS,straceOtherRHS,straceConstant,straceVerbosed oneline transparent
syn match straceEquals "\s=\s"ms=s+1,me=e-1
syn match straceSysCall "^\w\+"
syn match straceParenthesis "[][(){}]"
syn match straceOperator "[-+=*/!%&|:,]"
syn region straceComment start="/\*" end="\*/" oneline

" Define the default highlighting
if version >= 508 || !exists("did_strace_syntax_inits")
  if version < 508
    let did_strace_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink straceComment     Comment
  HiLink straceVerbosed    Comment
  HiLink straceNumber      Number
  HiLink straceNumberRHS   Type
  HiLink straceOtherRHS    Type
  HiLink straceString      String
  HiLink straceConstant    Function
  HiLink straceEquals      Type
  HiLink straceSysCall     Statement
  HiLink straceParenthesis Statement
  HiLink straceOperator    Normal
  HiLink straceSpecialChar Special

  delcommand HiLink
endif

let b:current_syntax = "strace"

"=============================================================================
" File:		html.vim                                           {{{1
" Author:	arias@m-a-g.net
" Version:	«version»
" Created:	Sun 30 Mar 2008 01:18:52 PM PDT
" Last Update:	Sun 30 Mar 2008 01:18:52 PM PDT
"------------------------------------------------------------------------
" Description:	«description»
"
"------------------------------------------------------------------------
" Installation:	«install details»
" History:	«history»
" TODO:		«missing features»
" }}}1
"=============================================================================

setlocal makeprg=tidy\ -quiet\ -errors\ %
setlocal errorformat=line\ %l\ column\ %v\ -\ %m


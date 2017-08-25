"=============================================================================
" File:		java_fc.vim                                           {{{1
" Author:	ydef
" Version:	0.75
" Created:	Sun 22 Apr 2007 10:05:35 AM PDT
" Last Update:	Sun 22 Apr 2007 10:05:35 AM PDT
"------------------------------------------------------------------------
" Description:	«Sets local variable omnifunc»
"
"------------------------------------------------------------------------
" Installation:	«place this in ftplugin directory»
" History:	«From the javacomplete.zip vim package script»
"=============================================================================

"=============================================================================
" Avoid buffer reinclusion {{{1
if exists('b:loaded_ftplug_java_fc_vim') | finish | endif
let b:loaded_ftplug_java_fc_vim = 1

let s:cpo_save=&cpo
set cpo&vim
:setlocal omnifunc=javacomplete#Complete
" }}}1
"------------------------------------------------------------------------
" Commands and mappings {{{1
:setlocal omnifunc=javacomplete#Complete
" Commands and mappings }}}1
"=============================================================================
" Avoid global reinclusion {{{1
if exists("g:loaded_java_fc_vim")
  let &cpo=s:cpo_save
  finish
endif
let g:loaded_java_fc_vim = 1
" Avoid global reinclusion }}}1
"------------------------------------------------------------------------

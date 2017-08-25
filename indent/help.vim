"=============================================================================
" File:		help.vim        
" Author:	ydef
" Version:	0.1alpha
" Created:	Sat 05 May 2007 03:29:18 PM PDT
" Last Update:	Sat 05 May 2007 03:29:18 PM PDT
"------------------------------------------------------------------------
" Description:	Missing indent/help.vim that verbose always complains about
"=============================================================================
" Avoid buffer reinclusion
if exists('b:loaded_ftplug_help_vim') | finish | endif
let b:loaded_ftplug_help_vim = 1
 
let s:cpo_save=&cpo
set cpo&vim
"=============================================================================
" Avoid global reinclusion {{{1
if exists("g:loaded_help_vim") 
  let &cpo=s:cpo_save
  finish 
endif
let g:loaded_help_vim = 1
" Avoid global reinclusion }}}1
"------------------------------------------------------------------------
set filetype=help

:let b:did_indent = 1
 
let &cpo=s:cpo_save
"=============================================================================
" vim600: set fdm=marker:

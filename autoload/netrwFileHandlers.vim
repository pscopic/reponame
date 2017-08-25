" netrwFileHandlers: contains various extension-based file handlers for
"                    netrw's browsers' x command ("eXecute launcher")
" Author:	Charles E. Campbell, Jr.
" Date:		May 30, 2006
" Version:	9
" Copyright:    Copyright (C) 1999-2005 Charles E. Campbell, Jr. {{{1
"               Permission is hereby granted to use and distribute this code,
"               with or without modifications, provided that this copyright
"               notice is copied with it. Like anything else that's free,
"               netrwFileHandlers.vim is provided *as is* and comes with no
"               warranty of any kind, either expressed or implied. In no
"               event will the copyright holder be liable for any damages
"               resulting from the use of this software.
"
" Load Once: {{{1
if exists("g:loaded_netrwFileHandlers") || &cp
 finish
endif
let s:keepcpo= &cpo
set cpo&vim
let g:loaded_netrwFileHandlers= "v9"

" ---------------------------------------------------------------------
" netrwFileHandlers#Invoke: {{{1
fun! netrwFileHandlers#Invoke(exten,fname)
"  call Dfunc("netrwFileHandlers#Invoke(exten<".a:exten."> fname<".a:fname.">)")
  let fname= a:fname
  " list of supported special characters.  Consider rcs,v --- that can be
  " supported with a NFH_rcsCOMMAv() handler
  if a:fname =~ '[@:,$!=\-+%?;~]'
   let specials= {
\   '@' : 'AT',
\   ':' : 'COLON',
\   ',' : 'COMMA',
\   '$' : 'DOLLAR',
\   '!' : 'EXCLAMATION',
\   '=' : 'EQUAL',
\   '-' : 'MINUS',
\   '+' : 'PLUS',
\   '%' : 'PERCENT',
\   '?' : 'QUESTION',
\   ';' : 'SEMICOLON',
\   '~' : 'TILDE'}
   let fname= substitute(a:fname,'[@:,$!=\-+%?;~]','\=specials[submatch(0)]','ge')
"   call Decho('fname<'.fname.'> done with dictionary')
  endif

  if a:exten != "" && exists("*NFH_".a:exten)
   " support user NFH_*() functions
"   call Decho("let ret= netrwFileHandlers#NFH_".a:exten.'("'.fname.'")')
   exe "let ret= NFH_".a:exten.'("'.fname.'")'
  elseif a:exten != "" && exists("*s:NFH_".a:exten)
   " use builtin-NFH_*() functions
"   call Decho("let ret= netrwFileHandlers#NFH_".a:exten.'("'.fname.'")')
   exe "let ret= s:NFH_".a:exten.'("'.fname.'")'
  endif

"  call Dret("netrwFileHandlers#Invoke 0 : ret=".ret)
  return 0
endfun

" ---------------------------------------------------------------------
" s:NFH_html: handles html when the user hits "x" when the {{{1
"                        cursor is atop a *.html file
fun! s:NFH_html(pagefile)
"  call Dfunc("s:NFH_html(".a:pagefile.")")

  let page= substitute(a:pagefile,'^','file://','')

  if executable("mozilla")
"   call Decho("executing !mozilla ".page)
   exe "!mozilla ".g:netrw_shq.page.g:netrw_shq
  elseif executable("netscape")
"   call Decho("executing !netscape ".page)
   exe "!netscape ".g:netrw_shq..page.g:netrw_shq
  else
"   call Dret("s:NFH_html 0")
   return 0
  endif

"  call Dret("s:NFH_html 1")
  return 1
endfun

" ---------------------------------------------------------------------
" s:NFH_htm: handles html when the user hits "x" when the {{{1
"                        cursor is atop a *.htm file
fun! s:NFH_htm(pagefile)
"  call Dfunc("s:NFH_htm(".a:pagefile.")")

  let page= substitute(a:pagefile,'^','file://','')

  if executable("mozilla")
"   call Decho("executing !mozilla ".page)
   exe "!mozilla ".g:netrw_shq.page.g:netrw_shq
  elseif executable("netscape")
"   call Decho("executing !netscape ".page)
   exe "!netscape ".g:netrw_shq.page.g:netrw_shq
  else
"   call Dret("s:NFH_htm 0")
   return 0
  endif

"  call Dret("s:NFH_htm 1")
  return 1
endfun

" ---------------------------------------------------------------------
" s:NFH_jpg: {{{1
fun! s:NFH_jpg(jpgfile)
"  call Dfunc("s:NFH_jpg(jpgfile<".a:jpgfile.">)")

  if executable("gimp")
   exe "silent! !gimp -s ".g:netrw_shq.a:jpgfile.g:netrw_shq
  elseif executable(expand("$SystemRoot")."/SYSTEM32/MSPAINT.EXE")
"   call Decho("silent! !".expand("$SystemRoot")."/SYSTEM32/MSPAINT ".escape(a:jpgfile," []|'"))
   exe "!".expand("$SystemRoot")."/SYSTEM32/MSPAINT ".g:netrw_shq.a:jpgfile.g:netrw_shq
  else
"   call Dret("s:NFH_jpg 0")
   return 0
  endif

"  call Dret("s:NFH_jpg 1")
  return 1
endfun

" ---------------------------------------------------------------------
" s:NFH_gif: {{{1
fun! s:NFH_gif(giffile)
"  call Dfunc("s:NFH_gif(giffile<".a:giffile.">)")

  if executable("gimp")
   exe "silent! !gimp -s ".g:netrw_shq.a:giffile.g:netrw_shq
  elseif executable(expand("$SystemRoot")."/SYSTEM32/MSPAINT.EXE")
   exe "silent! !".expand("$SystemRoot")."/SYSTEM32/MSPAINT ".g:netrw_shq.a:giffile.g:netrw_shq
  else
"   call Dret("s:NFH_gif 0")
   return 0
  endif

"  call Dret("s:NFH_gif 1")
  return 1
endfun

" ---------------------------------------------------------------------
" s:NFH_png: {{{1
fun! s:NFH_png(pngfile)
"  call Dfunc("s:NFH_png(pngfile<".a:pngfile.">)")

  if executable("gimp")
   exe "silent! !gimp -s ".g:netrw_shq.a:pngfile.g:netrw_shq
  elseif executable(expand("$SystemRoot")."/SYSTEM32/MSPAINT.EXE")
   exe "silent! !".expand("$SystemRoot")."/SYSTEM32/MSPAINT ".g:netrw_shq.a:pngfile.g:netrw_shq
  else
"   call Dret("s:NFH_png 0")
   return 0
  endif

"  call Dret("s:NFH_png 1")
  return 1
endfun

" ---------------------------------------------------------------------
" s:NFH_pnm: {{{1
fun! s:NFH_pnm(pnmfile)
"  call Dfunc("s:NFH_pnm(pnmfile<".a:pnmfile.">)")

  if executable("gimp")
   exe "silent! !gimp -s ".g:netrw_shq.a:pnmfile.g:netrw_shq
  elseif executable(expand("$SystemRoot")."/SYSTEM32/MSPAINT.EXE")
   exe "silent! !".expand("$SystemRoot")."/SYSTEM32/MSPAINT ".g:netrw_shq.a:pnmfile.g:netrw_shq
  else
"   call Dret("s:NFH_pnm 0")
   return 0
  endif

"  call Dret("s:NFH_pnm 1")
  return 1
endfun

" ---------------------------------------------------------------------
" s:NFH_bmp: visualize bmp files {{{1
fun! s:NFH_bmp(bmpfile)
"  call Dfunc("s:NFH_bmp(bmpfile<".a:bmpfile.">)")

  if executable("gimp")
   exe "silent! !gimp -s ".a:bmpfile
  elseif executable(expand("$SystemRoot")."/SYSTEM32/MSPAINT.EXE")
   exe "silent! !".expand("$SystemRoot")."/SYSTEM32/MSPAINT ".g:netrw_shq.a:bmpfile.g:netrw_shq
  else
"   call Dret("s:NFH_bmp 0")
   return 0
  endif

"  call Dret("s:NFH_bmp 1")
  return 1
endfun

" ---------------------------------------------------------------------
" s:NFH_pdf: visualize pdf files {{{1
fun! s:NFH_pdf(pdf)
"  call Dfunc("s:NFH_pdf(pdf<".a:pdf.">)")
  if executable("gs")
   exe 'silent! !gs '.g:netrw_shq.a:pdf.g:netrw_shq
  elseif executable("pdftotext")
   exe 'silent! pdftotext -nopgbrk '.g:netrw_shq.a:pdf.g:netrw_shq
  else
"  call Dret("s:NFH_pdf 0")
   return 0
  endif

"  call Dret("s:NFH_pdf 1")
  return 1
endfun

" ---------------------------------------------------------------------
" s:NFH_doc: visualize doc files {{{1
fun! s:NFH_doc(doc)
"  call Dfunc("s:NFH_doc(doc<".a:doc.">)")

  if executable("oowriter")
   exe 'silent! !oowriter '.g:netrw_shq.a:doc.g:netrw_shq
   redraw!
  else
"  call Dret("s:NFH_doc 0")
   return 0
  endif

"  call Dret("s:NFH_doc 1")
  return 1
endfun

" ---------------------------------------------------------------------
" s:NFH_sxw: visualize sxw files {{{1
fun! s:NFH_sxw(sxw)
"  call Dfunc("s:NFH_sxw(sxw<".a:sxw.">)")

  if executable("oowriter")
   exe 'silent! !oowriter '.g:netrw_shq.a:sxw.g:netrw_shq
   redraw!
  else
"   call Dret("s:NFH_sxw 0")
   return 0
  endif

"  call Dret("s:NFH_sxw 1")
  return 1
endfun

" ---------------------------------------------------------------------
" s:NFH_xls: visualize xls files {{{1
fun! s:NFH_xls(xls)
"  call Dfunc("s:NFH_xls(xls<".a:xls.">)")

  if executable("oocalc")
   exe 'silent! !oocalc '.g:netrw_shq.a:xls.g:netrw_shq
   redraw!
  else
"  call Dret("s:NFH_xls 0")
   return 0
  endif

"  call Dret("s:NFH_xls 1")
  return 1
endfun

" ---------------------------------------------------------------------
" s:NFH_ps: handles PostScript files {{{1
fun! s:NFH_ps(ps)
"  call Dfunc("s:NFH_ps(ps<".a:ps.">)")
  if executable("gs")
"   call Decho("exe silent! !gs ".a:ps)
   exe "silent! !gs ".g:netrw_shq.a:ps.g:netrw_shq
   redraw!
  elseif executable("ghostscript")
"   call Decho("exe silent! !ghostscript ".a:ps)
   exe "silent! !ghostscript ".g:netrw_shq.a:ps.g:netrw_shq
   redraw!
  elseif executable("gswin32")
"   call Decho("exe silent! !gswin32 ".g:netrw_shq.a:ps.g:netrw_shq)
   exe "silent! !gswin32 ".g:netrw_shq.a:ps.g:netrw_shq
   redraw!
  else
"   call Dret("s:NFH_ps 0")
   return 0
  endif

"  call Dret("s:NFH_ps 1")
  return 1
endfun

" ---------------------------------------------------------------------
" s:NFH_eps: handles encapsulated PostScript files {{{1
fun! s:NFH_eps(eps)
"  call Dfunc("s:NFH_eps()")
  if executable("gs")
   exe "silent! !gs ".g:netrw_shq.a:eps.g:netrw_shq
   redraw!
  elseif executable("ghostscript")
   exe "silent! !ghostscript ".g:netrw_shq.a:eps.g:netrw_shq
   redraw!
  elseif executable("ghostscript")
   exe "silent! !ghostscript ".g:netrw_shq.a:eps.g:netrw_shq
   redraw!
  elseif executable("gswin32")
   exe "silent! !gswin32 ".g:netrw_shq.a:eps.g:netrw_shq
   redraw!
  else
"   call Dret("s:NFH_eps 0")
   return 0
  endif
"  call Dret("s:NFH_eps 0")
  return 1
endfun

" ---------------------------------------------------------------------
" s:NFH_fig: handles xfig files {{{1
fun! s:NFH_fig(fig)
"  call Dfunc("s:NFH_fig()")
  if executable("xfig")
   exe "silent! !xfig ".a:fig
   redraw!
  else
"   call Dret("s:NFH_fig 0")
   return 0
  endif

"  call Dret("s:NFH_fig 1")
  return 1
endfun

" ---------------------------------------------------------------------
" s:NFH_obj: handles tgif's obj files {{{1
fun! s:NFH_obj(obj)
"  call Dfunc("s:NFH_obj()")
  if has("unix") && executable("tgif")
   exe "silent! !tgif ".a:obj
   redraw!
  else
"   call Dret("s:NFH_obj 0")
   return 0
  endif

"  call Dret("s:NFH_obj 1")
  return 1
endfun

let &cpo= s:keepcpo
" ---------------------------------------------------------------------
"  Modelines: {{{1
"  vim: fdm=marker

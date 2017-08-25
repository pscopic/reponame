"	multiwin.vim:	Show every buffer in its own window and use
"					statuslines as "tabs"
"	Maintainer:		Patrick Avery, patrick dot avery at gmail dot com
"	Created:		Tue 01 Apr 2004 03:35:39 AM CDT
"	Last Modified:	Fri 24 Dec 2004 01:56:21 AM CST
"	Version:		1.4
"	Usage:			place in vimfiles/plugin

if exists("s:loaded") || &cp || &diff || exists("g:singlewin")
	finish
endif
let s:initialized = 0
if exists("g:multiwin_qfh")
	let s:QFHeight = g:multiwin_qfh
else
	let s:QFHeight = 10
endif

" UI Settings: These settings change the behavior of vim to allow the
" script to work.
"____________________________________________________________________
function! s:SetUI()
	set noequalalways
	set splitbelow
	set winheight=1
	set winminheight=0
	set laststatus=2
endfunction

function! s:BackupUI()
	if &equalalways
		let s:ea = "ea"
	else
		let s:ea = "noea"
	endif
	if &sb
		let s:sb = "sb"
	else
		let s:sb = "nosb"
	endif
	let s:wh = &winheight
	let s:wmh = &winminheight
	let s:ls = &laststatus
endfunction

function! s:RestoreUI()
	exec "set " . s:ea
	exec "set " . s:sb
	exec "set winheight=" . s:wh
	exec "set winminheight=" . s:wmh
	exec "set laststatus=" . s:ls
endfunction

" Auto Commands: These autocommands make each window shrink and grow
" effectively without the negative effects of having winheight set too
" high and make VIM always behave as if -o was on the command line.
"_____________________________________________________________________
function! s:AutoCommands()
	augroup MultiWin
		autocmd!
		autocmd VimEnter * nested all | wincmd _
		autocmd WinEnter * nested call <SID>Maximize()
		autocmd BufWinEnter * nested if eventhandler() | sball | wincmd W | endif
	augroup END
endfunction

function! s:RemoveAutoCommands()
	augroup MultiWin
		autocmd!
	augroup END
endfunction

" Mappings: Makes a runtime toggle available to the user
"_____________________________________________________________________
if !hasmapto("<Plug>MultiWinToggle")
	nmap <unique> <silent>	<Leader>win <Plug>MultiWinToggle
endif

noremap	<silent> <script>	<Plug>MultiWinToggle	<SID>Toggle
noremap	<silent>			<SID>Toggle				:call <SID>ToggleMultiWin()<CR>

function! s:ExtraMappings()
	nmap	<silent>		gf						:new <cfile><CR>
	if has("gui")
		nmap	<silent>		<A-Left>				:wincmd k<CR>
		nmap	<silent>		<A-Right>				:wincmd j<CR>
	else
		nmap	<silent>		<C-Left>				:wincmd k<CR>
		nmap	<silent>		<C-Right>				:wincmd j<CR>
	endif	
endfunction

function! s:RemoveExtraMappings()
	unmap gf
	unmap <A-Left>
	unmap <A-Right>
endfunction

" State Functions: these functions initialize, destroy, and toggle
"_____________________________________________________________________
function! s:EnableMultiWin()
	call <SID>BackupUI()
	call <SID>SetUI()
	call <SID>AutoCommands()
	if !exists("g:multiwin_noextra")
		call <SID>ExtraMappings()
	endif
	let s:initialized = 1
endfunction

function! s:DisableMultiWin()
	call <SID>RestoreUI()
	call <SID>RemoveAutoCommands()
	if !exists("g:multiwin_noextra")
		call <SID>RemoveExtraMappings()
	endif
	let s:initialized = 0
endfunction

function! s:ToggleMultiWin()
	if s:initialized
		call <SID>DisableMultiWin()
	else
		call <SID>EnableMultiWin()
	endif
endfunction

function! s:Maximize()
	if (getbufvar(winbufnr(winnr()), "&buftype") == "quickfix")
		exec "resize " . s:QFHeight
	else
		wincmd _
		call <SID>ResizeQF()
	endif
endfunction

function! s:ResizeQF()
	set eventignore=WinEnter
	let i = 1
	let cbuf = winbufnr(i)
	while (cbuf != -1)
		if (getbufvar(cbuf, "&buftype") == "quickfix")
			exec i . "wincmd w"
			exec "resize " . s:QFHeight
			wincmd p
			break
		endif
		let i = i+1
		let cbuf = winbufnr(i)
	endwhile
	set eventignore-=WinEnter
endfunction

" Main:
"_____________________________________________________________________
call <SID>EnableMultiWin()

let s:loaded = 1
" vim:ts=4:fo=roq:

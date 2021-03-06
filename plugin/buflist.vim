"
"	File:    buflist.vim
"	Author:  Fabien Bouleau (syrion AT tiscali DOT fr)
"	Version: 1.7
"
"	Last Modified: March, 6th 2006
"
"	Usage:
"
"	When not in buffer list:
"
"	<F4> to open/access buffer list panel
"	<Leader><Leader>0 to <Leader><Leader>9 to mark window to number
"	<Leader><Leader>p to mark window as preview window
"
"	When in buffer list:
"
"	h to toggle help
"	q to close buffer list (same as CTRL-W q)
"	p to preview file in preview window
"	d to delete currently selected buffer
"	u to update buffer list
"	n to edit below <F4>
"	N to edit above <F4>
"   x to toggle path display
"   s to toggle sorting
"	<F4> to go back to <F4> window
"	<S-F3> to decrease buffer list width -1
"	<S-F4> to increase buffer list width +1
"	<C-S-F3> to decrease buffer list width -5
"	<C-S-F4> to increase buffer list width +5
"	<CR> to edit file in last window visited before <F4>
"	<Leader><Leader>0 to edit file in window marked 0
"	<Leader><Leader>9 to edit file in window marked 9
"
"	Installation:
"
"	Copy the script into your $VIM/vimfiles/plugin
"

if !exists("g:BufList_Hide")
    let g:BufList_Hide=1
endif

autocmd! * __BufList__

autocmd BufHidden __BufList__ call BufList_ClosePanel()
autocmd BufEnter __BufList__ call s:BufList_IamSoLonely()

map <silent> <F4> :call BufList_Open()<CR>
nmap <silent> <Leader><Leader>0 :call BufList_Mark(0)<CR>
nmap <silent> <Leader><Leader>1 :call BufList_Mark(1)<CR>
nmap <silent> <Leader><Leader>2 :call BufList_Mark(2)<CR>
nmap <silent> <Leader><Leader>3 :call BufList_Mark(3)<CR>
nmap <silent> <Leader><Leader>4 :call BufList_Mark(4)<CR>
nmap <silent> <Leader><Leader>5 :call BufList_Mark(5)<CR>
nmap <silent> <Leader><Leader>6 :call BufList_Mark(6)<CR>
nmap <silent> <Leader><Leader>7 :call BufList_Mark(7)<CR>
nmap <silent> <Leader><Leader>8 :call BufList_Mark(8)<CR>
nmap <silent> <Leader><Leader>9 :call BufList_Mark(9)<CR>
nmap <silent> <Leader><Leader>p :call BufList_Mark(10)<CR>
nmap <silent> <S-F3> :resize -1<CR>
nmap <silent> <S-F4> :resize +1<CR>
nmap <silent> <C-S-F3> :resize -5<CR>
nmap <silent> <C-S-F4> :resize +5<CR>

function! BufList_Mark(bufnum)
	if(bufname("%") != "__BufList__")
		let s:buflist_winedit{a:bufnum} = winnr()
	endif
endfunction

function! BufList_Edit()
	let name = s:BufList_SelectedName()
    if exists("g:BufList_Hide") && g:BufList_Hide == 1
        hide
    endif
	exec s:buflist_winedit . "wincmd w"
	if name != ""
		execute "edit " . name
	endif
endfunction

function! BufList_EditNew(pos)
	let name = s:BufList_SelectedName()
	exec s:buflist_winedit . "wincmd w"
	if a:pos == 0
		below new
	else
		above new
	endif
	execute "edit " . name
endfunction

function! BufList_EditIn(bufnum)
	let name = s:BufList_SelectedName()
	exec s:buflist_winedit{a:bufnum} . "wincmd w"
	if name != ""
		execute "edit " . name
	endif
endfunction

function! BufList_ToggleHelp()
	let s:buflist_help = 1 - s:buflist_help
	call BufList_Update()
endfunction

function! BufList_ToggleSort()
	let s:buflist_sort = (s:buflist_sort + 1) % 3
	call BufList_Update()
endfunction

function! BufList_TogglePath()
	let s:buflist_path = (s:buflist_path + 1) % 3
	call BufList_Update()
endfunction

function! BufList_ClosePanel()
	exec bufwinnr(s:buflist_bufwin) . "wincmd w"
	let s:buflist_columns = winwidth(0)
	execute "set columns-=" . s:buflist_columns
	hide
endfunction

function! BufList_Update()
	let linenr = line(".")

    %delete _
	
	let ssort = "num"
	let spath = "off"

	if s:buflist_path == 1
		let spath = "bef"
	elseif s:buflist_path == 2
		let spath = "aft"
	endif

	if s:buflist_sort == 1
		let ssort = "nam"
	elseif s:buflist_sort == 2
		let ssort = "ext"
	endif

	if(s:buflist_help == 0)
		call append(0, "\" h toggle help (off)")
		call append(1, "\" sort=" . ssort . " path=" . spath)
		call append(2, "")
		let j = 3
	else
		call append(0, "\" h toggle help (on)")
		call append(1, "\" q close buffer list")
		call append(2, "\" p preview buffer")
		call append(3, "\" d delete buffer")
		call append(4, "\" u update list")
		call append(5, "\" n edit below <F4>")
		call append(6, "\" N edit above <F4>")
		call append(7, "\" x toggle path display (" . spath . ")")
		call append(8, "\" s toggle sorting (" . ssort . ")")
		call append(9, "\" <F4> go back to <F4>")
		call append(10, "\" <S-F3> decrease width -1")
		call append(11, "\" <S-F4> increase width +1")
		call append(12, "\" <C-S-F3> decrease width -5")
		call append(13, "\" <C-S-F4> increase width +5")
		call append(14, "\" <CR> edit file in <F4>")
		call append(15, "\" \\\\n edit file in #n (n from 0 to 9)")
		call append(16, "")
		let j = 17
	endif
	
	let last_buffer = bufnr("$")
	let i = 1
	let s:cnt = 0

	while i <= last_buffer
		if(bufexists(i) && buflisted(i) && i != s:buflist_bufwin && bufname(i) != "")
			let bname = expand("#" . i . ":t")
			let bext  = expand("#" . i . ":e")

			if s:buflist_path == 2
				let pname = " - " . expand("#" . i . ":p:h")
			elseif s:buflist_path == 0
				let pname = ""
			elseif s:buflist_path == 1
				let bname = expand("#" . i . ":p")
				let pname = ""
			endif

			let s:buflist_name{s:cnt} = bname . pname
			let s:buflist_num{s:cnt}  = i
			let s:buflist_ext{s:cnt}  = bext
			let s:cnt = s:cnt + 1
		endif
		let i = i + 1
	endwhile

	if(s:buflist_sort > 0)
		call s:BufList_Sort()
	endif

	let i = 0
	while i < s:cnt
		let snr = s:buflist_num{i} + ""
		let ssp = "    "
		let ssp = strpart(ssp, 0, strlen(ssp) - strlen(snr))
		call append(j, s:buflist_num{i} . ":" . ssp . s:buflist_name{i})
		let i = i + 1
		let j = j + 1
	endwhile
	
	exec "norm " . linenr . "gg"
	set ft=vim
endfunction

function! BufList_Open()
	if (exists("s:buflist_bufwin") && bufwinnr(s:buflist_bufwin) != winnr())
		if (bufwinnr(s:buflist_bufwin) != -1)
			let s:buflist_winedit = winnr()
		else
			let s:buflist_winedit = winnr() + 1
		endif
	endif

	if(exists("s:buflist_bufwin") && bufexists(s:buflist_bufwin))
		call s:BufList_UnHide()
	else
		let s:buflist_winedit = winnr() + 1
		call s:BufList_CreatePanel()
		set nonumber
	endif

	call BufList_Update()
endfunction

function! BufList_Preview()
	if(exists("s:buflist_winedit10"))
		let nr = winnr()
		call BufList_EditIn(10)
		execute nr . "wincmd w"
	else
		let name = s:BufList_SelectedName()
		if name != ""
			execute "pedit " . s:BufList_SelectedName()
			exec bufwinnr(s:buflist_bufwin) . "wincmd w"
		endif
	endif
endfunction

function! BufList_Delete()
	let nr = s:BufList_SelectedNr()
	let wnr_del = bufwinnr(nr)
	let wnr_blist = winnr()

	if(wnr_del != -1)
		let last_buffer = bufnr("$")
		let i = 1

		while i <= last_buffer
			if(bufexists(i) && buflisted(i) && i != s:buflist_bufwin)
				execute wnr_del . "wincmd w"
				execute "e #" . i
				execute wnr_blist . "wincmd w"
				break
			endif
			let i = i + 1
		endwhile
	endif
	
	exec "bdelete " . nr
	call BufList_Update()
endfunction

function! BufList_Decrease(n)
	if s:buflist_columns > n
		let s:buflist_columns = s:buflist_columns - n
		execute "vertical resize " . s:buflist_columns
	endif
endfunction

function! BufList_Increase(n)
	if s:buflist_columns < 80
		let s:buflist_columns = s:buflist_columns + n
		execute "vertical resize " . s:buflist_columns
	endif
endfunction

function! BufList_GoAway()
	exec s:buflist_winedit . "wincmd w"
endfunction

function! s:BufList_Sort()
	let f = 0

	while f == 0
		let f = 1
		let j = 0
		while j < s:cnt - 1
			let bufswap = 0
			if s:buflist_sort == 1
				if s:buflist_name{j} > s:buflist_name{j + 1}
					let bufswap = 1
				endif
			elseif s:buflist_sort == 2
				if s:buflist_ext{j} > s:buflist_ext{j + 1}
					let bufswap = 1
				endif
				if s:buflist_ext{j} == s:buflist_ext{j + 1} 
				\  && s:buflist_name{j} > s:buflist_name{j + 1}
					let bufswap = 1
				endif
			endif

			if bufswap == 1
				let tmp = s:buflist_name{j}
				let s:buflist_name{j} = s:buflist_name{j + 1}
				let s:buflist_name{j + 1} = tmp

				let tmp = s:buflist_ext{j}
				let s:buflist_ext{j} = s:buflist_ext{j + 1}
				let s:buflist_ext{j + 1} = tmp

				let n = s:buflist_num{j}
				let s:buflist_num{j} = s:buflist_num{j + 1}
				let s:buflist_num{j + 1} = n

				let f = 0
			endif
			let j = j + 1
		endwhile
	endwhile
endfunction

function! s:BufList_UnHide()
	if(-1 == bufwinnr(s:buflist_bufwin))
		execute "topleft vertical sb " . s:buflist_bufwin
		execute "vertical resize " . s:buflist_columns
		execute "set columns+=" . s:buflist_columns
	endif
	execute bufwinnr(s:buflist_bufwin) . "wincmd w"
	return 0
endfunction

function! s:BufList_CreatePanel()
	topleft vnew
	
	let s:buflist_columns = 30
	let s:buflist_help    = 0
	let s:buflist_bufwin  = bufnr("%")
	let s:buflist_path    = 0
	let s:buflist_sort    = 0
	
	execute "vertical resize " . s:buflist_columns
	execute "set columns+=" . s:buflist_columns
	
	set buftype=nofile
	set noswapfile
	set nobuflisted
	set ft=vim
	file __BufList__

	nmap <silent> <buffer> q :close<CR>
	nmap <silent> <buffer> h :call BufList_ToggleHelp()<CR>
	nmap <silent> <buffer> p :call BufList_Preview()<CR>
	nmap <silent> <buffer> d :call BufList_Delete()<CR>
	nmap <silent> <buffer> u :call BufList_Update()<CR>
	nmap <silent> <buffer> n :call BufList_EditNew(0)<CR>
	nmap <silent> <buffer> N :call BufList_EditNew(1)<CR>
	nmap <silent> <buffer> x :call BufList_TogglePath()<CR>
	nmap <silent> <buffer> s :call BufList_ToggleSort()<CR>
	nmap <silent> <buffer> <CR> :call BufList_Edit()<CR>
	nmap <silent> <buffer> <F4> :call BufList_GoAway()<CR>
	nmap <silent> <buffer> <S-F3> :call BufList_Decrease(1)<CR>
	nmap <silent> <buffer> <S-F4> :call BufList_Increase(1)<CR>
	nmap <silent> <buffer> <C-S-F3> :call BufList_Decrease(5)<CR>
	nmap <silent> <buffer> <C-S-F4> :call BufList_Increase(5)<CR>

	nmap <silent> <buffer> <Leader><Leader>0 :call BufList_EditIn(0)<CR>
	nmap <silent> <buffer> <Leader><Leader>1 :call BufList_EditIn(1)<CR>
	nmap <silent> <buffer> <Leader><Leader>2 :call BufList_EditIn(2)<CR>
	nmap <silent> <buffer> <Leader><Leader>3 :call BufList_EditIn(3)<CR>
	nmap <silent> <buffer> <Leader><Leader>4 :call BufList_EditIn(4)<CR>
	nmap <silent> <buffer> <Leader><Leader>5 :call BufList_EditIn(5)<CR>
	nmap <silent> <buffer> <Leader><Leader>6 :call BufList_EditIn(6)<CR>
	nmap <silent> <buffer> <Leader><Leader>7 :call BufList_EditIn(7)<CR>
	nmap <silent> <buffer> <Leader><Leader>8 :call BufList_EditIn(8)<CR>
	nmap <silent> <buffer> <Leader><Leader>9 :call BufList_EditIn(9)<CR>
	nmap <silent> <buffer> <Leader><Leader>p :call BufList_EditIn(10)<CR>

	return 1
endfunction

function! s:BufList_SelectedNr()
	let line = getline(".")
    let val  = strpart(line, 0, match(getline("."), ":")) + 0
	return val
endfunction

function! s:BufList_SelectedName()
	let nr = s:BufList_SelectedNr()
	return nr > 0 ? bufname(nr) : ""
endfunction

function! s:BufList_IamSoLonely()
	let i = 1
	let n = 0

	while i <= bufnr("$")
		if (bufexists(i) && bufwinnr(i) != -1)
			let n = n + 1
		endif
		let i = i + 1
	endwhile

	if (n == 1)
		quit
	endif
endfunction

" vim:ts=4:sw=4

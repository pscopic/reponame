"--------------------------------------------------------------------------
"
" Vim script to launch/control browsers.
"
" Currently supported browsers:
"  - Firefox  (remote [new window / new tab] / launch)  [1]
"  - Seamonkey  (remote [new window / new tab] / launch)  [1]
"  - Opera    (remote [new window / new tab] / launch)
"  - elinks     (Under the current TTY if not running the GUI, or a new urxvt
"              window if DISPLAY is set.)
"
" TODO:
"
"  Support more browsers?
"   - links  (text browser)
"   - w3m    (text browser)
"
"  If I support multiple text browsers, defaulting to elinks if the the GUI
"  isn't available may be undesirable.
"
"  Note: Various browsers such as galeon, nautilus, phoenix, &c use the
"  same HTML rendering engine as seamonkey/firefox, so supporting them isn't
"  as important.
"
"
"  BUGS:
"  * [1] The remote control for firefox/seamonkey/netscape will probably
"    default to firefox if more than one is running.
"
"  * Since the commands to start the browsers are run in the backgorund
"    there's no way to actually get v:shell_error, so execution errors
"    aren't actually seen when not issuing a command to an already running
"    browser.
"
"  * The code is a mess.  Oh well.
"
"--------------------------------------------------------------------------


if exists("*LaunchBrowser")
	finish
endif

let s:BrowsersExist = ''
let s:FirefoxPath = system("which firefox")
if v:shell_error == 0
	let s:BrowsersExist = s:BrowsersExist . 'f'
else
	unlet s:FirefoxPath
endif
let s:SeamonkeyPath = system("which seamonkey")
if v:shell_error == 0
	let s:BrowsersExist = s:BrowsersExist . 'm'
else
	unlet s:SeamonkeyPath
endif
let s:elinksPath = system("which elinks")
if v:shell_error == 0
	let s:BrowsersExist = s:BrowsersExist . 'l'
else
	unlet s:elinksPath
endif

let s:NetscapeRemoteCmd = system("which netscape-remote")
if v:shell_error != 0
	if exists('s:FirefoxPath')
		let s:NetscapeRemoteCmd = s:FirefoxPath
	elseif exists('s:SeamonkeyPath')
		let s:NetscapeRemoteCmd = s:SeamonkeyPath
	else
		"echohl ErrorMsg
		"echomsg "Can't set up remote-control preview code.\n(netscape-remote/firefox/Seamonkey/netscape not installed?)"
		"echohl None
		"finish
		let s:NetscapeRemoteCmd = 'false'
	endif
endif
let s:NetscapeRemoteCmd = substitute(s:NetscapeRemoteCmd, "\n$", "", "")


" Usage:
"  :call LaunchBrowser({[nolsf]},{[012]})
"    The first argument is which browser to launch:
"      f - Firefox
"      s - Seamonkey
"      n - Netscape
"      o - Opera
"      l - elinks
"    The second argument is whether to launch a new window:
"      0 - No
"      1 - Yes
"      2 - New Tab (or new window if the browser doesn't provide a way to
"                   open a new tab)
"
" Return value:
"  0 - Failure (No browser was launched/controlled.)
"  1 - Success
"
" A special case of no arguments returns a character list of what browsers
" were found.
function! LaunchBrowser(...)

	if a:0 == 0
		return s:BrowsersExist
	elseif a:0 == 2
		let which = a:1
		let new = a:2
	else
		echohl ErrorMsg
		echomsg 'E119: Wrong number of arguments for function: LaunchBrowser'
		echohl None
		return 0
	endif

	let file = expand("%:p")

	if ((! strlen($DISPLAY)) || which ==? 'l' )

		if s:BrowsersExist !~? 'l'
			echohl ErrorMsg | echomsg "elinks isn't found in $PATH." | echohl None
			return 0
		endif

		echohl Todo | echo "Launching elinks..." | echohl None

		if (has("gui_running") || new) && strlen($DISPLAY)
			call system("urxvt -T elinks -e elinks " . file . " &")

			if shell_error
				echohl ErrorMsg | echo "Unable to launch elinks in an urxvt." | echohl None
				return 0
			endif
		else
			sleep 1
			execute "!elinks " . file

			if shell_error
				echohl ErrorMsg | echo "Unable to launch elinks." | echohl None
				return 0
			endif
		endif

		return 1
	endif


	if (which ==? 'o')

		if s:BrowsersExist !~? 'o'
			echohl ErrorMsg | echomsg "Opera isn't found in $PATH." | echohl None
			return 0
		endif

		if new == 2
			echohl Todo | echo "Opening new Opera tab..." | echohl None
			call system("sh -c \"trap '' HUP; opera -remote 'openURL(file://" . file . ",new-page)' &\"")

			if shell_error
				echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
				return 0
			endif
		elseif new
			echohl Todo | echo "Opening new Opera window..." | echohl None
			call system("sh -c \"trap '' HUP; opera -remote 'openURL(file://" . file . ",new-window)' &\"")

			if shell_error
				echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
				return 0
			endif
		else
			echohl Todo | echo "Sending remote command to Opera..." | echohl None
			call system("sh -c \"trap '' HUP; opera " . file . " &\"")

			if shell_error
				echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
				return 0
			endif
		endif

		return 1
	endif

	let windows = system("xwininfo -root -children | egrep \"[Ff]irefox|[Nn]etscape|[Ss]eamonkey\"; return 0")
	if windows =~? 'firefox'
		let FirefoxRunning = 1
	else
		let FirefoxRunning = 0
	endif
	if windows =~? 'Seamonkey'
		let SeamonkeyRunning = 1
	else
		let SeamonkeyRunning = 0
	endif

	if (which ==? 'f')

		if s:BrowsersExist !~? 'f'
			echohl ErrorMsg | echomsg "Firefox isn't found in $PATH." | echohl None
			return 0
		endif

		if ! FirefoxRunning
			echohl Todo | echo "Launching firefox, please wait..." | echohl None
			call system("sh -c \"trap '' HUP; firefox " . file . " &\"")

			if shell_error
				echohl ErrorMsg | echo "Unable to launch firefox." | echohl None
				return 0
			endif
		else
			if new == 2
				echohl Todo | echo "Firefox is running, opening new tab..." | echohl None
				call system(s:NetscapeRemoteCmd . " -remote \"openURL(file://" . file . ",new-tab)\"")

				if shell_error
					echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
					return 0
				endif
			elseif new
				echohl Todo | echo "Firefox is running, opening new window..." | echohl None
				call system(s:NetscapeRemoteCmd . " -remote \"openURL(file://" . file . ",new-window)\"")

				if shell_error
					echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
					return 0
				endif
			else
				echohl Todo | echo "Firefox is running, issuing remote command..." | echohl None
				call system(s:NetscapeRemoteCmd . " -remote \"openURL(file://" . file . ")\"")

				if shell_error
					echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
					return 0
				endif
			endif
		endif

		return 1
	endif

	if (which ==? 's')

		if s:BrowsersExist !~? 'm'
			echohl ErrorMsg | echomsg "Seamonkey isn't found in $PATH." | echohl None
			return 0
		endif

		if ! SeamonkeyRunning
			echohl Todo | echo "Launching Seamonkey, please wait..." | echohl None
			call system("sh -c \"trap '' HUP; Seamonkey " . file . " &\"")

			if shell_error
				echohl ErrorMsg | echo "Unable to launch Seamonkey." | echohl None
				return 0
			endif
		else
			if new == 2
				echohl Todo | echo "Seamonkey is running, opening new tab..." | echohl None
				call system(s:NetscapeRemoteCmd . " -remote \"openURL(file://" . file . ",new-tab)\"")

				if shell_error
					echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
					return 0
				endif
			elseif new
				echohl Todo | echo "Seamonkey is running, opening new window..." | echohl None
				call system(s:NetscapeRemoteCmd . " -remote \"openURL(file://" . file . ",new-window)\"")

				if shell_error
					echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
					return 0
				endif
			else
				echohl Todo | echo "Seamonkey is running, issuing remote command..." | echohl None
				call system(s:NetscapeRemoteCmd . " -remote \"openURL(file://" . file . ")\"")

				if shell_error
					echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
					return 0
				endif
			endif
		endif

		return 1
	endif

	echohl ErrorMsg | echo "Unknown browser ID." | echohl None
	return 0
endfunction

" vim: set ts=2 sw=2 ai nu tw=75 fo=croq2:

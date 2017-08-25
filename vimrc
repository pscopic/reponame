""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"[_Configuration file for VIM 8.0_]
"##################################
set runtimepath=/home/jboo/.vim,/usr/share/vim/vim80,/home/jboo/.vim/after,/home/jboo/.vim/autoload
":MatchDebug
" CTRL-U stop once at start of insert
syntax on
filetype plugin indent on
:let &ro = &ro
" Always change tabs to spaces in all edited files
:1,$retab!
"######################################################################################
"                                 ________________________________
"  flags                         |      Format Options           |
"  #####                         #################################
"a	Automatically format paragraphs.  Reformat each time text is added or removed.
"Caveat: When the 'c' flag is present this only happens for recognized comments.
"B	When joining, don't insert space between two multi-byte characters.
"Caveat: Overruled by the 'M' flag.
"b	Like 'v' but only autowrap if blank entered @ or before margin.
"       On start of insert, if line was longer than 'textwidth' or blank not
"       entered before reaching 'textwidth', vim does not autowrap.
"c	Autowrap comments using textwidth, auto inserting comment leader
"l	Long lines aren't broken in insert mode.  Insert mode: When line longer
"       than 'textwidth', will not autoformat
"M	When joining, don't insert space before or after multi-byte character.
"       Overrules the 'B' flag.
"m	Also break at multi-byte character above 255. (Primarily for Asian)
"n *    Recognize # lists.  Uses 'formatlistpat' options so any kind of list
"       can be used.  The indent of text after number is used for the next line.
"       Default: finds a number, optionally be followed by '.', ':', ')', ']' or '}'.
"	Example: >
"		1. the first item
"		   wraps
"		2. the second item
"Caveat: Doesn't work well together with "2".
"o	Insert current comment leader after hitting 'o' or 'O' in Normal mode.
"q	Allow formatting of comments with "gq".
"Caveat: Will not change blank lines or lines with only comment leader.  New
"i      paragraph starts after or when comment leader changes.
"r      Automatically insert the current comment leader after hitting <Enter> in
"       Insert mode. (Keyish)
"t      Auto-wrap text using textwidth.
"w	Trailing white space shows paragraph continues.  No ws means end of paragraph.
"v      Vi-compatible auto-wrapping in insert mode: Break line at blanks only
"       entered during current insert command.
"Caveat: Not 100% Vi compatible.  "unexpected features" like using screen
"       column instead of line column
"1	Don't break line after a one-letter word.  It will break before it if possible.
"2  *   When formatting, use indent of second line to indent  remaining paragraph.
"       Works also when 1st line has different indent than rest.
"	Example: >
"			first line of a paragraph
"		second line of the same paragraph
"		third line.
" Legend
" *     Note that 'autoindent' must be set
"
"       With 't' and 'c' you can specify when Vim performs auto-wrapping:
"value	action	
" ""	no automatic formatting (you can use "gq" for manual formatting).
" "t"	auto format of text, but not comments.
" "c"	auto format for comments, but not text (good for C code).
" "tc"	auto format for text and comments.
" "tcq"	VIM default

set fo+=awr2nq  " a:Auto reformat paragraphs,
                " w:Trailing ws means paragraph continues
                " r:Auto insert comment after <enter>
                " 2:Use 2nd line indent
                " n:recognize lists
                " t:autowrap text w/textwidth,
                " c:autowrap comments using textwidth, q:allow formatting using 'gq'
                " q: allow 'gq'
" set fo=ar2ncq This format option better used with C Code sans t flag
" set fo=croq For C Code, only format comments.
" set fo=tcrq Mail/News, format all, don't start comment with o command
" set fo=aw2tq a:auto reformat paragraphs, w:Trailing ws means paragraph continues 2:Use 2nd line indent, t:autoform text not comments, q: allow 'gq'
                " Makes indents like this:
                " bla bla foobar bla
                " bla foobar bla foobar bla
                " bla bla foobar bla
                " bla foobar bla bla foobar

set cpo+=L      " Compatible Options (Vimdefault:aABceFs) When list option set
                " 'wrapmargin', 'textwidth', and 'softtabstop' count tab as 2
                " chars

"_____________________________________
"|Required settings for formatoptinos|
"#####################################
set autoindent  " Required for formatoptions
set smartindent " Testing this out
set textwidth=0 " Wrap lines by default 79 or width of screen if smaller
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"_________________________________
"|The rest of the mess of options|
"#################################
set autowriteall                      " Automatically save before commands like :next and :make
set background=dark
set backspace=indent,eol,start        " Allow backspacing over autoindent,eol,start of insert
set backup
set bdir=~/.backup
set comments=://,b:#,:!,n:>,fb:-,fb:*
set expandtab                         " Use space instead of realtab
set formatprg=par
set hid                               " This is for setting hidden so when you bail on a file the buffer hides
set history=50                        " keep 50 lines of command line history
set hlsearch
set ignorecase                        " Do case insensitive matching
set incsearch                         " Incremental search
set laststatus=2                      " When last window will have statusline 0=never,1=only >2 winds,2=always
set linebreak                         " Wrap words by default
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"________________
"|Mouse Behavior|
set mouse=a
set mousef                  " window mouse is on is auto-focused
set mousemodel=popup_setpos
set mousehide               " Hide mouse pointer during keyboard use
set mouseshape=c:pencil,ci:pencil,cr:pencil,e:question,i:beam,m:no,r:beam,s:updown,sd:udsizing,ml:up-arrow,v:rightup-arrow,vs:leftright,vd:lrsizing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nrformats=alpha,hex     " CTRL-A, CTRL-X to add to alphabetic list automatically or convert on the spot to hex.
set rulerformat=%-99(%F\ %m%y%{VarExists('b:gzflag','\ [GZ]')}\ {%{GetColorSyntaxName()}}%=\ line\ %l,column\ %-6(%c%V%)\ %20*%p%%%)
set shiftwidth=4            " Number of steps with each autoindent
set showcmd                 " Show (partial) command in status line.
set showmatch               " Show matching brackets.
set smartcase               " Set smart by recognizing all upper case
set smarttab                " Uses shiftwidth,tabstop,and softtabstop
set smd                     " Set showmode
set softtabstop=2
set ssop=unix,slash,options " Session Options
set tabstop=8
set title
set titlestring=%<%F%=%l/%L-%P  " Set tab title to opened file
"set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set titlelen=70
set verbose=0
set virtualedit=all         " FREEDOM of the cursor to ROAM!!!
set winaltkeys=no
set wrap                    " Wrap lines from outset
set wrapscan                " Searches wrap around EOF
set writeany                " allows writing without the ! sign
set writebackup             " Backup before overwriting file and remove after success

                            " Non Options
set nowildmenu              " Provides menu completions when hitting tab after a letter
set nocp                    " Not compatible with vi

"___________________________________________
"|keyish so helpwindow will appear to right|
set splitright
set eadirection=ver

" prevent annoying beeps!
set vb t_vb=

" startup profile at login generation of ET
":profile start ~/.vim/macros/startup_profile.vim
" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"------------------
"[_PLUGINS_GALORE_]    Customize variables from plugin scripts
"##################

let no_buffers_menu = 1
" Align numbers using \anum USA style
let g:alignmaps_usanumber=1

" Backup directory

" handle elinks inc source files as c
let g:filetype_inc = 'c'

" engspchk.vim
let g:spchkmouse   = 1
let g:spchkautonext= 1
let g:spchkdialect = "usa"

" getscriptPlugin.vim
let g:GetLatestVimScripts_allowautoinstall=0

" turn stupid folding off
let g:xml_syntax_folding = 0

" Extended TCL syntax
let tcl_extended_syntax=1

" Have help page open in vertical window
let g:manpageview_winopen="vsplit"

" EnhancedCommentify.vim
let g:EnhCommentifyUseAltKeys      = 'Y'
let g:EnhCommentifyTraditionalMode = 'N'
let g:EnhCommentifyRespectIndent   = 'Y'
let g:EnhCommentifyPretty          = 'Y'
let g:EnhCommentifyUseBlockIndent  = 'Y'
let g:EnhCommentifyAlignRight      = 'Y'
let g:EnhCommentifyUseSyntax       = 'Y'

" bashsupport variables
let g:BASH_AuthorName   = 'Arias D Hung'
let g:BASH_AuthorRef    = 'WA'
let g:BASH_Email        = 'arias@m-a-g.net'
let g:BASH_Company      = 'Media Access Guard'

" Creating Vim Templates"
let b:match_words = '\<if\>:\<endif\>,<:>,<tag>:</tag>,\<while\>:\<continue\>:\<break\>:\<endwhile\>'

""let %ro = %ro

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is necessary to move cursor to remembered position on file opening

augroup vimrcEx
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
augroup END


" Set paper size from /etc/papersize if available (Debian-specific)
if filereadable("/etc/papersize")
  try
    let s:shellbak = &shell
    let &shell="/bin/sh"
    let s:papersize = matchstr(system("cat /etc/papersize"), "\\p*")
    let &shell=s:shellbak
    if strlen(s:papersize)
      let &printoptions = "paper:" . s:papersize
    endif
  catch /^Vim\%((\a\+)\)\=:E145/
  endtry
endif

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
:map #4 :let gw=current("column")-1,columns

let g:C_AuthorName      = 'Arias Hung'
let g:C_AuthorRef       = 'Ydef'
let g:C_Email           = 'arias@m-a-g.net'
let g:C_Company         = 'Media Access Group'

function VarExists(var, val)
  if exists(a:var) | return a:val | else | return '' | endif
endfunction

"______________________
"[_TERMINAL CRAZINESS_]

" `Gnome Terminal' fortunately sets $COLORTERM; it needs <BkSpc> and <Del>
" fixing, and it has a bug which causes spurious "c"s to appear, which can be
" fixed by unsetting t_RV:
if $COLORTERM == 'gnome-terminal'
  execute 'set t_kb=' . nr2char(8)
  set t_Co=256
  fixdel
" rxvt-unicode fortunately sets $TERM to rxvt-unicode
elseif &term == 'rxvt-unicode'
  set t_kb=
  fixdel
  set t_Co=256
  set ttym=xterm2
  "Mrxvt uses rxvt-256color
elseif &term == 'rxvt-unicode-256color'
      set t_Co=256
      set ttym=urxvt
      fixdel
      runtime! syntax/cterm.vim
      "set encoding=iso8859
" `XTerm', `Konsole', and `KVT' all also need <BkSpc> and <Del> fixing;
" there's no easy way of distinguishing these terminals from other things
" that claim to be "xterm", but `RXVT' sets $COLORTERM to "rxvt" and these
" don't:
elseif &term =~ "linux"
      execute 'set t_kb='
      fixdel
          highlight Normal ctermfg=grey ctermbg=darkblue
          set t_Co=8
          runtime! syntax/cterm.vim
          let g:colors_name = "manxome"
"     echo "the terminal &type is linux"
elseif &term == "xterm-256color"
    set t_Co=256
    set ttym=xterm2
    runtime! syntax/cterm.vim
    :hi Function cterm=bold
    fixdel
"     echo "the terminal &type is xterm-color"
elseif &term == 'konsole-256color'
    set t_Co=256
    set ttym=xterm2
    runtime! syntax/cterm.vim
    :hi Function cterm=bold
    fixdel
else
      set t_kb=
      set t_Co=256
      fixdel
      set ttym=xterm2
      runtime! syntax/cterm.vim
      echo "the terminal type &term is not recognized by your vimrc script!"
" The above won't work if an `XTerm' or `KVT' is started from within a `Gnome
" Terminal' or an `RXVT': the $COLORTERM setting will propagate; it's always
" OK with `Konsole' which explicitly sets $COLORTERM to "".
endif

"[_TERMINAL CRAZINESS ENDS_]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"###############################
" MY PERSONAL CUSTOM SHORTCUTS #
"###############################
"
" MAPPING MODES
" map  = normal,visual,operator pending
" vmap = visual
" nmap = normal
" omap = operator pending
" map! = insert and commandline
" imap = insert
" cmap = commandline
"-------------------------------------------------------------------------

"[-- FUNCTION BUTTONS F1-F12 --]   Specific to customization of Microsoft
"[-- SPECIAL FLOCK ON  --]         Ergonomic Keyboard 4000 (msnek4k)
" Help Key
imap            <F1> <Esc>:vertical :help<CR>
" Undo Key
nmap            <F2> u
" Redo Key
nmap            <F3> <C-r>
" Open Key, Taglist Toggle
nmap            <F4> :TlistToggle<CR>
" <F5>/Open Stub mapped in lookupfile.vim
" Close Key
nmap            <F6> :q!<CR>
" Reply Key
nmap            <F7> :set invspell!<CR>
" Fwd Key
nmap            <F8> :set invwrap!<CR>
" <F9>/Send Key Stub
" Spell Key
nmap            <F10> :setlocal spell spelllang=en<CR>
set pastetoggle=<F11>   "Save Key (does not work in commandline mode)
" Print Key reveals ^ and $ linepositions
nmap            <F12> :set invlist!<CR>
" Enter key extinguishes highlighted text
nnoremap <CR> :nohlsearch<CR>/<BS><CR>

"[-- LABELED FUNCTION BUTTONS  --]    Only discovered these two buttons work
"[-- SPECIAL FLOCK OFF  --]           with FLOCK OFF
map             <Redo> <C-r>
map             <Undo> u

"[--SHORTCUTS TO FUNCTIONS FROM changeColorScheme.vim plugin --]
map <Home> :call NextColorScheme()<CR>
map <End> :call PreviousColorScheme()<CR>
map <KP_Begin> :call RandomColorScheme()<CR>

"[--SHORTCUTS for multiple windows when using vimdiff --]
" Alt-X next,prev,up,down window
map <xRight> :wincmd l<CR>
map <xLeft> :wincmd h<CR>
map <xUp> :wincmd k<CR>
map <xDown> :wincmd j<CR>

"[--SHORTCUTS Quick and Dirty--]
nmap zz :w!<cr>
nmap ,, :x!<cr>
nmap q :q!<cr>
nmap <space> <C-f>
nmap B <C-b>
"Show line numbers w/two taps to pound key.
nmap ## <Esc>:let &number=1-&number<CR>
"nmap '#' Set by default highlights all instances of string under cursor)

" tabs
map <LocalLeader>tc :tabnew %<cr>    " create a new tab
map <LocalLeader>td :tabclose<cr>    " close a tab
map <LocalLeader>tn :tabnext<cr>     " next tab
map <LocalLeader>tp :tabprev<cr>     " previous tab
map <LocalLeader>tm :tabmove         " move a tab to a new location

"[--ABBREVIATIONS require hitting enter after for full command to appear --]
abbr vhe vertical help

"_________________________________________________________
" viminfo is set in autoload/genutils.vim                |
" '20 Marks remebered in last 20 files edited            |
" <500 Contents of registers up to 1000 lines each       |
" s50 Registers with more than 50kb are skipped          |
" h disable effect of 'hlsearch' when loading viminfo    |
" :50 Max # of commandline history to save               |
" c convert viminfo file to right character encoding
"#########################################################
" n~/.viminfo sets path/name to store values
set viminfo='1000,f1,<500,s50,:500,h,c
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set behavior for mouse and selection (xterm or mswin)
:behave xterm
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:colo inkpot
" Automatically save and restore views for specific files:
"au BufWinLeave *.{c,h,cc,cpp,cxx,pl,txt,conf,xbel,sh,vim,patch,html,opml,xml} mkview
"au BufWinEnter *.{c,h,cc,cpp,cxx,pl,txt,conf,xbel,sh,vim,patch,html,opml,xml} silent loadview
"              _____
"              |EOF|
"              #####

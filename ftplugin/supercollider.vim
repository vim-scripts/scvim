"SuperCollider/Vim interaction scripts
"Copyright 2007 Alex Norman
"
"This file is part of SCVIM.
"
"SCVIM is free software: you can redistribute it and/or modify
"it under the terms of the GNU General Public License as published by
"the Free Software Foundation, either version 3 of the License, or
"(at your option) any later version.
"
"SCVIM is distributed in the hope that it will be useful,
"but WITHOUT ANY WARRANTY; without even the implied warranty of
"MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"GNU General Public License for more details.
"
"You should have received a copy of the GNU General Public License
"along with SCVIM.  If not, see <http://www.gnu.org/licenses/>.

"au VimLeave

if exists("$SCVIM_DIR") == 0
	echo "$SCVIM_DIR must be defined for SCVIM to work"
	finish
endif

if exists("loaded_scvim") || &cp
  finish
endif
let loaded_scvim = 1

so $SCVIM_DIR/syntax/supercollider.vim

if exists("g:sclangKillOnExit")
	let s:sclangKillOnExit = g:sclangKillOnExit
else
	let s:sclangKillOnExit = 1
endif

if exists("g:sclangPipeLoc")
	let s:sclangPipeLoc = g:sclangPipeLoc
else
	let s:sclangPipeLoc = "/tmp/sclang-pipe"
endif
let $SCVIM_PIPE_LOC = s:sclangPipeLoc

if exists("g:sclangPipeAppPidLoc")
	let s:sclangPipeAppPidLoc = g:sclangPipeAppPidLoc
else
	let s:sclangPipeAppPidLoc = "/tmp/sclangpipe_app-pid"
endif
let $SCVIM_PIPE_PID_LOC = s:sclangPipeAppPidLoc

if exists("g:sclangTerm")
	let s:sclangTerm = g:sclangTerm
else
	let s:sclangTerm = "xterm -e"
endif

if exists("g:sclangPipeApp")
	let s:sclangPipeApp	= g:sclangPipeApp
else
	let s:sclangPipeApp	= "$SCVIM_DIR/bin/sclangpipe_app.sh"
endif

"function SClangRunning()
"	if s:sclang_pid != 0 && `pidof "#{$sclangsclangPipeApp_no_quotes}"`.chomp != ""
"		return true
"	else
"		$sclang_pid = 0
"		return false
"	end
"end


function! FindOuterMostBlock()
	"search backwards for parens dont wrap
	let l:search_expression_up = "call searchpair('(', '', ')', 'bW'," .
		\"'synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scComment\" || " .
		\"synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scString\" || " .
		\"synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scSymbol\"')"
	"search forward for parens, don't wrap
	let l:search_expression_down = "call searchpair('(', '', ')', 'W'," .
		\"'synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scComment\" || " .
		\"synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scString\" || " .
		\"synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scSymbol\"')"

	"save our current cursor position
	let l:returnline = line(".")
	let l:returncol = col(".")
	
	"if we're on an opening paren then we should actually go to the closing one to start the search
	"if buf[l:returnline][l:returncol-1,1] == "("
	if strpart(getline(line(".")),col(".") - 1,1) == "("
		exe l:search_expression_down
	endif

	let l:origline = line(".")
	let l:origcol = col(".")

	"these numbers will define our range, first init them to illegal values
	let l:range_e = [-1, -1]
	let l:range_s = [-1, -1]

	"this is the last line in our search
	let l:lastline = line(".")
	let l:lastcol = col(".")

	exe l:search_expression_up

	while line(".") != l:lastline || (line(".") == l:lastline && col(".") != l:lastcol)
		"keep track of the last line/col we were on
		let l:lastline = line(".")
		let l:lastcol = col(".")
		"go to the matching paren
		exe l:search_expression_down

		"if there isn't a match print an error
		if l:lastline == line(".") && l:lastcol == col(".")
			call cursor(l:returnline,l:returncol)
			throw "UnmachedParen at line:" . l:lastline . ", col: " . l:lastcol
		endif

		"if this is equal to or later than our original cursor position
		if line(".") > l:origline || (line(".") == l:origline && col(".") >= l:origcol)
			let l:range_e = [line("."), col(".")]
			"go back to opening paren
			exe l:search_expression_up
			let l:range_s = [line("."), col(".")]
		else
			"go back to opening paren
			exe l:search_expression_up
		endif
		"find next paren (if there is one)
		exe l:search_expression_up
	endwhile

	"restore the settings
	call cursor(l:returnline,l:returncol)

	if l:range_s[0] == -1 || l:range_s[1] == -1
		throw "OutsideOfParens"
	endif
	
	"return the ranges
	 return [l:range_s, l:range_e]
endfunction


"this causes the sclang pipe / terminal app to be killed when you exit vim, if you don't
"want that to happen then just comment this out
if !exists("loaded_kill_sclang")
	if s:sclangKillOnExit
		au VimLeave * call SClangKill()
	endif
	let loaded_kill_sclang = 1
endif

"the vim version of SendToSC
function SendToSC(text)
	let l:text = substitute(a:text, '\', '\\\\', 'g')
	let l:text = substitute(l:text, '"', '\\"', 'g')
	let l:cmd = system('echo "' . l:text . '" >> ' . s:sclangPipeLoc)
	"let l:cmd = system('echo "' . l:text . '" >> /tmp/test')
endfunction

function SendLineToSC(linenum)
	let cmd = a:linenum . "w! >> " . s:sclangPipeLoc
	silent exe cmd
	"let cmd = a:linenum . "w! >> /tmp/test" 
	"silent exe cmd
endfunction

function! SClang_send()
	let cmd = ".w! >> " . s:sclangPipeLoc
	exe cmd
	if line(".") == a:lastline
		call SendToSC('')
		"redraw!
	endif
endfunction

function SClangStart()
	if !filewritable(s:sclangPipeAppPidLoc)
		call system(s:sclangTerm . " " . s:sclangPipeApp . "&")
	else
		throw s:sclangPipeAppPidLoc . " exists, is " . s:sclangPipeApp . " running?  If not try deleting " . s:sclangPipeAppPidLoc
	endif
endfunction

function SClangKill()
	if filewritable(s:sclangPipeAppPidLoc)
		call system("kill `cat " . s:sclangPipeAppPidLoc . "` && rm " . s:sclangPipeAppPidLoc . " && rm " . s:sclangPipeLoc)
	end
endfunction

function SClangRestart()
	call SClangKill()
	call SClangStart()
endfunction

function SClang_free(server)
	call SendToSC('s.freeAll;')
	redraw!
endfunction

function SClang_thisProcess_stop()
	call SendToSC('thisProcess.stop;')
	redraw!
endfunction

function SClang_TempoClock_clear()
	call SendToSC('TempoClock.default.clear;')
	redraw!
endfunction

function! SClang_block()
	let [blkstart,blkend] = FindOuterMostBlock()
	"blkstart[0],blkend[0] call SClang_send()
	"these next lines are just a hack, how can i do the above??
	let cmd = blkstart[0] . "," . blkend[0] . " call SClang_send()"
	let l:origline = line(".")
	let l:origcol = col(".")
	exe cmd
	call cursor(l:origline,l:origcol)
	
	""if the range is just one line
	"if blkstart[0] == blkend[0]
	"	"XXX call SendToSC(strpart(getline(blkstart[0]),blkstart[1] - 1, (blkend[1] - blkstart[1] + 1)))
	"	call SendLineToSC(blkstart[0])
	"else
	"	let linen = blkstart[0] - 1
	"	"send the first line as it might not be a full line
	"	"XXX let line = getline(linen)
	"	"XXX call SendToSC(strpart(line, blkstart[1] - 1))
	"	call SendLineToSC(linen)
	"	let linen += 1
	"	let endlinen = blkend[0]
	"	while linen < endlinen
	"		"XXX call SendToSC(getline(linen))
	"		call SendLineToSC(linen)
	"		let linen += 1
	"	endwhile
	"	"send the last line as it might not be a full line
	"	"XXX let line = getline(endlinen)
	"	"XXX call SendToSC(strpart(line,0,blkend[1]))
	"	call SendLineToSC(endlinen)
	"endif
	"call SendToSC('')
endfunction

function SCdef(subject)
	let l:dontcare = system("grep SCDEF:" . a:subject . " $SCVIM_DIR/TAGS_SCDEF > $SCVIM_DIR/doc/tags")
	exe "help SCdef:" . a:subject
endfun

"function SCbrowse(dir)
"	if a:dir == ""
"		let l:dontcare = system("grep \"SCB:Top\" $SCVIM_DIR/doc/TAGS_BROWSER > $SCVIM_DIR/doc/tags")
"		exe "help SCB:Top"
"	else
"		let l:dontcare = system("grep SCB:\"" . a:dir . "\" $SCVIM_DIR/doc/TAGS_BROWSER > $SCVIM_DIR/doc/tags")
"		exe "help SCB:" . a:dir
"	end
"endfun

function SChelp(subject)
	"if we're in the help browser do something different
	if a:subject =~ "|$"
		let l:dir = substitute(a:subject, '|', '', 'g')
		call SCbrowse(l:dir)
	"the keybindings won't find * but will find ** for some reason
	elseif a:subject == ""
		let l:dontcare = system("grep \"SC:Help\" $SCVIM_DIR/doc/TAGS_HELP > $SCVIM_DIR/doc/tags")
		exe "help SC:Help"
	elseif a:subject == "*"
		let l:dontcare = system("grep \"SC:\\*\" $SCVIM_DIR/doc/TAGS_HELP > $SCVIM_DIR/doc/tags")
		exe "help SC:\*" . a:subject
	elseif a:subject == "**"
		let l:dontcare = system("grep \"SC:\\*\\*\" $SCVIM_DIR/doc/TAGS_HELP > $SCVIM_DIR/doc/tags")
		exe "help SC:\*\*" . a:subject
	else
		let l:dontcare = system("grep SC:\"" . a:subject . "\" $SCVIM_DIR/doc/TAGS_HELP > $SCVIM_DIR/doc/tags")
		exe "help SC:" . a:subject
	endif
endfun

function ListSCObjects(A,L,P)
	return system("cat $SCVIM_DIR/sc_object_completion")
endfun

function ListSCHelpItems(A,L,P)
	return system("cat $SCVIM_DIR/doc/sc_help_completion")
endfun

"function ListSCBrowserItems(A,L,P)
"	return system("cat $SCVIM_DIR/doc/sc_browser_completion")
"endfun

"custom commands (SChelp,SCdef,SClangfree)
com -complete=custom,ListSCHelpItems -nargs=? SChelp call SChelp("<args>")
com -complete=custom,ListSCObjects -nargs=1 SCdef call SCdef("<args>")
"com -complete=custom,ListSCBrowserItems -nargs=? SCbrowse call SCbrowse("<args>")
com -nargs=1 SClangfree call SClang_free("<args>")
com -nargs=0 SClangStart call SClangStart()
com -nargs=0 SClangKill call SClangKill()
com -nargs=0 SClangRestart call SClangRestart()

" end supercollider.vim

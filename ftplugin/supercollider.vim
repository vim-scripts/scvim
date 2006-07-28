" By Alex Norman
" SuperCollider/Vim interaction scripts

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

"ruby definitions
ruby << EOF

#these are user editable
$sclangpipe_loc = "/tmp/sclang-pipe"
$sclang_terminal = "xterm -e"
$sclangapp = `which sclang`.chomp
$rundir = "/home/alex/music/supercollider/"

#don't edit these variables
$sclang_pid = 0
#we need to remove the quotes for when we ask for this process's pid, but the pid lookup function
#doesn't like to have the arguments, so we add the argument and the last quote after we save the
#app name and remove the quotes
$sclangpipe_app = "#{$sclang_terminal} \"while [ 1==1 ]; do cat #{$sclangpipe_loc}; done | #{$sclangapp}"
$sclangpipe_app_no_quotes = $sclangpipe_app.gsub(/"/,"")
$sclangpipe_app = "#{$sclangpipe_app} -d #{$rundir}\""
#this is the file descriptor of the pipe to sclang
$sclangpipe_ref = 0

class UnmachedParen < StandardError
	def initialize
		@message = "Error: Unmached Paren"
	end
end

class OutsideOfParens < StandardError
	def initialize
		@message = "Error: Not Inside of Parens"
	end
end

class SClangNotLaunched < StandardError
	def initialize
		@message = "Error: SClang Not Launched"
	end
end

#def InitSClang()
#	if $sclangpipe_ref != 0
#		$sclangpipe_ref.close
#	end
#	curdir = Dir.pwd
#	Dir.chdir($rundir)
#	$sclangpipe_ref = IO.popen("#{$sclangloc}", "a+")
#	Dir.chdir(curdir)
#
#	#hack for now, split the screen and load the buffer
#	VIM::command("norm :10split sclangoutput")
#	VIM::command("setlocal buftype=nofile")
#	VIM::command("setlocal noswapfile")
#	#go back to our buffer (and swap the locations)
#	VIM::command("norm x")
#
#	@sclang_output_thread = Thread.new {
#		#VIM::command("bad sclangoutput")
#		n = VIM::evaluate('bufnr("sclangoutput")').to_i
#		b = VIM::Buffer[n-1]
#		while true
#			line = $sclangpipe_ref.gets
#			#get rid of the control char at the end
#			line.chomp!
#			b.append(b.count, line)
#		end
#	}
#end

def SClangKill
	if $sclang_pid != 0
		Process.kill("SIGKILL", $sclang_pid)
		$sclang_pid = 0
	end
end

def SClangStart
	#if our sclang app is already running then we should kill it

	if $sclang_pid != 0 || `pidof "#{$sclangpipe_app_no_quotes}"`.chomp != ""
		SClangKill()
	end

	#make the pipe if we need it
	if !File.exists?($sclangpipe_loc)
		system("mkfifo #{$sclangpipe_loc}")
	elsif !File.stat($sclangpipe_loc).pipe?
		VIM::message("file exists at #{$sclangpipe_loc} that is not a pipe")	
		return
	end

	#keep the pid so that we can kill it later
	#fork a new process then exec the sclang pipe script in a terminal
	$sclang_pid = fork do
		exec($sclangpipe_app)
	end
end


def SClangRunning?
	if $sclang_pid != 0 && `pidof "#{$sclangpipe_app_no_quotes}"`.chomp != ""
		return true
	else
		$sclang_pid = 0
		return false
	end
end

def SendToSC(textosend)
	if !SClangRunning?
		throw :SClangNotLaunched
	end
#	if $sclangpipe_ref != 0
#		$sclangpipe_ref.puts textosend
#		$sclangpipe_ref.flush
#	else
#		throw :SClangNotLaunched
#	end
	f = File.open($sclangpipe_loc, File::WRONLY|File::APPEND)
	#write the text to the pipe
	f.puts textosend
	f.close
end

def currentline()
	return VIM::evaluate('line(".")').to_i
end

def currentcol()
	return VIM::evaluate('col(".")').to_i
end

def cursor(line,col)
	VIM::evaluate('cursor(' + line.to_s + ', ' + col.to_s + ')')
end

def findOuterMostBlock()

	#search backwards for parens dont wrap
	search_expression_up = "searchpair('(', '', ')', 'bW'," +
		"'synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scComment\" || " +
		"synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scString\" || " +
		"synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scSymbol\"')"
	#search forward for parens, don't wrap
	search_expression_down = "searchpair('(', '', ')', 'W'," +
		"'synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scComment\" || " +
		"synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scString\" || " +
		"synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scSymbol\"')"

	buf = VIM::Buffer.current

	#save our current cursor position
	returnline = currentline()
	returncol = currentcol()
	
	#if we're on an opening paren then we should actually go to the closing one to start the search
	if(buf[returnline][returncol-1,1] == "(")
		VIM::evaluate(search_expression_down)
	end

	origline = currentline()
	origcol = currentcol()

	#these numbers will define our range, first init them to illegal values
	range_e = range_s = [-1, -1]

	#this is the last line in our search
	lastline = currentline()
	lastcol = currentcol()

	VIM::evaluate(search_expression_up)

	while currentline() != lastline || (currentline() == lastline && currentcol() != lastcol)
		#keep track of the last line/col we were on
		lastline = currentline()
		lastcol = currentcol()
		#go to the matching paren
		VIM::evaluate(search_expression_down)

		#if there isn't a match print an error
		if lastline == currentline() && lastcol == currentcol()
			#restore the buffer variable match_skip
			restoreMatchitSettings(old_match_skip, old_match_words)
			cursor(returnline,returncol)
			throw :UnmachedParen
		end

		#if this is equal to or later than our original cursor position
		if currentline() > origline || (currentline() == origline && currentcol() >= origcol)
			range_e = [currentline(), currentcol()]
			#go back to opening paren
			VIM::evaluate(search_expression_up)
			range_s = [currentline(), currentcol()]
		else
			#go back to opening paren
			VIM::evaluate(search_expression_up)
		end
		#find next paren (if there is one)
		VIM::evaluate(search_expression_up)
	end

	#restore the settings
	cursor(returnline,returncol)

	throw :OutsideOfParens if range_s[0] == -1 || range_s[1] == -1
	
	#return the ranges
	return [range_s, range_e]
end

EOF

"this causes the sclang pipe / terminal app to be killed when you exit vim, if you don't
"want that to happen then just comment this out
if !exists("loaded_kill_sclang")
	au VimLeave * :ruby SClangKill()
	let loaded_kill_sclang = 1
endif

"the vim version of SendToSC
function SendToSC(text)
	ruby SendToSC(VIM::evaluate('a:text'))
endfunction

function! SClang_send()
ruby << EOF
	linenum = VIM::evaluate('line(".")').to_i
	SendToSC(VIM::Buffer.current[linenum])
	#if this is the last line in the range send the end character
	if VIM::evaluate("a:lastline").to_i == linenum
		SendToSC("")
		#if(@sclang_output_thread != nil)
		#	@sclang_output_thread.wakeup
		#end
	end
EOF
endfunction

function SClangStart()
	ruby SClangStart()
endfunction

function SClangKill()
	ruby SClangKill()
endfunction

function SClang_free(server)
	ruby SendToSC("s.freeAll;")
endfunction

function SClang_thisProcess_stop()
	ruby SendToSC("thisProcess.stop;")
endfunction

function SClang_TempoClock_clear()
	ruby SendToSC("TempoClock.default.clear;")
endfunction

function SClang_block()
ruby << EOF
	blkstart,blkend = findOuterMostBlock()

	buf = VIM::Buffer.current
	#if the range is just one line
	if blkstart[0] == blkend[0]
		SendToSC(buf[blkstart[0]][blkstart[1]-1, (blkend[1] - blkstart[1]) + 1])
	else
		linen = blkstart[0]
		#send the first line as it might not be a full line
		line = buf[linen]
		SendToSC(line[blkstart[1] - 1, line.length - blkstart[1] + 1])
		linen += 1
		endlinen = blkend[0]
		while linen < endlinen
			SendToSC(buf[linen])
			linen += 1
		end
		#send the last line as it might not be a full line
		line = buf[endlinen]
		SendToSC(line[0,blkend[1]])
	end
	SendToSC("")
EOF
endfunction

function SCdef(subject)
	let s:dontcare = system("grep SCDEF:" . a:subject . " $SCVIM_DIR/TAGS_SCDEF > $SCVIM_DIR/doc/tags")
	exe "help SCdef:" . a:subject
endfun

function SChelp(subject)
	"the keybindings won't find * but will find ** for some reason
	if a:subject == ""
		let s:dontcare = system("grep \"SC:Help\" $SCVIM_DIR/doc//TAGS_HELP > $SCVIM_DIR/doc/tags")
		exe "help SC:Help"
	elseif a:subject == "*"
		let s:dontcare = system("grep \"SC:\\*\" $SCVIM_DIR/doc/TAGS_HELP > $SCVIM_DIR/doc/tags")
		exe "help SC:\*" . a:subject
	elseif a:subject == "**"
		let s:dontcare = system("grep \"SC:\\*\\*\" $SCVIM_DIR/doc/TAGS_HELP > $SCVIM_DIR/doc/tags")
		exe "help SC:\*\*" . a:subject
	else
		let s:dontcare = system("grep SC:\"" . a:subject . "\" $SCVIM_DIR/doc/TAGS_HELP > $SCVIM_DIR/doc/tags")
		exe "help SC:" . a:subject
	endif
endfun

function ListSCObjects(A,L,P)
	return system("cat $SCVIM_DIR/sc_object_completion")
endfun

function ListSCHelpItems(A,L,P)
	return system("cat $SCVIM_DIR/doc/sc_help_completion")
endfun

"custom commands (SChelp,SCdef,SClangfree)
com -complete=custom,ListSCHelpItems -nargs=? SChelp call SChelp("<args>")
com -complete=custom,ListSCObjects -nargs=1 SCdef call SCdef("<args>")
com -nargs=1 SClangfree call SClang_free("<args>")
com -nargs=0 SClangStart call SClangStart()
com -nargs=0 SClangKill call SClangKill()

" end supercollider.vim

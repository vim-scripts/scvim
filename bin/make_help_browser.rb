#!/usr/bin/ruby

#SCvim help browser
#Copyright 2007 Alex Norman
#
#This file is part of SCVIM.
#
#SCVIM is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#SCVIM is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with SCVIM.  If not, see <http://www.gnu.org/licenses/>.

scvim_dir = ENV["SCVIM_DIR"].sub(/\/$/,"")
helpdir = File.join scvim_dir, 'doc'
browser_tags_file = File.join helpdir, "TAGS_BROWSER"
browser_completion_file = File.join helpdir, "sc_browser_completion"
browserhash = Hash.new;

$fnum = 0 #file number

def make_page(path, browserhash, basedir)
	files = Dir.entries(path)
	files.delete('.'); files.delete('..'); files.delete('.svn'); files.delete('TAGS_HELP')
	files.delete('TAGS_BROWSER'); files.delete('tags'); files.delete('sc_help_completion');
	files.delete('sc_browser_completion')
	files.sort!{|x,y| x.downcase <=> y.downcase}
	fnum = $fnum
	$fnum += 1
	File.open(File.join(path, "scvimbrowser-#{fnum}.scd"), 'w'){ |page|
		files.each{ |file|
			if file !~ /scvim.*/
				dir = File.join(path, file)
				if File.stat(dir).directory?
					#do the subdir
					file = file.gsub(/\s/, '_')
					make_page(dir, browserhash, basedir)
					val =  dir.sub(basedir,'')
					#take out leading / if there is one
					val.sub!(/^\//,'')
					browserhash[file] = File.join val, "scvimbrowser-#{fnum}.scd"
					file = '|' + file + '|'
				end
				file.sub!(/\.scd/,'');
				page.puts file
			end
		}
	}
end

#put the top level in Top
browserhash['Top'] = 'scvimbrowser-0.scd'

make_page(helpdir, browserhash, helpdir)

#open the completion file
completion = File.open(browser_completion_file, "w")
File.open(browser_tags_file, "w"){ |tags_file|
	browserhash.sort.each{|key, val|
		tags_file.puts "SCB:#{key}\t#{val}\t/^"
		completion.puts key
	}
}
completion.close

" Vim global plugin for providing templates for new files
" Licence:     The MIT License (MIT)
" Commit:      $Format:%H$
" {{{ Copyright (c) 2015 Aristotle Pagaltzis <pagaltzis@gmx.de>
" 
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
" 
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
" 
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
" }}}

if v:version < 700
	echoerr printf('Vim 7 is required for readdir (this is only %d.%d)',v:version/100,v:version%100)
	finish
endif

function! templates#load()
	let templates = split( globpath( &runtimepath, 'templates/' . &filetype ), "\n" )
	if len( templates ) == 0 | return | endif
	silent execute 1 'read' templates[0]
	1 delete _
	if search( 'cursor:', 'W' )
		let cursorline = strpart( getline( '.' ), col( '.' ) - 1 )
		let y = matchstr( cursorline, '^cursor:\s*\zs\d\+\ze' )
		let x = matchstr( cursorline, '^cursor:\s*\d\+\s\+\zs\d\+\ze' )
		let d = matchstr( cursorline, '^cursor:\s*\d\+\s\+\(\d\+\s\+\)\?\zsdel\>\ze' )
		if ! strlen( x ) | let x = 0 | endif
		if ! strlen( y ) | let y = 0 | endif
		if d == 'del' | delete _ | endif
		call cursor( y, x )
	endif
	set nomodified
endfunction

" vim:foldmethod=marker
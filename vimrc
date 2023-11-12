" sets line numbers
set nu

" tells tab to represed 4 stops
set tabstop=4

" tells tab to represent exactly 4 stops
set softtabstop=4

" >> indentation
" if same as tab stop tab stop takes over
set shiftwidth=4

" transfares indentation from current line to the next 
set autoindent

" higlihts line nubmer with cursor
set cursorline

" disable new line at the end of file
set noeol

" get rid of commenting next line (//) 
set formatoptions-=cro

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GCC Compiler plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" color variable
let g:start = "\e[91m"
let g:comp	= "COMPILING\t"
let g:end	= "\e[0m\\n"
let g:exec	= "\e[93mEXECUTING\t"
let g:done	= "\e[92mDONE\t\t"

" holds text value for gcc and g++ object or output file
" let g:objectFile = expand('%:t:r')
" :t	-> means file name (no path)
" :t:r	-> remove extension

" part for gcc compiler to shine ;) 
function Compile(compiler, ...)
	let l:valgrind="echo -n '' && "
	if exists('a:1')
		if (a:1==#"valgrind")
			let l:valgrind="echo && echo && valgrind ./a.out && "
		else
			echo "something went wrong"
			return
		endif
	endif

	let l:lineLen = 50
	let l:printLine = "'=\\%.0s' {1.."	. l:lineLen .	"}" 
	let l:wholeLine = "'=\\%.0s' {1..66}"
	let l:command = "! printf		'\\n" .  g:start	. "'" . \
			"	&& printf	'" . g:comp			. "'" .		\
			"	&& printf	" . l:printLine	. " && echo ".	\
			"	&& printf	" . l:wholeLine . " && echo " .	\
			"	&& printf	'" . g:end			. "' && echo" .	\
			"	&& " . a:compiler . " % " .				\
			"	&& printf	'" . g:exec		. "'".		\
			"	&& printf	 " . l:printLine .			\
			"	&& printf	'" . g:end		. "'" .		\
			"	&& echo && ./a.out && " . l:valgrind ." rm a.out && echo " . \
			"	&& printf	'" . g:done		. "'".		\
			"	&& printf	 " . l:printLine .			\
			"	&& printf	'" . g:end		. "\\n' "	\
			"   && [ -f *.o ] && rm *.o || echo -n"		\
	execute l:command
endfunction

" maps f2 key with compiling a c program
map <F2>	: call Compile("gcc")
map <S-F2>	: call Compile("gcc -Wall -g", "valgrind")

" maps f3 key with compiling a c++ program
map <F3>	: call Compile("g++")
map <S-F3>	: call Compile("g++ -Wall -g", "valgrind")


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" maps f4 key with shell
map <F4> :! sh %

" maps f5 key with mysql

" map <F5> :! mysql  < %

" maps f6 key with python3
map <F6> :! python3 %
" map FLTK addition
map <F7> :call FLTKCompile() 

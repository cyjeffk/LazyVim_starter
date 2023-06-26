" Vim syntax file
" This is based on spice.vim by Noam Halevy
" Language:	correct highlight cadence cds*.lib assura*.lib file
" Maintainer:	Garrett Zhou
" Last Change:  09/20/2016	
" Comments:     Add follow line into your ~/.vimrc file	
" autocmd BufNewFile,BufRead cds*.lib,assura*.lib   set syntax=cdslib
" filetype indent off

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" cdslib syntax is case INsensitive
syn case ignore
syn keyword	cdslibTodo	contained TODO
syn keyword 	cdslibStatement   DEFINE SOFTDEFINE UNDEFINE INCLUDE SOFTINCLUDE ASSIGN COMBINE DISPLAY


" Misc
"=====
syn match   cdslibWrapLineOperator       "\\$"
syn match   cdslibIgnore		  "\ \ \ "

syn match   cdslibStatement      "^ \=\.\I\+"
syn region  cdslibString	start=+L\="+ skip=+\\\\\|\\"+ end=+"+

syn region cdslibComment start="--" end="$" contains=cdslibTodo
syn region cdslibComment start="#" end="$" contains=cdslibTodo

" Matching pairs of parentheses
"==========================================
syn region  cdslibParen transparent matchgroup=cdslibOperator start="(" end=")" contains=ALLBUT,cdslibParenError
syn region  cdslibSinglequote matchgroup=cdslibOperator start=+'+ end=+'+ oneline

" Errors
"=======
syn match cdslibParenError ")"

" Syncs
" =====
syn sync minlines=50

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_cdslib_syntax_inits")
  if version < 508
    let did_cdslib_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink cdslibTodo	         Todo
  HiLink cdslibWrapLineOperator cdslibOperator
  HiLink cdslibSinglequote      cdslibExpr
  HiLink cdslibExpr             Function
  HiLink cdslibParenError       Error
  HiLink cdslibStatement        Statement
  HiLink cdslibNumber           Number
  HiLink cdslibComment          Comment
  HiLink cdslibOperator         Operator
  HiLink cdslibString           String
  HiLink cdslibKeyword          Type 
  HiLink cdslibIgnore		 Ignore

  delcommand HiLink
endif

let b:current_syntax = "cdslib"

" insert the following to $VIM/syntax/scripts.vim
" to autodetect HSpice netlists and text listing output:
"
" " Spice netlists and text listings
" elseif getline(1) =~ 'cdslib\>' || getline("$") =~ '^\.end'
"   so <sfile>:p:h/cdslib.vim

" vim: ts=8

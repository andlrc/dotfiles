" Vim syntax file
" Language:	Quickfix window
" Maintainer:	Andreas Louv <andreas@louv.dk>
" Last Change:	Mar 30, 2018

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Hide start of file path
syn match	Conceal         "^\%(.\{-}/\%([^/]\+|\d\)\@=\)\="
			      \ conceal
			      \ nextgroup=qfFileName

" A bunch of useful C keywords
syn match	qfFileName	"[^/|]*|\@1=" nextgroup=qfSeparator contained
syn match	qfSeparator	"|" nextgroup=qfLineNr contained
syn match	qfLineNr	"[^|]*" contained contains=qfError
syn match	qfError		"error" contained

" The default highlighting.
hi def link qfFileName	Directory
hi def link qfLineNr	LineNr
hi def link qfError	Error

let b:current_syntax = "qf"

" vim: ts=8

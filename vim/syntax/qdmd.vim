" Vim syntax file
" Language:             Quick DMD
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Aug 21, 2017
" Version:              1
" URL:                  https://github.com/andlrc/dotfiles

if exists('b:current_syntax')
  finish
endif

let b:current_syntax = 'qdmd'

syntax match   Comment  /#.*/
syntax keyword Keyword  TITLE LIB ENTITY INDEX COLUMN TYPE RELATION VALUES
syntax match   Keyword  /\%(UIFORM\|UIGRID\)\.\w\+/
syntax match   Operator /=>\|<=\|-\|=/

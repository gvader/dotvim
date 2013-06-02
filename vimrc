" Vim config
" Author: Lukasz Gwadera lukasz.gwadera@gmail.com
"

" stuff to make pathogen work
runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()
call pathogen#incubate() 
call pathogen#helptags()

syntax on
filetype plugin indent on

set smartindent 	" smart indentation designed for C based programming languages
set autoindent 		" that uses indentation of previous line
set expandtab		" changes tabs to spaces in order to avoid problems with formatting behavoiurs from different editors
set tabstop=4		" sets tabwidth for 4 spaces, default is 8 which makes code little lengthy
set shiftwidth=4	" sets indent for 4 spaces also
set showmatch		" enables highlighting for matching braces
set textwidth=160	" sets code line leght for 160 characters 

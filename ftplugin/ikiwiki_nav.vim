" vim: fdm=marker
" {{{1 LICENSE
" Copyright: 2010 Javier Rojas <jerojasro@devnull.li>
"
" License:
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 2 of the License, or
" (at your option) any later version.
"
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <http://www.gnu.org/licenses/>.
"
" ftplugin to navigate ikiwiki links from within vim
"
" Author: Javier Rojas <jerojasro@devnull.li>
" Version:  2.0
" Last Updated: 2010-09-12
" URL: http://git.devnull.li/ikiwiki-nav.git/
"
" }}}1

if exists("b:loaded_ikiwiki_nav")
  finish
endif
let b:loaded_ikiwiki_nav = 1

let s:save_cpo = &cpo
set cpo&vim

" {{{1 constants for choosing how to open the selected file
let g:IKI_BUFFER = 0
let g:IKI_HSPLIT = 1
let g:IKI_VSPLIT = 2
let g:IKI_TAB = 3
" command definitions {{{1
if !exists(":IkiJumpToPageCW")
  command IkiJumpToPageCW :call ikiwiki#nav#GoToWikiPage(0, g:IKI_BUFFER)
endif
if !exists(":IkiJumpToPageHW")
  command IkiJumpToPageHW :call ikiwiki#nav#GoToWikiPage(0, g:IKI_HSPLIT)
endif
if !exists(":IkiJumpToPageVW")
  command IkiJumpToPageVW :call ikiwiki#nav#GoToWikiPage(0, g:IKI_VSPLIT)
endif
if !exists(":IkiJumpToPageNT")
  command IkiJumpToPageNT :call ikiwiki#nav#GoToWikiPage(0, g:IKI_TAB)
endif
if !exists(":IkiJumpOrCreatePageCW")
  command IkiJumpOrCreatePageCW :call ikiwiki#nav#GoToWikiPage(1, g:IKI_BUFFER)
endif
if !exists(":IkiJumpOrCreatePageHW")
  command IkiJumpOrCreatePageHW :call ikiwiki#nav#GoToWikiPage(1, g:IKI_HSPLIT)
endif
if !exists(":IkiJumpOrCreatePageVW")
  command IkiJumpOrCreatePageVW :call ikiwiki#nav#GoToWikiPage(1, g:IKI_VSPLIT)
endif
if !exists(":IkiJumpOrCreatePageNT")
  command IkiJumpOrCreatePageNT :call ikiwiki#nav#GoToWikiPage(1, g:IKI_TAB)
endif
if !exists(":IkiNextWikiLink")
  command IkiNextWikiLink :call ikiwiki#nav#NextWikiLink(0)
endif
if !exists(":IkiPrevWikiLink")
  command IkiPrevWikiLink :call ikiwiki#nav#NextWikiLink(1)
endif
" }}}1

" mapping definitions {{{1
" {{{2 helper to define mappings
function! s:safe_map(keys, command)
  if !hasmapto(a:command, 'n') && maparg(a:keys, 'n') == ""
    execute 'noremap <unique> <buffer> ' a:keys a:command '<CR>'
  endif
endfunction
" {{{2 page jumping
call s:safe_map('<C-h>', ':IkiJumpToPageCW')
call s:safe_map('<C-j>', ':IkiJumpToPageHW')
call s:safe_map('<C-k>', ':IkiJumpToPageVW')
call s:safe_map('<C-l>', ':IkiJumpToPageNT')
" {{{2 page creation
call s:safe_map('<Leader>h', ':IkiJumpOrCreatePageCW')
call s:safe_map('<Leader>j', ':IkiJumpOrCreatePageHW')
call s:safe_map('<Leader>k', ':IkiJumpOrCreatePageVW')
call s:safe_map('<Leader>l', ':IkiJumpOrCreatePageNT')
" {{{2 link navigation
call s:safe_map('<C-n>', ':IkiNextWikiLink')
call s:safe_map('<C-p>', ':IkiPrevWikiLink')

" }}}1

let &cpo = s:save_cpo

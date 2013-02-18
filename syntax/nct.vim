" Vim syntax file
" Language: nct (Templates)	
" Maintainer: Wayne Larsen <wayne@larsen.st>, based off mustache.vim by
" Juvenn Woo
" Version:	1
" Remark:
"   It lexically hilights embedded nct commands (exclusively) in html file. 
" References:	
"   [nct](http://github.com/wvl/nct)
"   [mustache.vim](https://github.com/juvenn/mustache.vim)
" TODO: Feedback is welcomed.


" Read the HTML syntax to start with
if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Standard HiLink will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

syntax match nctError '}}}\?'
syntax match nctInsideError '{{[{#<>=!\/]\?' containedin=@nctInside

syntax region nctVariable matchgroup=nctVarTags start=/{/ end=/}/ containedin=@htmlnctContainer 
syntax region nctVariableUnescape matchgroup=nctVarTags start=/{{/ end=/}}/ containedin=@htmlnctContainer

" Why can't I do alternatives and conditionals?
syntax region nctSection matchgroup=nctCommand start="\.if" start=/\.each/ start=/\.#/ start=".else" start=/\.extends/ start=/\.block/ start="\.\/if" start=/\.\/block/ start=/\.\/each/ start=/\.\/#/ end=/\n/ containedin=@htmlnctContainer
syntax region nctSection matchgroup=nctCommand start="{if" start=/{each/ start="{else" start=/{extends/ start=/{block/ start="{\/if" start="{\/else" start=/{\/extends/ start=/{\/block/ start=/{\/each/ end=/}/ containedin=@htmlnctContainer
syntax region nctPartial matchgroup=nctCommand start=/{include/ start="\.include" end=/\n/ end=/}/
" syntax region nctComment start=/{#/ end=/}/ contains=Todo containedin=htmlHead
" syntax region nctComment start=/\.#/ end=/\n/ contains=Todo containedin=htmlHead


" Clustering
syntax cluster nctInside add=nctVariable,nctVariableUnescape,nctSection,nctPartial,nctMarkerSet
syntax cluster htmlnctContainer add=htmlHead,htmlTitle,htmlString,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6


" Hilighting
" nctInside hilighted as Number, which is rarely used in html
" you might like change it to Function or Identifier
HtmlHiLink nctVariable Number
HtmlHiLink nctVariableUnescape Number
HtmlHiLink nctPartial Number 
HtmlHiLink nctSection Number 
HtmlHiLink nctMarkerSet Number
HtmlHiLink nctVarTags Special 

HtmlHiLink nctComment Comment
HtmlHiLink nctCommand Function 
HtmlHiLink nctError Error
HtmlHiLink nctInsideError Error

let b:current_syntax = "nct"
delcommand HtmlHiLink


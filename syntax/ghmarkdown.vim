" Vim syntax file
" Language:     Github Flavored Markdown
" Markdown.vim Maintainer: Tim Pope <vimNOSPAM@tpope.org>
" forked from: GFM Maintainer: Jeff Tratner <github.com/jtratner>
" Filenames:    *.ghmarkdown

if exists("b:current_syntax")
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'ghmarkdown'
endif

runtime! syntax/html.vim
unlet! b:current_syntax

syn sync minlines=10
syn case ignore

syn match markdownValid '[<>]\c[a-z/$!]\@!'
syn match markdownValid '&\%(#\=\w*;\)\@!'

syn match markdownLineStart "^[<@]\@!" nextgroup=@markdownBlock,htmlSpecialChar

syn cluster markdownBlock contains=markdownH1,markdownH2,markdownH3,markdownH4,markdownH5,markdownH6,markdownBlockquote,markdownListMarker,markdownOrderedListMarker,markdownCodeBlock,markdownRule,markdownGHCodeBlock
syn cluster markdownInline contains=markdownLineBreak,markdownLinkText,markdownItalic,markdownBold,markdownCode,markdownEscape,@htmlTop,markdownError

syn match markdownH1 "^.\+\n=\+$" contained contains=@markdownInline,markdownHeadingRule,markdownAutomaticLink
syn match markdownH2 "^.\+\n-\+$" contained contains=@markdownInline,markdownHeadingRule,markdownAutomaticLink

syn match markdownHeadingRule "^[=-]\+$" contained

syn region markdownH1 matchgroup=markdownHeadingDelimiter start="##\@!"      end="#*\s*$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained
syn region markdownH2 matchgroup=markdownHeadingDelimiter start="###\@!"     end="#*\s*$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained
syn region markdownH3 matchgroup=markdownHeadingDelimiter start="####\@!"    end="#*\s*$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained
syn region markdownH4 matchgroup=markdownHeadingDelimiter start="#####\@!"   end="#*\s*$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained
syn region markdownH5 matchgroup=markdownHeadingDelimiter start="######\@!"  end="#*\s*$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained
syn region markdownH6 matchgroup=markdownHeadingDelimiter start="#######\@!" end="#*\s*$" keepend oneline contains=@markdownInline,markdownAutomaticLink contained

syn match markdownBlockquote ">\%(\s\|$\)" contained nextgroup=@markdownBlock

" TODO: real nesting
syn match markdownListMarker "\%(\t\| \{0,4\}\)[-*+]\%(\s\+\S\)\@=" contained
syn match markdownOrderedListMarker "\%(\t\| \{0,4}\)\<\d\+\.\%(\s\+\S\)\@=" contained

"syn match markdownRule "\* *\* *\*[ *]*$" contained
"syn match markdownRule "- *- *-[ -]*$" contained
syn match markdownRule "^----*$" contained

syn match markdownLineBreak " \{2,\}$"

syn region markdownIdDeclaration matchgroup=markdownLinkDelimiter start="^ \{0,3\}!\=\[" end="\]:" oneline keepend nextgroup=markdownUrl skipwhite
syn match markdownUrl "\S\+" nextgroup=markdownUrlTitle skipwhite contained
syn region markdownUrl matchgroup=markdownUrlDelimiter start="<" end=">" oneline keepend nextgroup=markdownUrlTitle skipwhite contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+"+ end=+"+ keepend contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+'+ end=+'+ keepend contained
syn region markdownUrlTitle matchgroup=markdownUrlTitleDelimiter start=+(+ end=+)+ keepend contained

syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\_[^]]*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" keepend nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained
syn region markdownId matchgroup=markdownIdDelimiter start="\[" end="\]" keepend contained
syn region markdownAutomaticLink matchgroup=markdownUrlDelimiter start="<\%(\w\+:\|[[:alnum:]_+-]\+@\)\@=" end=">" keepend oneline

syn clear htmlBold
syn clear htmlBoldUnderline
syn clear htmlBoldItalic
syn clear htmlBoldUnderlineItalic
syn clear htmlBoldItalicUnderline
syn clear htmlUnderline
syn clear htmlUnderlineBold
syn clear htmlUnderlineItalic
syn clear htmlUnderlineItalicBold
syn clear htmlUnderlineBoldItalic
syn clear htmlItalic
syn clear htmlItalicBold
syn clear htmlItalicBoldUnderline
syn clear htmlItalicUnderline
syn clear htmlItalicUnderlineBold

syn region markdownItalic start="\%(^\|\s\)\zs\*\ze[^\\\*\t ]\%(\%([^*]\|\\\*\|\n\)*[^\\\*\t ]\)\?\*\_W" end="[^\\\*\t ]\zs\*\ze\_W" keepend oneline
syn region markdownItalic start="\%(^\|\s\)\zs_\ze[^\\_\t ]" end="[^\\_\t ]\zs_\ze\_W" keepend oneline
syn region markdownBold start="\%(^\|\s\)\*\*\ze\S" end="\S\zs\*\*" keepend oneline
syn region markdownBold start="\%(^\|\s\)\zs__\ze\S" end="\S\zs__" keepend oneline
syn region markdownBoldItalic start="\%(^\|\s\)\zs\*\*\*\ze\S" end="\S\zs\*\*\*" keepend oneline
syn region markdownBoldItalic start="\%(^\|\s\)\zs___\ze\S" end="\S\zs___" keepend oneline

syn region markdownCode matchgroup=markdownCodeDelimiter start="`" end="`" keepend oneline contained
syn region markdownGHCodeBlock matchgroup=markdownCodeDelimiter start="^\s*```\s\?\S*\s*$" end="\s*```$\n" contained  keepend
"syn region markdownGHCodeBlock matchgroup=markdownCodeDelimiter start="^\s*$\n\s*```\s\?\S*\s*$" end="\s*```$\n\s*\n" contained  keepend
"syn region markdownCode matchgroup=markdownCodeDelimiter start="``` \=" end=" \=```" keepend contains=markdownLineStart

syn match markdownEscape "\\[][\\`*_{}()#+.!-]"

" Copying rst's method of using literal strings
hi def link markdownGHCodeBlock           String
hi def link markdownCodeBlock             String
hi def link markdownCode                  String
hi def link markdownH1                    htmlH1
hi def link markdownH2                    htmlH2
hi def link markdownH3                    htmlH3
hi def link markdownH4                    htmlH4
hi def link markdownH5                    htmlH5
hi def link markdownH6                    htmlH6
hi def link markdownHeadingRule           markdownCode
hi def link markdownHeadingDelimiter      Delimiter
hi def link markdownOrderedListMarker     markdownListMarker
hi def link markdownListMarker            htmlTagName
hi def link markdownBlockquote            Comment
hi def link markdownRule                  Underlined

hi def link markdownLinkText              htmlLink
hi def link markdownIdDeclaration         Typedef
hi def link markdownId                    Type
hi def link markdownAutomaticLink         markdownUrl
hi def link markdownUrl                   Float
hi def link markdownUrlTitle              String
hi def link markdownIdDelimiter           markdownLinkDelimiter
hi def link markdownUrlDelimiter          htmlTag
hi def link markdownUrlTitleDelimiter     Delimiter

hi def link markdownItalic                htmlItalic
hi def link markdownBold                  htmlBold
hi def link markdownBoldItalic            htmlBoldItalic
hi def link markdownCodeDelimiter         Delimiter

hi def link markdownEscape                Special

let b:current_syntax = "ghmarkdown"

if main_syntax ==# 'ghmarkdown'
  unlet main_syntax
endif
" vim:set sw=2:

"=============================================================================
" File: googlesuggest-complete.vim
" Author: Yasuhiro Matsumoto <mattn.jp@gmail.com>
" Last Change: 03-Apr-2012.
" Version: 0.2
" WebPage: http://github.com/mattn/googlesuggest-complete-vim
" Usage:
"
"   Require:
"
"     set completefunc=googlesuggest#Complete
"
"   Lesson1:
"
"     takasu<c-x><c-u>
"           +----------------+
"     takasu|高杉晋作========|
"           |高須クリニック  |
"           |高須            |
"           |高鈴            |
"           |高鷲スノーパーク|
"           |高杉さと美      |
"           |高杉良          |
"           |高須光聖        |
"           |高須克弥        |
"           |高須 ブログ     |
"           +----------------+
"     * perhaps, you can see the candidates above.
"
"   Lesson2:
"
"     watasinonamaeha<c-x><c-u>
"
"     => 私の名前はキムサムスン
"     * who is kim samsoon?
"
"   Etc:
"
"     naitu<c-x><c-u>
"     => ナイツ お笑い
"
"     www<c-x><c-u>
"     => www.yahoo.co.jp
"
"     gm<c-x><c-u>
"     => gmailへようこそ
"
"     vimp<c-x><c-u>
"     => vimperator
"
"     puri<c-x><c-u>
"     => プリキュア
"

if !exists('g:googlesuggest_language')
  let g:googlesuggest_language = 'ja'
endif

function! googlesuggest#Complete(findstart, base)
  if a:findstart
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start
  else
    " find months matching with "a:base"
    let ret = []
    let res = webapi#http#get('http://suggestqueries.google.com/complete/search', {"client" : "youtube", "q" : a:base, "hjson" : "t", "hl" : g:googlesuggest_language, "ie" : "UTF8", "oe" : "UTF8" })
	let arr = webapi#json#decode(res.content)
    for m in arr[1]
      call add(ret, m[0])
    endfor
    return ret
  endif
endfunction


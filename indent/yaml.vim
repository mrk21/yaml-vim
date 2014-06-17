if exists('b:did_indent')
  finish
endif

let b:did_indent = 1

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

setlocal expandtab
setlocal noautoindent
setlocal nosmartindent

setlocal indentexpr=g:GetYamlIndent(v:lnum)

function! g:GetYamlIndent(lnum)
  let l:prevlnum = a:lnum - 1
  let l:prevline = getline(l:prevlnum)
  let l:previndent = indent(l:prevlnum)
  return yaml#GetNextIndent(l:prevline, l:previndent)
endfunction

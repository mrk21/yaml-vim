scriptencoding utf-8

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

setlocal expandtab
setlocal noautoindent
setlocal nosmartindent

setlocal indentexpr=g:GetYamlIndent(v:lnum)
let b:yaml_context = yaml#Context()

function! g:GetYamlIndent(lnum)
  let l:prevlnum = a:lnum - 1
  let l:prevline = getline(l:prevlnum)
  let l:previndent = indent(l:prevlnum)
  return b:yaml_context.GetNextIndent(l:prevline, l:previndent)
endfunction

if !exists('b:undo_indent')
  let b:undo_indent = ''
endif

let b:undo_indent .= '| setlocal '.join([
      \ 'tabstop<',
      \ 'softtabstop<',
      \ 'shiftwidth<',
      \])

function! yaml#GetNextIndent(line, indent)
  if a:line =~ '---'
    return 0
  endif
  
  if a:line =~ ':\s*$'
    return a:indent + &l:shiftwidth
  endif
  
  if a:line =~ '-\s*$'
    return a:indent + &l:shiftwidth
  end
  
  return a:indent
endfunction

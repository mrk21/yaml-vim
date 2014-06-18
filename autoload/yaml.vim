scriptencoding utf-8

function! yaml#GetNextIndent(line, indent)
  let l:sw = &l:shiftwidth
  
  " structures
  if a:line =~ '^---\s\+[>|]\s*$'
    return a:indent + l:sw
  endif
  
  " scalar start symbols('>' and '|')
  if a:line =~ '^[>|]\s*$'
    return a:indent + l:sw
  endif
  
  " mappings collection
  if a:line =~ '^\s*[^:]\+:\s*$'
    return a:indent + l:sw
  endif
  
  if a:line =~ '^\s*[^:]\+:\s\+[>|]\s*$'
    return a:indent + l:sw
  endif
  
  " sequence collection
  if a:line =~ '^\s*-\s*$'
    return a:indent + l:sw
  end
  
  if a:line =~ '^\s*-\s\+[>|]\s*$'
    return a:indent + l:sw
  end
  
  " other
  return a:indent
endfunction

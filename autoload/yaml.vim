scriptencoding utf-8

function! yaml#Context(...)
  let l:obj = {}
  let l:obj.settings = get(a:, 1, {})
  
  function l:obj.GetIndentWidth()
    if has_key(self.settings, 'indent_width')
      return self.settings.indent_width
    endif
    return &l:shiftwidth
  endfunction
  
  function l:obj.GetNextIndent(line, indent)
    let l:width = self.GetIndentWidth()
    
    " structures
    if a:line =~ '^---\s\+[>|]\s*$'
      return a:indent + l:width
    endif
    
    " scalar start symbols('>' and '|')
    if a:line =~ '^[>|]\s*$'
      return a:indent + l:width
    endif
    
    " sequence collection
    if a:line =~ '^\s*-\s*$'
      return a:indent + l:width
    end
    
    if a:line =~ '^\s*-\s\+[>|]\s*$'
      return a:indent + l:width
    end
    
    if a:line =~ '^\s*-\s\+[^:]\+:\s*$'
      return a:indent + 2*l:width
    end
    
    if a:line =~ '^\s*-\s\+[^:]\+:\s\+.\+$'
      return a:indent + l:width
    end
    
    " mappings collection
    if a:line =~ '^\s*[^:]\+:\s*$'
      return a:indent + l:width
    endif
    
    if a:line =~ '^\s*[^:]\+:\s\+[>|]\s*$'
      return a:indent + l:width
    endif
    
    " other
    return a:indent
  endfunction
  
  return l:obj
endfunction

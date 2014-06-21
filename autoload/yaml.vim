scriptencoding utf-8

let s:tag_regexp = '!\{1,2\}[^! ]\+!\?'
let s:scalar_regexp = '[|>]\%([+-]\=[1-9]\|[1-9]\=[+-]\)\='
let s:tag_and_scalar_regexp = '\(\('. s:tag_regexp .'\)\s\+\)\?'. s:scalar_regexp

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
    if a:line =~ '^---\s\+'. s:tag_and_scalar_regexp .'\s*$'
      return a:indent + l:width
    endif
    
    " scalar start symbols('>' and '|')
    if a:line =~ '^'. s:tag_and_scalar_regexp .'\s*$'
      return a:indent + l:width
    endif
    
    " sequence collection
    if a:line =~ '^\s*-\s*$'
      return a:indent + l:width
    end
    
    if a:line =~ '^\s*-\s\+'. s:tag_regexp .'\s*$'
      return a:indent + l:width
    end
    
    if a:line =~ '^\s*-\s\+'. s:tag_and_scalar_regexp .'\s*$'
      return a:indent + l:width
    end
    
    if a:line =~ '^\s*-\s\+[^:]\+:\s*$'
      return a:indent + 2*l:width
    end
    
    if a:line =~ '^\s*-\s\+[^:]\+:\s*'. s:tag_regexp .'\s*$'
      return a:indent + 2*l:width
    end
    
    if a:line =~ '^\s*-\s\+[^:]\+:\s*'. s:tag_and_scalar_regexp .'\s*$'
      return a:indent + 2*l:width
    end
    
    if a:line =~ '^\s*-\s\+[^:]\+:\s\+.\+$'
      return a:indent + l:width
    end
    
    " mappings collection
    if a:line =~ '^\s*[^:]\+:\s*$'
      return a:indent + l:width
    endif
    
    if a:line =~ '^\s*[^:]\+:\s\+'. s:tag_regexp .'\s*$'
      return a:indent + l:width
    endif
    
    if a:line =~ '^\s*[^:]\+:\s\+'. s:tag_and_scalar_regexp .'\s*$'
      return a:indent + l:width
    endif
    
    " other
    return a:indent
  endfunction
  
  return l:obj
endfunction

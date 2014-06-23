scriptencoding utf-8

let s:tags_regexp = '!\{1,2\}[^! ]\+!\?'
let s:block_scalar_headers_regexp = '[|>]\%([+-]\=[1-9]\|[1-9]\=[+-]\)\='
let s:tags_and_block_scalar_headers_regexp =
      \ '\(\('. s:tags_regexp .'\)\s\+\)\?'. s:block_scalar_headers_regexp

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
    
    
    " ### The structures ###
    if a:line =~ '^---\s\+'. s:tags_and_block_scalar_headers_regexp .'\s*$'
      return a:indent + l:width
    endif
    
    
    " ### The block scalar headers('>' and '|') ###
    if a:line =~ '^'. s:tags_and_block_scalar_headers_regexp .'\s*$'
      return a:indent + l:width
    endif
    
    
    " ### The sequences ###
    if a:line =~ '^\s*-\s*$'
      return a:indent + l:width
    end
    
    " with the tags
    if a:line =~ '^\s*-\s\+'. s:tags_regexp .'\s*$'
      return a:indent + l:width
    end
    
    " with the tags and the block scalar headers
    if a:line =~ '^\s*-\s\+'. s:tags_and_block_scalar_headers_regexp .'\s*$'
      return a:indent + l:width
    end
    
    " with the mappings
    if a:line =~ '^\s*-\s\+[^:]\+:\s*$'
      return a:indent + 2*l:width
    end
    
    " with the mappings and the tags
    if a:line =~ '^\s*-\s\+[^:]\+:\s*'. s:tags_regexp .'\s*$'
      return a:indent + 2*l:width
    end
    
    " with the mappings, the tags and the block scalar headers
    if a:line =~ '^\s*-\s\+[^:]\+:\s*'. s:tags_and_block_scalar_headers_regexp .'\s*$'
      return a:indent + 2*l:width
    end
    
    " with the mappings and the flow scalars
    if a:line =~ '^\s*-\s\+[^:]\+:\s\+.\+$'
      return a:indent + l:width
    end
    
    
    " ### The mappings ###
    if a:line =~ '^\s*[^:]\+:\s*$'
      return a:indent + l:width
    endif
    
    " with the tags
    if a:line =~ '^\s*[^:]\+:\s\+'. s:tags_regexp .'\s*$'
      return a:indent + l:width
    endif
    
    " with the tags and the block scalar headers
    if a:line =~ '^\s*[^:]\+:\s\+'. s:tags_and_block_scalar_headers_regexp .'\s*$'
      return a:indent + l:width
    endif
    
    
    " ### others ###
    return a:indent
  endfunction
  
  return l:obj
endfunction

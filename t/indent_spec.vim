setlocal shiftwidth=2

describe 'yaml'
  describe '#GetNextIndent(line, indent)'
    context 'when the `line` was structures'
      it 'should be 0'
        Expect yaml#GetNextIndent('---',0) ==# 0
      end
    end
    
    context 'when the `line` was mappings collection'
      it 'should be the `line` plus shiftwidth'
        Expect yaml#GetNextIndent('hoge:', 0) ==# 2
      end
    end
    
    context 'when the `line` was sequence collection'
      it 'should be the `line` plus shiftwidth'
        Expect yaml#GetNextIndent('-', 0) ==# 2
      end
    end
  end
end

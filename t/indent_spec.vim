scriptencoding utf-8

setlocal shiftwidth=2

describe 'yaml'
  describe '#GetNextIndent(line, indent)'
    context 'when the `line` was structures'
      it 'should do not indent'
        Expect yaml#GetNextIndent('---', 0) == 0
        Expect yaml#GetNextIndent('--- ', 0) == 0
      end
      
      context 'with scalar start symbols(">" and "|")'
        it 'should do indent'
          Expect yaml#GetNextIndent("--- \>", 0) == 2
          Expect yaml#GetNextIndent("--- \> ", 0) == 2
          
          Expect yaml#GetNextIndent('--- |', 0) == 2
          Expect yaml#GetNextIndent('--- | ', 0) == 2
        end
        
        context 'when not existed spaces before the scalar start symbols'
          it 'should do not indent'
            Expect yaml#GetNextIndent("---\>", 0) == 0
            Expect yaml#GetNextIndent("---\> ", 0) == 0
            
            Expect yaml#GetNextIndent('---|', 0) == 0
            Expect yaml#GetNextIndent('---| ', 0) == 0
          end
        end
      end
    end
    
    context 'when the `line` was scalar start symbols(">" and "|")'
      it 'should do indent'
        Expect yaml#GetNextIndent("\>", 0) == 2
        Expect yaml#GetNextIndent("\> ", 0) == 2
        
        Expect yaml#GetNextIndent('|', 0) == 2
        Expect yaml#GetNextIndent('| ', 0) == 2
      end
      
      context 'when existed spaces before the scalar start symbols'
        it 'should do not indent'
          Expect yaml#GetNextIndent(" \>", 0) == 0
          Expect yaml#GetNextIndent(" \> ", 0) == 0
          
          Expect yaml#GetNextIndent(' |', 0) == 0
          Expect yaml#GetNextIndent(' | ', 0) == 0
        end
      end
    end
    
    context 'when the `line` was mappings collection'
      it 'should do indent'
        Expect yaml#GetNextIndent('hoge:', 0) == 2
        Expect yaml#GetNextIndent('hoge: ', 0) == 2
      end
      
      context 'with scalar start symbols(">" and "|")'
        it 'should do indent'
          Expect yaml#GetNextIndent("hoge: \>", 0) == 2
          Expect yaml#GetNextIndent("hoge: \> ", 0) == 2
          
          Expect yaml#GetNextIndent('hoge: |', 0) == 2
          Expect yaml#GetNextIndent('hoge: | ', 0) == 2
        end
        
        context 'when not existed spaces between ":" and the scalar start symbols'
          it 'should do not indent'
            Expect yaml#GetNextIndent("hoge:\>", 0) == 0
            Expect yaml#GetNextIndent("hoge:\> ", 0) == 0
            
            Expect yaml#GetNextIndent('hoge:|', 0) == 0
            Expect yaml#GetNextIndent('hoge:| ', 0) == 0
          end
        end
      end
    end
    
    context 'when the `line` was sequence collection'
      it 'should do indent'
        Expect yaml#GetNextIndent('-', 0) == 2
        Expect yaml#GetNextIndent('- ', 0) == 2
      end
      
      context 'with scalar start symbols(">" and "|")'
        it 'should do indent'
          Expect yaml#GetNextIndent("- \>", 0) == 2
          Expect yaml#GetNextIndent("- \> ", 0) == 2
          
          Expect yaml#GetNextIndent('- |', 0) == 2
          Expect yaml#GetNextIndent('- | ', 0) == 2
        end
        
        context 'when not existed spaces between "-" and the scalar start symbols'
          it 'should do not indent'
            Expect yaml#GetNextIndent("-\>", 0) == 0
            Expect yaml#GetNextIndent("-\> ", 0) == 0
            
            Expect yaml#GetNextIndent('-|', 0) == 0
            Expect yaml#GetNextIndent('-| ', 0) == 0
          end
        end
      end
    end
  end
end

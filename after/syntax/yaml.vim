scriptencoding utf-8

syntax match yamlBlockScalarHeader '\zs[|>]\%([+-]\=[1-9]\|[1-9]\=[+-]\)\=\(\s\|$\)'
highlight link yamlBlockScalarHeader Statement

syntax match yamlBlockSequenceStart /^\s*-\s*$/
highlight link yamlBlockSequenceStart Statement

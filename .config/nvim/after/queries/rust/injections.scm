; extends

( ;; inject highlighting for code blocks in doc comments
    (line_comment) @_first 
    (_) @rust
    (line_comment) @_last 
    (#match? @_first "^/// ```$") 
    (#match? @_last "^/// ```$")
    (#offset! @rust 0 4 0 4)
)

( ;; inject highlighting for code blocks in normal comments
    (line_comment) @_first 
    (_) @rust
    (line_comment) @_last 
    (#match? @_first "^// ```$") 
    (#match? @_last "^// ```$")
    (#offset! @rust 0 3 0 4)
)

( ;; does this even work? no idea
  (macro_invocation
    macro: ((identifier) @_html_def)
    (token_tree) @html)

    (#eq? @_html_def "view")
)

; extends

; ( ;; inject highlighting for code blocks in doc comments
;  (line_comment) @_first 
;  (_) @rust
;  (line_comment) @_last 
;  (#match? @_first "^/// ```$") 
;  (#match? @_last "^/// ```$")
;  (#offset! @rust 0 4 0 0)
; )
;
; ( ;; inject highlighting for code blocks in normal comments
;  (line_comment) @_first 
;  (_) @rust
;  (line_comment) @_last 
;  (#match? @_first "^// ```$") 
;  (#match? @_last "^// ```$")
;  (#offset! @rust 0 3 0 0)
; )

;; extends

( ;; highlight code blocks in doc comments as rust
  ((line_comment) @code_block_start
    (#eq? @code_block_start "/// ```"))

  ((line_comment) @rust
    (#offset! @rust 0 4 0 0))

  ((line_comment) @code_block_end
    (#eq? @code_block_end "/// ```"))
)

; ( ;; markdown the whole comment - WIP
;   (((line_comment) @markdown
;     (#match? @markdown "///.*"))
;       (#offset! @markdown 0 4 0 0))
; )

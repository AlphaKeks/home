; extends

; highlight code blocks in doc comments (still shitty but works sometimes)
(
  ((line_comment) @_doc_comment_start
    (#eq? @_doc_comment_start "/// ```"))

  ((line_comment) @rust
    (#offset! @rust 0 4 0 0))

  ((line_comment) @_doc_comment_end
    (#eq? @_doc_comment_end "/// ```"))
)

; highlight sql in `sqlx::query()` calls
(
  (call_expression
    (scoped_identifier
      path: (identifier) @_path (#eq? @_path "sqlx")
      name: (identifier) @_name (#match? @_name "query.*"))

    (arguments
      (string_literal) @sql)

    (#offset! @sql 1 0 0 0))

  (call_expression
    (scoped_identifier
      path: (identifier) @_path (#eq? @_path "sqlx")
      name: (identifier) @_name (#match? @_name "query.*"))

    (arguments
      (raw_string_literal) @sql)

    (#offset! @sql 1 0 0 0))
)

; highlight json in json! {} blocks
(
  (macro_invocation
    (identifier) @_name (#eq? @_name "json")
    (token_tree) @json
    (#offset! @json 1 0 0 0))
)

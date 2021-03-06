(require 's)

(defun js2r-ternary-to-if ()
  (interactive)
  (js2r--guard)
  (save-excursion
    (let* ((ternary (js2r--closest 'js2-cond-node-p))
           (test-expr (js2-node-string (js2-cond-node-test-expr ternary)))
           (true-expr (js2-node-string (js2-cond-node-true-expr ternary)))
           (false-expr (js2-node-string (js2-cond-node-false-expr ternary)))
           (stmt (js2-node-parent-stmt ternary))
           (stmt-pre (buffer-substring (js2-node-abs-pos stmt) (js2-node-abs-pos ternary)))
           (stmt-post (s-trim (buffer-substring (js2-node-abs-end ternary) (js2-node-abs-end stmt))))
           (beg (js2-node-abs-pos stmt)))
      (goto-char beg)
      (delete-char (js2-node-len stmt))
      (insert "if (" test-expr ") {")
      (newline)
      (insert stmt-pre true-expr stmt-post)
      (newline)
      (insert "} else {")
      (newline)
      (insert stmt-pre false-expr stmt-post)
      (newline)
      (insert "}")
      (indent-region beg (point)))))

(provide 'js2r-conditionals)
;;; js2r-conditionals ends here

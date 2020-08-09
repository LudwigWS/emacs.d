(require-package 'auctex)
(require-package 'cdlatex)

;; keymap
;; recover: C-<RET>     (org-insert-heading-respect-content)
(define-key cua-global-keymap (kbd "C-<return>") nil)

;; behavior
(add-hook 'focus-out-hook (lambda () (interactive) (save-some-buffers t)))

(provide 'init-local)

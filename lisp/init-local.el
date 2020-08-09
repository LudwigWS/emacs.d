;; latex
(require-package 'auctex)
(require-package 'cdlatex)

;; keymap
;; recover: C-<RET>     (org-insert-heading-respect-content)
(define-key cua-global-keymap (kbd "C-<return>") nil)


;; behavior
;; auto-save when focus-out
;;(add-hook 'focus-out-hook (lambda () (interactive) (save-some-buffers t)))



(require-package 'doom-themes)

;; (require-package 'helm)


;; -------------------------------------------
;; find my-note (fzf)
;; -------------------------------------------

;; Info Key Bindings 49.3.7 Modifier Keys
;; super, hyper
(defun find-note ()
  (interactive)
  (counsel-fzf nil "~/OneDrive/MyNote/")
  )
(global-set-key (kbd "s-p") 'find-note)

;; -------------------------------------------
;; find my-note
;; -------------------------------------------



;; 解决 ATTR_ORG 设置图片大小不生效的问题
;; [[https://emacs.stackexchange.com/questions/26363/downscaling-inline-images-in-org-mode][Downscaling inline images in org-mode - Emacs Stack Exchange]]
(setq org-image-actual-width nil)


;;(setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f"
;;                              "xelatex -interaction nonstopmode %f"))

;;----------------------------------------------------------------------------------
;;org-download
;;----------------------------------------------------------------------------------

;; [dotfiles/setup-org.el at 96f84150cd2733f2ad01b06d2b03d4e572f279e4 · jiacai2050/dotfiles](https://github.com/jiacai2050/dotfiles/blob/96f84150cd2733f2ad01b06d2b03d4e572f279e4/.emacs.d/customizations/setup-org.el#L69)
;; (format-time-string "%Y%m%d%H%M%S")

(require-package 'org-download)
(add-hook 'org-mode-hook 'org-download-enable)
(setq-default org-download-heading-lvl nil
              ;; org-download-image-dir (concat "./source/img/" (file-name-nondirectory (buffer-file-name)))
              ;; org-download-screenshot-method "screencapture -i %s"
              org-download-screenshot-method "pngpaste %s"
              org-download-screenshot-file (expand-file-name "screenshot.jpg" temporary-file-directory)
              )

(defun my-org-download--dir-1 ()
  (or org-download-image-dir (concat "./source/img/" (file-name-nondirectory (file-name-sans-extension (buffer-file-name))) )))

(advice-add #'org-download--dir-1 :override #'my-org-download--dir-1)

(setq org-download-image-attr-list '("#+ATTR_HTML: width=\"600px\"\n #+ATTR_ORG: :width 600"))
;;----------------------------------------------------------------------------------
;;org-download
;;----------------------------------------------------------------------------------





(provide 'init-local)

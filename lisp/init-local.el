(require-package 'reveal-in-osx-finder)




;; latex
(require-package 'auctex)
(require-package 'cdlatex)

;;----------------------------------------------------------------------------------
;; LateX
;;----------------------------------------------------------------------------------

;; Chinese fragment Preview
;; (setq org-latex-packages-alist
;;       '(("fontset=macnew,UTF8" "ctex" t)))

;; (setq org-preview-latex-default-process 'imagemagick)

;; (setq org-preview-latex-process-alist
;;       '(
;;         (dvisvgm
;;          :programs ("xelatex" "dvisvgm")
;;          :description "xdv > svg"
;;          :message "you need to install the programs: xelatex and dvisvgm."
;;          :image-input-type "xdv"
;;          :image-output-type "svg"
;;          :image-size-adjust (1.7 . 1.5)
;;          :latex-compiler ("xelatex --no-pdf -interaction nonstopmode -output-directory %o %f")
;;          :image-converter ("dvisvgm %f -n -b min -c %S -o %O"))
;;         (imagemagick
;;          :programs ("latex" "convert")
;;          :description "pdf > png"
;;          :message "you need to install the programs: xelatex and imagemagick."
;;          :image-input-type "pdf"
;;          :image-output-type "png"
;;          :image-size-adjust (1.0 . 1.0)
;;          :latex-compiler ("xelatex -interaction nonstopmode -output-directory %o %f")
;;          :image-converter
;;          ("convert -density %D -trim -antialias %f -quality 100 %O"))))
;; ;;----------------------------------------------------------------------------------
;; LateX
;;----------------------------------------------------------------------------------

;; this is internal variable
;; (setq texmathp-environments '("equation" "eqnarray" "eqnarray*" "math" "displaymat..." "minipage" "align"))


;; cdlatex-sub-superscript
;; (texmathp-match-environment 4)
;; 正确的方式其实应该是 custom texmathp-tex-commands
(setq texmathp-tex-commands-default '(("$$" sw-toggle)
                                      ("$" sw-toggle)
                                      ("\\hbox" arg-off)
                                      ("\\vbox" arg-off)
                                      ("\\vtop" arg-off)
                                      ("\\vcenter" arg-off)
                                      ("equation" env-on)
                                      ("eqnarray" env-on)
                                      ("eqnarray*" env-on)
                                      ("math" env-on)
                                      ("displaymath" env-on)
                                      ("minipage" env-off)
                                      ("\\fbox" arg-off)
                                      ("\\mbox" arg-off)
                                      ("\\framebox" arg-off)
                                      ("\\label" arg-off)
                                      ("\\textrm" arg-off)
                                      ("\\(" sw-on)
                                      ("\\)" sw-off)
                                      ("\\[" sw-on)
                                      ("\\]" sw-off)
                                      ("\\ensuremath" arg-on)
                                      ("align" env-on)
                                      )
      )

'(texmathp-tex-commands '(("align" env-on))

                        )


'(org-format-latex-options
  '(:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                ("begin" "$1" "$" "$$" "\\(" "\\[")))

;; 支持 org-mode LaTex 异步预览，Buffer 全部预览
(require-package 'texfrag)
(texfrag-global-mode)

;; keymap
;; recover: C-<RET>     (org-insert-heading-respect-content)
(define-key cua-global-keymap (kbd "C-<return>") nil)


;; behavior
;; auto-save when focus-out
;;(add-hook 'focus-out-hook (lambda () (interactive) (save-some-buffers t)))



(require-package 'doom-themes)

;; (require-package 'helm)


(require-package 'fzf)
(autoload 'fzf/start "fzf")
;; -------------------------------------------
;; find my-note (fzf)
;; -------------------------------------------

;; Info Key Bindings 49.3.7 Modifier Keys
;; super, hyper
(defun find-note ()
  (interactive)
  ;; when used in home folder, counsel-fzf is too slow, and sometimes hanging
  ;;  (counsel-fzf nil "~/OneDrive/MyNote/")
  (fzf/start "~/OneDrive/MyNote/")
  )
(global-set-key (kbd "s-p") 'find-note)

;; -------------------------------------------
;; find my-note
;; -------------------------------------------



;; 解决 ATTR_ORG 设置图片大小不生效的问题
;; [[https://emacs.stackexchange.com/questions/26363/downscaling-inline-images-in-org-mode][Downscaling inline images in org-mode - Emacs Stack Exchange]]
(setq org-image-actual-width nil)


;; Latex Export PDF Chinese Support
;; should work with HEADER
(setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f"
                              "xelatex -interaction nonstopmode %f"))

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

(setq org-download-image-attr-list '("#+ATTR_HTML: width=\"600px\"\n#+ATTR_ORG: :width 600"))
;;----------------------------------------------------------------------------------
;;org-download
;;----------------------------------------------------------------------------------

;;----------------------------------------------------------------------------------
;; accelerate
;;----------------------------------------------------------------------------------
(load-file "/Users/ludwigws/.config/emacs/private/accelerate.el/accelerate.el")
(accelerate previous-line 2)
(accelerate next-line 2)
;;----------------------------------------------------------------------------------
;; accelerate
;;----------------------------------------------------------------------------------


(load-theme 'doom-gruvbox-light)

;;----------------------------------------------------------------------------------
;; snippets
;;----------------------------------------------------------------------------------
(require-package 'yasnippet)
(require-package 'yasnippet-snippets)
(yas-global-mode)

(setq hippie-expand-try-functions-list '(try-complete-file-name-partially try-complete-file-name try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill yas-hippie-try-expand))

(global-set-key (kbd "s-/") 'hippie-expand)
;;----------------------------------------------------------------------------------
;; snippets
;;----------------------------------------------------------------------------------



(global-hl-line-mode 1)


;; (custom-set-variables
;;  '(markdown-command "/usr/local/bin/pandoc"))


;;TODO 历史记录，保证 Emacs 异常退出时候文件保留
;;----------------------------------------------------------------------------------
;; undo-tree
;;----------------------------------------------------------------------------------
(require-package 'undo-tree)
(global-undo-tree-mode)
;;----------------------------------------------------------------------------------
;; undo-tree
;;----------------------------------------------------------------------------------


;; Layouts
;; Sessions




(provide 'init-local)

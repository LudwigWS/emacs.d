(require-package 'use-package)

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

(setq texmathp-tex-commands '(("align" env-on)
                              ("flalign*" env-on)
                              )
      )


;; LaTex fragment 更大的预览图片
(setq org-format-latex-options
      '(:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                    ("begin" "$1" "$" "$$" "\\(" "\\[")))

;; 支持 org-mode LaTex 异步预览，Buffer 全部预览
;; 使用 preview 的方式
;; orgmode export default use MathJax, If installed texfrag package, even not require it,
;; eqaution in html will become png image.
;; see [[https://orgmode.org/manual/Math-formatting-in-HTML-export.html#Math-formatting-in-HTML-export][Math formatting in HTML export (The Org Manual)]]
;; thanks god, it has the way to get all benifit between them.
;; see Org Mode Manual
;; #+OPTIONS: tex:t
;; Do the right thing automatically (MathJax)
(require-package 'texfrag)
(texfrag-global-mode)
;;(set-default 'preview-default-document-pt 12)
;; (set-default 'preview-scale-function 1.2)


(require-package 'org-drill)
(require 'org-drill)
(require-package 'anki-editor)

;; install package org-plus-contrib
;; run package-refresh-contents first
;; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; (require-package 'org-plus-contrib)





;; --------------------------------------------------------
;; org-roam
;; TODO deft
;; --------------------------------------------------------
;; @see [Installing from MELPA (Org-roam User Manual)](https://www.orgroam.com/manual/Installing-from-MELPA.html#Installing-from-MELPA)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(require-package 'org-roam)
(setq org-roam-directory "~/OneDrive/MyNote/")
(add-hook 'after-init-hook 'org-roam-mode)
(setq org-default-notes-file "~/OneDrive/MyNote/.notes.org")

;; @see [[https://github.com/org-roam/org-roam-server#installation][org-roam/org-roam-server: A Web Application to Visualize the Org-Roam Database]]
(use-package org-roam-server
  :ensure t
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

;; @see [[https://www.orgroam.com/manual/Installation-_00281_0029.html#Installation-_00281_0029][Installation (1) (Org-roam User Manual)]]
(require 'org-roam-protocol)

(use-package company-org-roam
  :ensure t
  :config
  (push 'company-org-roam company-backends))


;; 实现网页内容摘录
;; [[https://www.zmonster.me/2020/06/27/org-roam-introduction.html][使用 org-roam 构建自己的知识网络 · ZMonster's Blog]]
(add-to-list 'org-roam-capture-ref-templates
             '("a" "Annotation" plain (function org-roam-capture--get-point)
               "%U ${body}\n"
               :file-name "${slug}"
               :head "#+title: ${title}\n#+roam_key: ${ref}\n#+roam_alias:\n"
               :immediate-finish t
               :unnarrowed t))
;; --------------------------------------------------------
;; org-roam
;; --------------------------------------------------------

(require-package 'org-journal)
(use-package org-journal
  :bind
  ("C-c n j" . org-journal-new-entry)
  :custom
  (org-journal-date-prefix "#+title: ")
  (org-journal-file-format "%Y-%m-%d.org")
  (org-journal-dir org-roam-directory)
  (org-journal-date-format "%A, %d %B %Y"))

;; --------------------------------------------------------
;; org-roam-bibtex
;; org-roam-bibtex is a library which offers a tighter integration between org-roam, helm-bibtex, and org-ref.
;; --------------------------------------------------------
(require-package 'org-roam-bibtex)
(require-package 'ivy-bibtex)
(require-package 'org-ref)
(use-package org-roam-bibtex
  :after org-roam
  ;;   :load-path "~/projects/org-roam-bibtex/" ;Modify with your own path
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :bind (:map org-mode-map
              (("C-c n a" . orb-note-actions))))
;; --------------------------------------------------------
;; org-roam-bibtex
;; --------------------------------------------------------


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


;; (load-theme 'doom-gruvbox-light)
(load-theme 'doom-solarized-light t)

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


;; [[https://github.com/manateelazycat/thing-edit][manateelazycat/thing-edit: Copy and paste anything under cursor.]]
(load-file "/Users/ludwigws/.config/emacs/private/packages/thing-edit/thing-edit.el")
(require 'thing-edit)



(defun eudic-translate-at-point ()
  (interactive)
  (let* ((word (thing-at-point 'word))) ;; or 'symbol
    (message word)
    (do-applescript
     (concat
      "on run\n"
      "set theQuery to "
      "\""
      word
      "\"\n"
      "tell Applications \"Eudic\"\n"
      "activate\n"
      "show dic with word theQuery\n"
      "end tell\n"
      "end run"
      )
     )
    ))

;; [[https://github.com/lorniu/go-translate][lorniu/go-translate: Improved Google Translate interface with asynchronous request and better user experience.]]
(require-package 'go-translate)
(setq go-translate-base-url "https://translate.google.cn")
(setq go-translate-local-language "zh-CN")


;; (push (list 'company-capf 'company-org-roam ) company-backends)


(provide 'init-local)

(require-package 'use-package)

(require-package 'reveal-in-osx-finder)


;; [[https://emacs.stackexchange.com/questions/41220/org-mode-disable-indentation-when-promoting-and-demoting-trees-subtrees][Org-mode : disable indentation when promoting and demoting trees + subtrees - Emacs Stack Exchange]]
(setq org-adapt-indentation nil)



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


;; [[https://www.orgroam.com/manual/mathpixel.html#mathpixel][mathpixel (Org-roam User Manual)]]
;; (use-package mathpix.el
;;   :straight (:host github :repo "jethrokuan/mathpix.el")
;;   :custom ((mathpix-app-id "app-id")
;;            (mathpix-app-key "app-key"))
;;   :bind
;;   ("C-x m" . mathpix-screenshot))





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

(setq reftex-default-bibliography '("~/OneDrive/MyNote/bibliography/references.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/OneDrive/MyNote/bibliography/notes.org"
      org-ref-default-bibliography '("~/OneDrive/MyNote/bibliography/references.bib")
      org-ref-pdf-directory "~/OneDrive/MyNote/bibliography/bibtex-pdfs/")

;; If you use helm-bibtex as the citation key completion method you should set these variables too.

;; (setq bibtex-completion-bibliography "~/Dropbox/bibliography/references.bib"
;;       bibtex-completion-library-path "~/Dropbox/bibliography/bibtex-pdfs"
;;       bibtex-completion-notes-path "~/Dropbox/bibliography/helm-bibtex-notes")

;; open pdf with system pdf viewer (works on mac)
(setq bibtex-completion-pdf-open-function
      (lambda (fpath)
        (start-process "open" "*open*" "open" fpath)))

;; alternative
;; (setq bibtex-completion-pdf-open-function 'org-open-file)

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


;; (setq company-idle-delay 0
;;       company-minimum-prefix-length 0)
;; (push 'company-capf company-backends)



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



;; macOS prerequisite(maybe): brew install poppler automake
(use-package pdf-tools
  :ensure t
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-annot-activate-created-annotations t))


(use-package org-noter
  :after org
  :ensure t)




;;--------------------------
;; [[https://org-roam.discourse.group/t/update-a-field-last-modified-at-save/321/2][How can I create an Index file? - Troubleshooting - Org-roam]]
;; [[https://github.com/zaeph/.emacs.d/blob/4548c34d1965f4732d5df1f56134dc36b58f6577/init.el#L2822-L2875][.emacs.d/init.el at 4548c34d1965f4732d5df1f56134dc36b58f6577 · zaeph/.emacs.d]]
;; Handling file properties for ‘CREATED’ & ‘LAST_MODIFIED’
;;--------------------------

(defun zp/org-find-time-file-property (property &optional anywhere)
  "Return the position of the time file PROPERTY if it exists.
When ANYWHERE is non-nil, search beyond the preamble."
  (save-excursion
    (goto-char (point-min))
    (let ((first-heading
           (save-excursion
             (re-search-forward org-outline-regexp-bol nil t))))
      (when (re-search-forward (format "^#\\+%s:" property)
                               (if anywhere nil first-heading)
                               t)
        (point)))))

(defun zp/org-has-time-file-property-p (property &optional anywhere)
  "Return the position of time file PROPERTY if it is defined.
As a special case, return -1 if the time file PROPERTY exists but
is not defined."
  (when-let ((pos (zp/org-find-time-file-property property anywhere)))
    (save-excursion
      (goto-char pos)
      (if (and (looking-at-p " ")
               (progn (forward-char)
                      (org-at-timestamp-p 'lax)))
          pos
        -1))))

(defun zp/org-set-time-file-property (property &optional anywhere pos)
  "Set the time file PROPERTY in the preamble.
When ANYWHERE is non-nil, search beyond the preamble.
If the position of the file PROPERTY has already been computed,
it can be passed in POS."
  (when-let ((pos (or pos
                      (zp/org-find-time-file-property property))))
    (save-excursion
      (goto-char pos)
      (if (looking-at-p " ")
          (forward-char)
        (insert " "))
      (delete-region (point) (line-end-position))
      (let* ((now (format-time-string "[%Y-%m-%d %a %H:%M]")))
        (insert now)))))

(defun zp/org-set-last-modified ()
  "Update the LAST_MODIFIED file property in the preamble."
  (when (derived-mode-p 'org-mode)
    (zp/org-set-time-file-property "LAST_MODIFIED")))

(use-package org
  :hook (before-save . zp/org-set-last-modified))



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


;; 可以省略 \n"
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


;; (add-to-list 'load-path "~/.emacs.d/private/packages/omnifocus-capture")
(load "~/.emacs.d/private/packages/omnifocus-capture/omnifocus-capture.el")


(load "~/.emacs.d/private/packages/git-complete/git-complete.el")

(setenv "NODE_PATH" "/Users/ludwigws/.nvm/versions/node/v10.22.0/lib/node_modules")
(use-package jieba
  :load-path "~/.emacs.d/private/packages/jieba.el"
  :commands jieba-mode
  :init (jieba-mode))


(provide 'init-local)

;;; ~/.config/doom/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Chen Li"
      user-mail-address "czxyl@protonmail.com"
      epa-file-encrypt-to user-mail-address

      ;; Line numbers are pretty slow all around. The performance boost of
      ;; disabling them outweighs the utility of always keeping them on.
      display-line-numbers-type nil

      ;; On-demand code completion. I really need it.
      company-idle-delay 0

      ;; lsp-ui-sideline is redundant with eldoc and much more invasive, so
      ;; disable it by default.
      lsp-ui-sideline-enable nil
      lsp-enable-indentation nil
      lsp-enable-on-type-formatting nil
      lsp-enable-symbol-highlighting nil
      lsp-enable-file-watchers nil

      ;; Disable help mouse-overs for mode-line segments (i.e. :help-echo text).
      ;; They're generally unhelpful and only add confusing visual clutter.
      mode-line-default-help-echo nil
      show-help-function nil)


;;
;;; UI

;; TODO: adajust font according to display-pixels-per-inch
(setq doom-font (font-spec :family "monospace" :size (if (> (x-display-pixel-width) 1600) 22 12) :weight 'semi-light))

;;; Frames/Windows
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))


;;
;;; Keybinds

(map! :leader
      "h L" #'global-keycast-mode
      "f t" #'find-in-dotfiles
      "f T" #'browse-dotfiles)


;;
;;; Modules

;;; :completion ivy
(add-to-list 'ivy-re-builders-alist '(counsel-projectile-find-file . ivy--regex-plus))

;;; :ui doom-dashboard
;; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

;;; :editor evil
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;;; :tools direnv
(setq direnv-always-show-summary nil)

;;; :tools magit
(setq magit-repository-directories '(("~/projects" . 2))
      magit-save-repository-buffers nil
      ;; Don't restore the wconf after quitting magit
      magit-inhibit-save-previous-winconf t
      ;; transient-values '((magit-commit "--gpg-sign=0E271AE90CF21E77 ")
      ;;                    (magit-rebase "--autosquash" "--gpg-sign=0E271AE90CF21E77")
      ;;                    (magit-pull "--rebase" "--gpg-sign=0E271AE90CF21E77"))
      )

;;; :lang org
(setq org-directory "~/projects/org/"
      org-archive-location (concat org-directory "archive/%s::")
      org-ellipsis " ▼ "
      org-bullets-bullet-list '("☰" "☱" "☲" "☳" "☴" "☵" "☶" "☷" "☷" "☷" "☷"))

;;
;;; config
(defun dotfiles-hook ()
  "If the current buffer is '~/.dotfiles.org' the code-blocks are
       tangled."
  (when (equal (buffer-file-name)
               (expand-file-name (concat doom-private-dir
                                         "/config.org")))
    (org-babel-tangle)))

(add-hook 'after-save-hook 'dotfiles-hook)

(use-package! liberime-config
  :init
  (add-hook 'liberime-after-start-hook
            (lambda ()
              (liberime-select-schema "luna_pinyin_simp")))
  )


(use-package! pyim
  :after liberime-config
  :config
  (setq default-input-method "pyim")
  (setq pyim-default-scheme 'rime)
  (setq pyim-page-length 9)
  (setq pyim-page-tooltip 'posframe)
  )

(use-package! ccls
  :hook ((c-mode-local-vars c-mode c++-mode-local-vars objc-mode-local-vars) . (lambda ()(require'ccls)(lsp)))
  :config
  (add-hook 'lsp-after-open-hook #'ccls-code-lens-mode)
  (setq ccls-executable "~/projects/github/ccls/Release/ccls")
  (setq ccls-sem-highlight-method 'overlay)
  (ccls-use-default-rainbow-sem-highlight)
  (evil-set-initial-state 'ccls-tree-mode 'emacs)
  )

(after! projectile
  (add-to-list 'projectile-globally-ignored-directories ".ccls-cache"))

(after! lsp-mode
  (setq lsp-auto-guess-root t lsp-eldoc-prefer-signature-help nil)
  ;; (setq lsp-enable-links nil)
  (setq lsp-enable-file-watchers nil)
  (setq lsp-keep-workspace-alive nil)
  )

(add-to-list 'org-modules 'org-protocol t)

(use-package! org-protocol
  :config
  (add-to-list 'org-capture-templates
               '("w" "org-protocol" entry (file "~/projects/org/refile.org")
                 "* TODO Review %a\n%U\n%:initial\n" :immediate-finish t))
  (setq org-protocol-default-template-key "w")
  )

(after! deft
  (setq deft-directory (expand-file-name "deft/" org-directory)))

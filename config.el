;; ;; private/my/config.el -*- lexical-binding: t; -*-


(setq doom-localleader-key ";")

 
(load! "+bindings")
(load! "+org")
(load! "+ui")

(setq doom-scratch-buffer-major-mode 'emacs-lisp-mode)
(after! doom-themes
  :init
  ;; (setq doom-theme 'doom-nord-light)
  ;; (setq doom-theme 'doom-dracula)
  (setq doom-theme 'doom-tomorrow-day)
  )
  ;; (setq doom-theme 'doom-one))

(def-package! avy
  :commands (avy-goto-char-timer)
  :init
  (setq avy-timeout-seconds 0.2)
  (setq avy-all-windows t)
  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?q ?w ?e ?r ?u ?i ?o ?p))
  )

(after! company
  (setq company-minimum-prefix-length 2
        company-quickhelp-delay nil
        company-show-numbers t
        ))

(def-package! company-lsp
  :after company
  :config
  ;; (add-hook 'java-mode-hook (lambda () (push 'company-lsp company-backends)))
  ;; (push 'java-mode company-global-modes)
  (setq company-transformers nil company-lsp-cache-candidates nil)
  )


(after! flycheck
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  )


(def-package! lispy
  :hook ( (emacs-lisp-mode scheme-mode racket-mode) . lispy-mode)
  :config
  (lispy-set-key-theme '(special paredit c-digits))
  (setq lispy-outline "^;; \\(?:;[^#]\\|\\*+\\)"
        lispy-outline-header ";; "
        lispy-ignore-whitespace t))

;; Also use lispyville in prog-mode for [ ] < >
(def-package! lispyville
  :demand t
  :after (evil)
  :hook (lispy-mode . lispyville-mode))

(def-package! lsp-mode
  :defer t
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (setq lsp-project-blacklist '("/CC/"))
  (setq lsp--json-array-use-vector t)
  )

(def-package! lsp-ui
  :demand t
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq
   lsp-ui-sideline-enable nil
   lsp-ui-sideline-ignore-duplicate t
   lsp-ui-doc-header nil
   lsp-ui-doc-include-signature nil
   ;; lsp-ui-doc-background (doom-color 'base4)
   ;; lsp-ui-doc-border (doom-color 'fg)

   lsp-ui-peek-force-fontify nil
   lsp-ui-peek-expand-function (lambda (xs) (mapcar #'car xs)))
 )

(def-package! lsp-rust
  :init (add-hook 'rust-mode-hook #'lsp-rust-enable)
  :config
  (set-company-backend! 'rust-mode 'company-lsp))



(def-package! eglot
  :init
  ;; (add-hook 'haskell-mode-hook 'eglot-ensure)
  ;; (add-hook 'c++-mode-hook 'eglot-ensure)
  ;; (add-hook 'ruby-mode-hook 'eglot-ensure)
  ;; (add-hook 'python-mode-hook 'eglot-ensure)
  ;; (add-hook 'java-mode-hook 'eglot-ensure)
  (add-hook 'kotlin-mode-hook 'eglot-ensure))
;; (add-hook 'haskell-mode-hook 'flycheck-mode)
                                        ;(add-to-list 'company-backends 'company-ghc)

;;                                         ;(set-company-backend! 'haskell-mode
;;                                         ;  'company-ghc)
;; (set-company-backend! 'emacs-lisp-mode
;;   'company-elisp)
;; (set-company-backend! 'ruby-mode
;;   'company-lsp)

;; ;; (set-company-backend! 'haskell-mode 'company-lsp)
;; ;; (set-company-backend! 'ruby-mode
;; ;;   'company-elisp)

(after! haskell-mode
  (require 'lsp-ui )
  (require 'lsp-haskell)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (add-hook 'haskell-mode-hook #'lsp-haskell-enable)
  (add-hook 'haskell-mode-hook 'flycheck-mode))


 (def-package! nand2tetris
   :load-path "~/dev/nand2tetris"
   :defer t
   :config
                                         ;(add-to-list 'company-backends 'company-nand2tetris)
   (set-company-backend! 'nand2tetris-mode
     'company-nand2tetris)
   )

;; (add-hook 'java-mode-hook  'lsp-java-enable)

;; (def-package! lsp-ruby
;;   :init
;;   (add-hook 'ruby-mode-hook #'lsp-ruby-enable)
;;   :config
;;   (setq lsp-hover-text-function 'lsp--text-document-signature-help)
;;   )



;; (def-package! lsp-python
;;   :after lsp-mode
;;   :config
;;   (add-hook 'python-mode-hook #'lsp-python-enable)
;;   )


;; (advice-add 'eldoc-display-message-p :override 'my/eldoc-display-message-p)

;; (set-company-backend! 'c++-mode
;;      'company-lsp)
;; (def-package! lsp-racket
;;  :config
;;  :after lsp-mode
;;  (add-hook 'racket-mode-hook #'lsp-racket-enable))


(require 'edit-server)
(edit-server-start)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;; (after! ccls
;;       (map!
;;        :map c++-mode-map
;;        :leader
;        :desc "Include header and format buffer" :nv "ih" (lambda! (my/cpp-auto-include))) )


(def-package! sml-mode
  :defer t
  :config
  (require 'company-sml)
  (add-hook 'company-sml 'company-sml-setup)
  (set-company-backend! 'sml-mode
    'company-keywords)
  )

(set-docset! 'js2-mode "JavaScript" "JQuery")
(set-docset! 'haskell-mode "Haskell")

(set-docset! 'c++-mode "C++" "Boost")
(set-docset! 'css-mode "Css" "Html")
(set-docset! 'html-mode "Html" "Css")

;; (require 'exwm)
;; (require 'exwm-config)
;; (exwm-config-default)

(define-fringe-bitmap 'flycheck-fringe-bitmap-ball
	(vector #b00000000
		#b00000000
		#b00000000
		#b00000000
		#b00000000
		#b00111000
		#b01111100
		#b11111110
		#b11111110
		#b01111100
		#b00111000
		#b00000000
		#b00000000
		#b00000000
		#b00000000
		#b00000000
		#b00000000))
(after! flycheck
  :config
  (flycheck-define-error-level 'error
	  :severity 100
	  :compilation-level 2
	  :overlay-category 'flycheck-error-overlay
	  :fringe-bitmap 'flycheck-fringe-bitmap-ball
	  :fringe-face 'flycheck-fringe-error
	  :error-list-face 'flycheck-error-list-error))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium")
(setq helm-dash-browser-func 'browse-url-generic)

(setq elfeed-show-mode-hook
      (lambda ()
	(set-face-attribute 'variable-pitch (selected-frame) :font (font-spec :family "Iosevka" :size 17))
	(setq fill-column 120)
	(setq elfeed-show-entry-switch #'my-show-elfeed)))

(defun my-show-elfeed (buffer)
  (with-current-buffer buffer
    (setq buffer-read-only nil)
    (goto-char (point-min))
    (re-search-forward "\n\n")
    (fill-individual-paragraphs (point) (point-max))
    (setq buffer-read-only t))
  (switch-to-buffer buffer))

(after! elfeed
  (setq elfeed-search-filter "@8-year-ago ")
)

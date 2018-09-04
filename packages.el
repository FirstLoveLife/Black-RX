;; -*- no-byte-compile: t; -*-
;;; private/my/packages.el
(disable-packages!  company-irony company-irony-c-headers flycheck-irony irony irony-eldoc ivy-rtags rtags)
;(package! auto-save  :recipe (:fetcher wiki))
(package! avy)
(package! ag)
(package! anki-editor)
(package! cmake-mode)
(package! flycheck-clang-tidy)
(package! lispyville)
(package! lsp-mode)
(package! flycheck-clang-analyzer)
(package! lsp-ui)
(package! lsp-haskell)
(package! company-lsp)
(package! company-ghc)
(package! nand2tetris)

(package! format-all :recipe (:fetcher github :repo "lassik/emacs-format-all-the-code" :files ("*")))

(package! link-hint)
(package! sicp)

(package! rust-mode)
(package! lsp-rust)

(package! function-args)
(package! lpy :recipe (:fetcher github :repo "abo-abo/lpy" :files ("*")))
(package! aweshell :recipe (:fetcher github :repo "manateelazycat/aweshell" :files ("*")))

(package! emacs-cpp-auto-include :recipe (:fetcher github :repo "FirstLoveLife/emacs-cpp-auto-include" :files ("*")))

;(package! pyim-greatdict :recipe (:repo "tumashu/pyim-greatdict" :fetcher github :files ("*")))
(package! company)
(package! edit-server)
;(package! eaf :recipe (:repo "manateelazycat/emacs-application-framework" :fetcher github :files ("*")))
(package! ccls)
;(package! multi-term)
(package! posframe)
(package! pyim)
(package! pyim-basedict)

(package! yasnippet-classic-snippets)
(package! yasnippet-snippets)
(disable-packages! irony eww rtags)

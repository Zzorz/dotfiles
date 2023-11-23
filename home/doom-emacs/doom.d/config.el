;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; 用户名和邮件信息
(setq user-full-name "yangtiangang"
      user-mail-address "")

;; 设置emacs字体
(setq doom-font (font-spec :family "Sarasa Mono SC Nerd" :size 18 ))

;; 主题
;;(setq doom-theme 'doom-henna)
(setq doom-theme 'doom-material)

;; org文件默认目录
(setq org-directory "~/org/")

;; 相对行号
(setq display-line-numbers-type 'relative)


;; (use-package! highlight-parentheses
;;   :diminish highlight-parentheses-mode
;;   :init (add-hook 'prog-mode-hook #'highlight-parentheses-mode)
;;   :config (set-face-attribute 'hl-paren-face nil :weight 'ultra-bold))

;; expand-reaion配置
;;(use-package! expand-region
;;  :config
;;  (define-key evil-visual-state-map "v" #'er/expand-region)
;;  (define-key evil-visual-state-map "\C-v" #'er/contract-region))

;; ;; undo-tree配置
;; (use-package! undo-tree
;;  :init (add-hook 'prog-mode-hook #'undo-tree-mode))

;; 高亮当前光标下的symbol,同时支持lsp-mode以及非lsp-mode
;; (use-package! symbol-overlay
;;   :init (add-hook 'prog-mode-hook #'symbol-overlay-mode))


;; (use-package! company
;;   :config (setq company-idle-delay 0.1
;;                 company-minimum-prefix-length 2))

;; (use-package! company-quickhelp
;;   :init (add-hook 'prog-mode-hook #'company-quickhelp-mode)
;;   :config (setq company-quickhelp-delay 0.1
;;                 company-quickhelp-use-propertized-text t))
;;
;; (use-package! lsp-ui
;;   :init (add-hook 'prog-mode-hook #'lsp-ui-doc-mode)
;;   :config
;;   (setq lsp-ui-sideline-show-code-actions t)
;;   (setq lsp-ui-sideline-show-hover t)
;;   (setq lsp-ui-doc-show-with-cursor t)
;;   (setq lsp-ui-doc-delay 1.5)
;;   )
;; (use-package! lsp-mode
;;   :config
;;   (setq lsp-vetur-format-options-tab-size 4)
;; )
;; (use-package! highlight-indent-guides
;;   :config
;;   (setq highlight-indent-guides-method 'column)
;; )

;; (use-package! lsp-mode
;;   :config
;;   (setq lsp-enable-folding t))

;; (add-to-list 'load-path "~/.emacs.d/emacs-application-framework/")
;; (require 'eaf)
;; (add-to-list 'load-path "~/.emacs.d/emacs-application-framework/app/browser")
;; (require 'eaf-browser)
;; (setq rcirc-server-alist
;;              '(("irc.libera.chat"
;;                :port 6697
;;                :nick "razyang"
;;                :channels ("#archlinux-cn"))))
;; (setq rcirc-authinfo '(
;;                        ("libera.chat" sasl "razyang" "razyang.orz")
;;                        ))

(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

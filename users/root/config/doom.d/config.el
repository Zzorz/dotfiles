;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; 用户名和邮件信息
(setq user-full-name "RazYang"
      user-mail-address "")

;; 设置emacs字体
(setq doom-font (font-spec :family "monospace" :size 18 ))

;; 主题
(setq doom-theme 'doom-ephemeral)
;;srcery

;; org文件默认目录
(setq org-directory "~/org/")

;; 相对行号
(setq display-line-numbers-type 'relative)


(use-package! highlight-parentheses
  :diminish highlight-parentheses-mode
  :init (add-hook 'prog-mode-hook #'highlight-parentheses-mode)
  :config (set-face-attribute 'hl-paren-face nil :weight 'ultra-bold))

;; expand-reaion配置
(use-package! expand-region
  :config
  (define-key evil-visual-state-map "v" #'er/expand-region)
  (define-key evil-visual-state-map "\C-v" #'er/contract-region))

;; undo-tree配置
(use-package! undo-tree
  :init (add-hook 'prog-mode-hook #'undo-tree-mode))

;; 高亮当前光标下的symbol,同时支持lsp-mode以及非lsp-mode
(use-package! symbol-overlay
  :init (add-hook 'prog-mode-hook #'symbol-overlay-mode))


(use-package! company
  :config (setq company-idle-delay 0.1
                company-minimum-prefix-length 2))

(use-package! company-quickhelp
  :init (add-hook 'prog-mode-hook #'company-quickhelp-mode)
  :config (setq company-quickhelp-delay 0.1
                company-quickhelp-use-propertized-text t))

(use-package! lsp-ui
  :init (add-hook 'prog-mode-hook #'lsp-ui-doc-mode)
  :config
  (setq lsp-ui-doc-frame-parameters
    '((vertical-scroll-bars . t)))
  (setq lsp-ui-sideline-show-hover t))

(use-package! lsp-mode
  :config
  (setq lsp-enable-symbol-highlighting nil))

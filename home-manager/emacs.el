;; remove stupid defaults
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

;; escape to escape
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; configure use-package to use straight.el
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq use-package-always-ensure t)

;; completion: ivy + counsel
(use-package ivy
  :diminish
  :bind
  (("C-s" . swiper)
   :map ivy-minibuffer-map
   ("TAB" . ivy-alt-done)
   ("C-l" . ivy-alt-done)
   ("C-j" . ivy-next-line)
   ("C-k" . ivy-previous-line)
   :map ivy-switch-buffer-map
   ("C-k" . ivy-previous-line)
   ("C-l" . ivy-done)
   ("C-d" . ivy-switch-buffer-kill)
   :map ivy-reverse-i-search-map
   ("C-k" . ivy-previous-line)
   ("C-d" . ivy-switch-buffer-kill))
  :init
  (ivy-mode 1))

(use-package counsel
  :bind
  (("M-x" . counsel-M-x)
   ("C-x b" . counsel-ibuffer)
   ("C-x C-f" . counsel-find-file)
   :map minibuffer-local-map
   ("C-r" . 'counsel-minibuffer-history)))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; visual changes
(set-fringe-mode 10)
(setq visible-bell t)

(set-face-attribute 'default nil :font "Fira Code" :height 120)

(use-package doom-themes
  :config
  (setq doom-themes-enabl-bold t
	doom-themes-enable-italic t)
  ;; (load-theme 'doom-tomorrow-night t)
  (load-theme 'doom-palenight t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package all-the-icons)

(use-package doom-modeline
  :config
  (doom-modeline-mode 1))

;; Rainbow delimiters
(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

;; Linenumbers almost always
(column-number-mode)
(global-display-line-numbers-mode t)
(dolist (mode '(org-mode-hook
	        term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Which key
(use-package which-key
  :init
  (which-key-mode)
  :diminish
  :config
  (setq which-key-idle-delay 0.3))

;; helpful
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; evil
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  ;; :hook
  ;; (evil-mode . rune/evil-hook)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use viual line motions outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; hydra?
;; (limited contexts for keybindings)

;; general
(use-package general
  :config
  (general-create-definer spc-leader
    :states '(normal visual insert emacs)
    :keymaps 'override
    :prefix "SPC"
    :non-normal-prefix "C-SPC")
  (spc-leader
    "w" 'evil-window-map
    "." 'counsel-find-file
    "," 'counsel-ibuffer
    "SPC" 'projectile-command-map))

;; projectile
(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode)
  :custom
  ((projectile-completion-system 'ivy))
  :init
  ;; (when (file-directory-p "~/root-for-all-code")
  ;;   (setq projectile-project-search-path '("~/root-for-all-code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config
  (counsel-projectile-mode))

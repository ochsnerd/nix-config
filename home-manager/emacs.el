;; remove stupid defaults
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

;; visual changes
(set-fringe-mode 10)
(setq visible-bell t)

(set-face-attribute 'default nil :font "Fira Code" :height 120)

(load-theme 'tango-dark)

;; escape to escape
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


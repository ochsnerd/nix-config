;;; ...  -*- lexical-binding: t -*-

(delete-file "~/.config/emacs/config.el") ;; force retangle
(require 'org)
(org-babel-load-file "~/.config/emacs/config.org")

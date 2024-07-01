;;; early-init.el --- Early initialization -*- lexical-binding: t -*-

;;; Commentary:

;; Emacs 27 introduces `early-init.el', which is run before `init.el',
;; before package and UI initialization happens.

;;; Code:

;; Package initialize occurs automatically, before `user-init-file' is
;; loaded, but after `early-init-file'.  We handle package
;; initialization, so we must prevent Emacs from doing it early!
(setq package-enable-at-startup nil)

;; Faster to disable these here (before they've been initialized)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(horizontal-scroll-bars) default-frame-alist)

;; It must be set before loading `use-package'.
(setq use-package-enable-imenu-support t)

(provide 'early-init)

;;; early-init.el ends here

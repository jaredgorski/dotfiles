(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(package-initialize)

;; Initial buffer
(setq initial-buffer-choice t)

;; Line numbers
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Ctags
(setq path-to-ctags "/usr/local/bin/ctags")

;; Large files
(setq large-file-warning-threshold nil)

;; Projectile
(unless (package-installed-p 'projectile)
  (package-install 'projectile))
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-switch-project-action 'helm-projectile)

;; Helm
(unless (package-installed-p 'helm)
  (package-install 'helm))
(require 'helm)
(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c C-f") 'helm-find)
(global-set-key (kbd "C-c C-p") 'helm-projectile)
(helm-mode 1)
(setq helm-mode-fuzzy-match t)
(setq helm-completion-in-region-fuzzy-match t)

;; Backup files 
(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/saves" t)))

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)

;; Evil Search
(setq evil-search-module 'evil-search)

;; Evil Commentary
(unless (package-installed-p 'evil-commentary)
  (package-install 'evil-commentary))
(evil-commentary-mode)

;; Shell
(setq explicit-shell-file-name "/usr/local/bin/zsh")
(setenv "SHELL" "zsh")

;; Org mode
(define-key global-map "\C-cc" 'org-capture)
(setq org-export-coding-system 'utf-8)

;; Custom-set-variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes '(nothing))
 '(custom-safe-themes
   '("8ecc63db23c4b608a2ba60974c8fe7a0f8c57d8563f83c5c126f002d6ae2d48e" "17fab8756a577f28b9ba90ddcfad7210fd10b637cba9c22765eeb5bb43efb3a0" "31e99002ac480f5ed41c282d0fdb119a8d10036a2e10962693d2895c48f5f4f4" "29b30ba6519702828e512125075e88060668298d60093b892dc629de0f6b82b0" "fb072754be2696fd76b21abf4b38eb6b01162939958f8907f5a201aff858b51c" "81c9738b6ecc00331c5cb7a5081e786d976db821a23cc9eeff2b0de5c72223a1" "1c753447a5e792590c29590f5665ea963358a81f392b49dfcce2013fb0d604e1" "2696a61735fdc06a1600d6f4aa3b9eb516b29ad5b227bfdc4f4a1116de878491" "facddff5e207ebf0fa8861cdad997097ed61817685d0e6a7fe874e0b8a2a9c13" "7a7074e4548817664410cfdf56f237606378cb4a5fbdfa55b45a187eb132beaf" "8f9f59bc7417ad7db58bd32b13095f2619d88ae55de0883fe17e9f9940e0c696" "2d6565c1fd78d577cd8d1731d08840c0e5d12ffb41021fdea24d1210778affaa" "0024393ca1a5461e3659fe06e2c4e43b8da5ee82142ef80049e696ef4afa43ca" "0c5775bde1f1ccdcb15491fd7fd8b3486420842c779d9f59970becb283fcaa7b" "ce33c811fb06d7b8e6d6986693872154b2bc77c36f9550581661be3eebc1a5fb" "91e1dd0fde533adcd72dded74b178f5b328fdc846b34ec64cb12448d0161cfc4" "074452af53e02ebbdcda31b35fee37b5e9dd3185142f913213f5cf587d840342" "5300abd2b57a4e8b7bcfbb0d16edff2a9d9a7f97f4bcda66d9a851c26bc7832f" "c008d0bef5fee80239564fc3c4bf32aef08146d3d06ca6aef033ccbf40bce250" "cbe748e039af76a08714edfdbf221cba34ecfe7f9ba422346cdf54f18265d677" "b567af5107bc30e643de27470b47899073457ee8f6c099ffbd2dfe95e4c0e33a" "2f4022d049f371acd9f39cb2b3beabfb298e019d2b55fd9bab76ca1ef4d37435" "3610078963482bc591b3ec691e1aee2b60f6d44d70d5ba76b97e11ecd7a1b1cf" default))
 '(helm-completion-style 'emacs)
 '(package-selected-packages
   '(helm-rg nothing-theme evil-commentary package-lint evil helm projectile)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 120 :family "Menlo")))))

;; -*- coding: utf-8 -*-
(defvar best-gc-cons-threshold 4000000 "Best default gc threshold value. Should't be too big.")
;; don't GC during startup to save time
(setq gc-cons-threshold most-positive-fixnum)

(setq emacs-load-start-time (current-time))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp"))

;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *is-a-mac* (eq system-type 'darwin))
(setq *win64* (eq system-type 'windows-nt) )
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *emacs24* (and (not (featurep 'xemacs)) (or (>= emacs-major-version 24))) )
(setq *no-memory* (cond
                   (*is-a-mac*
                    (< (string-to-number (nth 1 (split-string (shell-command-to-string "sysctl hw.physmem")))) 4000000000))
                   (*linux* nil)
                   (t nil)))

;; *Message* buffer should be writable in 24.4+
(defadvice switch-to-buffer (after switch-to-buffer-after-hack activate)
  (if (string= "*Messages*" (buffer-name))
	  (read-only-mode -1)))

;; Full name and email 
(setq user-full-name "Ye Qi-bin")
(setq user-mail-address "qibinye@hotmail.com")

;;Startup screen
(setq inibit-startup-screen t)
(setq initial-buffer-choice nil)
(setq initial-scratch-message ";; This is *scratch* buffer.\n\n")

;;;; 使用空格缩进
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-width 4)

(fset 'yes-or-no-p 'y-or-n-p)
;; 关闭 beep
(setq visible-bell t)

(define-key global-map (kbd "RET") 'newline-and-indent)

;; my own previous set up: yqb
(show-paren-mode t)
(auto-image-file-mode t);打开图片显示功能
(global-set-key [f5] 'shell);打开一个终端
(global-set-key [f6] 'ispell-word);F6拼写检查
(global-set-key [f7] 'calendar); 打开日历
(setq diary-file "~/.gtd/diary")
(add-hook 'text-mode-hook 'turn-on-auto-fill); text模式自动换行；
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'TeX-mode-hook 'turn-on-auto-fill)
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
(add-hook 'markdown-mode-hook 'turn-on-auto-fill)


;;; init.el --- user init file      -*- no-byte-compile: t -*-
(setq load-prefer-newer t)
(package-initialize)
(require 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

;;**********end of my previous setup******



(let ((file-name-handler-alist nil))
  (require 'init-modeline)
  (require 'cl-lib)
  (require 'init-compat)
  (require 'init-utils)
  (require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el

  (require 'idle-require)
  (require 'init-elpa)
  (require 'init-exec-path) ;; Set up $PATH
  (require 'init-frame-hooks)
  ;; any file use flyspell should be initialized after init-spelling.el
  ;; actually, I don't know which major-mode use flyspell.
;  (require 'init-spelling)
  (require 'init-myspell)
  (require 'init-xterm)
  (require 'init-gui-frames)
  (require 'init-ido)
  (require 'init-dired)
  (require 'init-uniquify)
  (require 'init-ibuffer)
  (require 'init-flymake)
  (require 'init-grammar)
  (require 'init-smex)
  (require 'init-ivy)
  (require 'init-hippie-expand)
  (require 'init-windows)
  (require 'init-sessions)
  (require 'init-git)
  (require 'init-crontab)
  (require 'init-markdown)
  (require 'init-erlang)
  (require 'init-javascript)
  (require 'init-org)
  (require 'init-org-mime)
  (require 'init-css)
  (require 'init-python-mode)
  (require 'init-haskell)
  (require 'init-ruby-mode)
  (require 'init-lisp)
  (require 'init-elisp)
  (require 'init-yasnippet)
  ;; Use bookmark instead
  (require 'init-zencoding-mode)
  (require 'init-cc-mode)
  (require 'init-gud)
  (require 'init-linum-mode)
  ;; (require 'init-gist)
  (require 'init-moz)
  (require 'init-gtags)
  ;; use evil mode (vi key binding)
  (require 'init-evil)
  (require 'init-sh)
  (require 'init-ctags)
  (require 'init-bbdb)
  (require 'init-gnus)
  (require 'init-lua-mode)
  (require 'init-workgroups2)
  (require 'init-term-mode)
  (require 'init-web-mode)
  (require 'init-slime)
  (require 'init-clipboard)
  (require 'init-company)
  (require 'init-chinese-pyim) ;; cannot be idle-required
  ;; need statistics of keyfreq asap
;  (require 'init-keyfreq)
  (require 'init-httpd)
  (require 'init-fonts)
  (require 'init-grammar)
  (require 'init-outline)
  ;; projectile costs 7% startup time

  ;; misc has some crucial tools I need immediately
  (require 'init-misc)
  (if (or (display-graphic-p) (string-match-p "256color"(getenv "TERM"))) (require 'init-color-theme))
  (require 'init-emacs-w3m)
  (require 'init-hydra)
  (require 'init-latex)
  (require 'init-dict)
  ;; {{ idle require other stuff
  (setq idle-require-idle-delay 3)
  (setq idle-require-symbols '(init-misc-lazy
                               init-which-func
 ;                              init-fonts
                               init-hs-minor-mode
                               init-textile
                               init-csv
                               init-writting
                               init-doxygen
                               init-pomodoro
                               init-emacspeak
                               init-artbollocks-mode
                               init-semantic))
;(idle-require-mode 1) ;; starts loading


  (when (require 'time-date nil t)
    (message "Emacs startup time: %d seconds."
             (time-to-seconds (time-since emacs-load-start-time))))

  ;;----------------------------------------------------------------------------
  ;; Locales (setting them earlier in this file doesn't work in X)
  ;;----------------------------------------------------------------------------
  (require 'init-locales)

  ;; my personal setup, other major-mode specific setup need it.
  ;; It's dependent on init-site-lisp.el
  (if (file-exists-p "~/.custom.el") (load-file "~/.custom.el"))
)

(setq custom-file (concat user-emacs-directory "custom-set-variables.el"))
(load custom-file 'noerror)
(setq gc-cons-threshold best-gc-cons-threshold)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cfs--current-profile "program" t)
 '(git-gutter:handled-backends (quote (svn hg git)))
 '(markdown-command
   "pandoc -f markdown -t html -s --mathjax=/home/yqb/Downloads/Software/MathJax/MathJax.js?config=TeX-MML-AM_CHTML --highlight-style pygments")
 '(org-emphasis-alist
   (quote
    (("/"
      (quote
       (italic :foreground "orange")))
     ("_"
      (quote
       (:underline t :foreground "yellow")))
     ("+"
      (quote
       (:foreground "LightSalmon" :strike-through t)))
     ("*"
      (quote
       (bold :foreground "#e50062")))
     ("=" org-verbatim verbatim)
     ("~" org-code verbatim))))
 '(session-use-package t nil (session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold))) t))

(setq gc-cons-threshold best-gc-cons-threshold)
;;; Local Variables 
;;; no-byte-compile: t
;;; End:
(put 'erase-buffer 'disabled nil)

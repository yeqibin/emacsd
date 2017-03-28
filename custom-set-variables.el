(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
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
 '(safe-local-variable-values (quote ((reftex-default-bibliography "../ref/refs.bib"))))
 '(session-use-package t nil (session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(window-numbering-face ((t (:foreground "DeepPink" :underline "DeepPink" :weight bold))) t))

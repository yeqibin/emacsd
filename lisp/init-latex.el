;(load "auctex.el" nil t t)
;(load "preview.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-source-correlate-start-server t)
(add-hook 'LaTeX-mode-hook
          (lambda()
            (add-to-list 'TeX-command-list
                         '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil t))
            (setq TeX-command-default "XeLaTeX")
            (setq TeX-save-query nil )
            (setq TeX-interactive-mode t)
            (setq TeX-fold-mode t)
            (setq outline-minor-mode t)
            (setq TeX-electric-escape nil)
            (setq TeX-show-compilation t)
            (setq TeX-source-correlate-mode t)
            (setq TeX-source-correlate-method 'synctex)))

(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'zotelo-minor-mode)

(setq TeX-PDF-mode t)
;; (setq TeX-engine 'xetex)
(setq LaTeX-syntactic-comments t)
;; (setq TeX-output-view-style
;;        (quote
;;         (("^pdf$" "." "okular %s.pdf")
;;          ("^html?$" "." "firefox %o"))))
(setq TeX-view-program-selection
      '((output-pdf "Okular")))

(setq TeX-fold-env-spec-list
      (quote (("[figure]" ("figure"))
              ("[table]" ("table"))
              ("[itemize]" ("itemize"))
              ("[overpic]" ("overpic"))
              )))
(setq reftex-plug-into-AUCTeX t)

(require writegood-mode)
(require 'cdlatex);;
;(require 'smartrens-latex)
(require 'company-auctex)
(company-auctex-init)


;(setq reftex-extra-bindings t)
										;(add-hook 'latex-mode-hook 'latex-math-mode)   ; with Emacs latex mode
;(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;;=================================================
;;;+     reftex-mode
;;=================================================

;(autoload 'reftex-mode     "reftex" "RefTeX Minor Mode" t)
;(autoload 'turn-on-reftex  "reftex" "RefTeX Minor Mode" nil)
;(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
;(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase mode" t)


;(define-key LaTeX-mode-map (kbd "C-c C-p") 'reftex-parse-all)
;(define-abbrev-table 'TeX-mode-abbrev-table (make-abbrev-table))
;(add-hook 'TeX-mode-hook (lambda ()
;			   (setq abbrev-mode t)
;			   (setq local-abbrev-table TeX-mode-abbrev-table)))

;(setq reftex-default-bibliography '("~/Dropbox/bibliography/refs.bib"))

(provide 'init-latex)

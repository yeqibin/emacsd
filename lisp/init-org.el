;; some cool org tricks
;; @see http://emacs.stackexchange.com/questions/13820/inline-verbatim-and-code-with-quotes-in-org-mode

(require 'org)
;; {{ NO spell check for embedded snippets

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-ck" 'org-capture)
(global-set-key (kbd "<f8>") 'org-capture)
(define-key global-map "\C-cb" 'org-iswitchb)

(require 'org-chinese-utils)
(ocus-enable)

(defun org-mode-is-code-snippet ()
  (let (rlt
        (begin-regexp "^[ \t]*#\\+begin_\\(src\\|html\\|latex\\)")
        (end-regexp "^[ \t]*#\\+end_\\(src\\|html\\|latex\\)")
        (old-flag case-fold-search)
        b e)
      (save-excursion
        (setq case-fold-search t)
        (setq b (re-search-backward begin-regexp nil t))
        (if b (setq e (re-search-forward end-regexp nil t)))
        (setq case-fold-search old-flag))
      (if (and b e (< (point) e)) (setq rlt t))
    rlt))

;; no spell check for property
(defun org-mode-current-line-is-property ()
  (let (cur-line)
    (setq cur-line (buffer-substring-no-properties
                    (line-beginning-position) (line-end-position)))
    ;; (message "cur-line=%s" cur-line)
    (string-match "^[ \t]+:[A-Z]+:[ \t]+" cur-line)))

;; Please note flyspell only use ispell-word
(defadvice org-mode-flyspell-verify (after org-mode-flyspell-verify-hack activate)
  (let ((run-spellcheck ad-return-value))
    (if ad-return-value
      (cond
       ((org-mode-is-code-snippet)
        (setq run-spellcheck nil))
       ((org-mode-current-line-is-property)
        (setq run-spellcheck nil))))
    (setq ad-return-value run-spellcheck)))
;; }}


;; Org-html publish style

(setq org-html-head-include-default-style nil)
(setq org-html-head "<link rel="stylesheet"
  href="/css/yqbnote-org-html.css" type="text/css" />")

;; Org v8 change log:
;; @see http://orgmode.org/worg/org-8.0.html
;; {{ export org-mode in Chinese into PDF
;; @see http://freizl.github.io/posts/tech/2012-04-06-export-orgmode-file-in-Chinese.html
;; and you need install texlive-xetex on different platforms
;; To install texlive-xetex:
;;    `sudo USE="cjk" emerge texlive-xetex` on Gentoo Linux

(setq org-latex-to-pdf-process ;; org v7
      '("xelatex -interaction nonstopmode -output-directory %o %f"
        "bibtex %b"
        ))
(setq org-latex-pdf-process org-latex-to-pdf-process) ;; org v8
;; }}
;; (setq org-file-apps
;;       '((auto-mode . emacs)
;;         ("\\.x?html?\\'" . "google-chrome-stable %s")
;;         ("\\.pdf\\'" . "evince \"%s\"")
;;         ("\\.pdf::\\([0-9]+\\)\\'" . "evince \"%s\" -p %1")
;;         ()
;;         ))
;;
(setq org-file-apps org-file-apps-defaults-gnu)

(defun my-setup-odt-org-convert-process ()
  (interactive)
  (let ((cmd "/Applications/LibreOffice.app/Contents/MacOS/soffice"))
    (when (and *is-a-mac* (file-exists-p cmd))
      ;; org v7
      (setq org-export-odt-convert-processes '(("LibreOffice" "/Applications/LibreOffice.app/Contents/MacOS/soffice --headless --convert-to %f%x --outdir %d %i")))
      ;; org v8
      (setq org-odt-convert-processes '(("LibreOffice" "/Applications/LibreOffice.app/Contents/MacOS/soffice --headless --convert-to %f%x --outdir %d %i"))))
    ))

(my-setup-odt-org-convert-process)

;; @see https://gist.github.com/mwfogleman/95cc60c87a9323876c6c
(defun narrow-or-widen-dwim ()
  "If the buffer is narrowed, it widens. Otherwise, it narrows to region, or Org subtree."
  (interactive)
  (cond ((buffer-narrowed-p) (widen))
        ((region-active-p) (narrow-to-region (region-beginning) (region-end)))
        ((equal major-mode 'org-mode) (org-narrow-to-subtree))
        (t (error "Please select a region to narrow to"))))

;; Various preferences
(setq org-log-done t
      org-directory "~/.gtd/"
      org-default-notes-file "~/.gtd/notes.org"
      org-agenda-files (list "~/.gtd/mygtd.org")
      org-completion-use-ido t
      org-edit-src-content-indentation 0
      org-edit-timestamp-down-means-later t
      org-agenda-start-on-weekday nil
      org-agenda-span 14
      org-agenda-include-diary t
      org-agenda-window-setup 'current-window
      org-fast-tag-selection-single-key 'expert
      org-export-kill-product-buffer-when-displayed t
      ;; org v7
      org-export-odt-preferred-output-format "doc"
      ;; org v8
      org-odt-preferred-output-format "doc"
      org-tags-column 80
      ;; org-startup-indented t
      ;; {{ org 8.2.6 has some performance issue. Here is the workaround.
      ;; @see http://punchagan.muse-amuse.in/posts/how-i-learnt-to-use-emacs-profiler.html
      org-agenda-inhibit-startup t ;; ~50x speedup
      org-agenda-use-tag-inheritance nil ;; 3-4x speedup
      ;; }}
      )
;; capture-templates
(setq org-capture-templates
      '(("s" "SweepMind" entry (file+headline "~/.gtd/mygtd.org" "SweepMind")
	  "* %^{SweepMind} %^g%? %i\n%u ")
      ("j" "Journal" entry (file+datetree "~/.gtd/journal.org")
       "* %? ")
      ("m" "Mistakes" entry (file+datetree "~/.gtd/mistakes.org")
       "* %? ")
      ("b" "BrainWash" entry (file+datetree "~/.gtd/brainwash.org")
          "* %? ")
      ("i" "Info2Rembr" entry (file "~/.gtd/info.org") "* %^{Sth to remember} %u \n %i%? ")
      ("n" "Note" entry (file "~/.gtd/notes.org") "* %^{Sth2Note} %u \n %i%? ")
   ))



;; Refile targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5))))
;; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
;; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)

(setq org-todo-keywords
      (quote ((sequence "ACTION(a)" "TODO(t)" "GOING(g)" "|" "DONE(d!/!)")
              (sequence "|" "YES(y!/!)" "NO(n!/!)")
              (sequence "WAITING(w@/!)" "SOMEDAY(S)" "PROJ(P@)" "|" "CANCLD(c@/!)"))))
(setq org-todo-keyword-faces
      (quote (("ACTION" . "yellow") 
              ("PROJ" . "blue") )))


(setq org-fontify-done-headline t)
;(set-face-attribute 'org-done nil :strike-through t)
;(set-face-attribute 'org-headline-done nil :strike-through t)
;(set-face-attribute 'org-agenda-done nil :strike-through t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org clock
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "STARTED")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Show the clocked-in task - if any - in the header line
(defun sanityinc/show-org-clock-in-header-line ()
  (setq-default header-line-format '((" " org-mode-line-string " "))))

(defun sanityinc/hide-org-clock-from-header-line ()
  (setq-default header-line-format nil))

(add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
(add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
(add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)

(eval-after-load 'org-clock
  '(progn
     (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
     (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu)))

(eval-after-load 'org
  '(progn
     (setq org-imenu-depth 9)
     (require 'org-clock)
     ;; @see http://irreal.org/blog/1
     (setq org-src-fontify-natively t)))

(defun org-mode-hook-setup ()
;  (setq evil-auto-indent nil)
  ;; org-mode's own flycheck will be loaded
  (enable-flyspell-mode-conditionally)

  ;; but I don't want to auto spell check when typing,
  ;; please comment out `(flyspell-mode -1)` if you prefer auto spell check
;  (flyspell-mode -1)

  ;; don't spell check double words
  (setq flyspell-check-doublon nil)

  ;; display wrapped lines instead of truncated lines
  (setq truncate-lines nil)
  (setq word-wrap t))
(add-hook 'org-mode-hook 'org-mode-hook-setup)

(defadvice org-open-at-point (around org-open-at-point-choose-browser activate)
  (let ((browse-url-browser-function
         (cond ((equal (ad-get-arg 0) '(4))
                'browse-url-generic)
               ((equal (ad-get-arg 0) '(16))
                'choose-browser)
               (t
                (lambda (url &optional new)
                  (w3m-browse-url url t))))))
    ad-do-it))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defadvice org-publish (around org-publish-advice activate)    ;;
;;   "Stop running major-mode hook when org-publish"              ;;
;;   (let ((old load-user-customized-major-mode-hook))            ;;
;; 	(setq load-user-customized-major-mode-hook nil)               ;;
;;     ad-do-it                                                   ;;
;; 	(setq load-user-customized-major-mode-hook old)))             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; highlight bold font with red color
;; (defface hi-red-b '((t (:foreground "#e50062"))) t)
;; (defun org-bold-highlight ()
;;   (interactive)
;;   (hi-lock-mode)
;;   (highlight-regexp "[ \\t]\\(\\*\\(\\S-[^*]+\\S-\\|[^*]\\{1,2\\}\\)\\*\\)[ \\t\\n]*" 'hi-red-b))
;; (add-hook 'org-mode-hook 'org-bold-highlight)

;; custom org emphasis color
(setq org-emphasis-alist
      (cons '("*" '(bold :foreground "#e50062"))
            (delete* "*" org-emphasis-alist :key 'car :test 'equal)))
(setq org-emphasis-alist
      (cons '("+" '(:foreground "LightSalmon" :strike-through t))
            (delete* "+" org-emphasis-alist :key 'car :test 'equal)))

(setq org-emphasis-alist
      (cons '("_" '(:underline t :foreground "yellow"))
            (delete* "_" org-emphasis-alist :key 'car :test 'equal)))

(setq org-emphasis-alist
      (cons '("/" '(italic :foreground "orange"))
            (delete* "/" org-emphasis-alist :key 'car :test 'equal)))
;;bold highlight for comma *,*
(setcar (nthcdr 2 org-emphasis-regexp-components) " \t\n\r")
(custom-set-variables `(org-emphasis-alist ',org-emphasis-alist))

;(org-element--set-regexps)
;; {{ org2nikola set up
(setq org2nikola-output-root-directory "~/.config/nikola")
(setq org2nikola-use-google-code-prettify t)
(setq org2nikola-prettify-unsupported-language
      '(elisp "lisp"
              emacs-lisp "lisp"))
;; }}


;(add-hook 'org-mode-hook 'zotelo-minor-mode)


(setq reftex-default-bibliography '("~/Dropbox/bibliography/Library.bib"))

(setq org-ref-bibliography-notes "~/Dropbox/notes/prof_note.org"
     org-ref-default-bibliography '("~/Dropbox/bibliography/refs.bib")
     org-ref-pdf-directory "~/Dropbox/zotero/storage/")
;; open pdf with system pdf viewer (works on mac)

(setq org-ref-completion-library 'org-ref-ivy-bibtex)
(setq org-ref-ivy-bibtex-bibliography "~/Dropbox/bibliography/refs.bib")
(setq org-ref-ivy-bibtex-library-path "~/Dropbox/zotero/storage")
(setq org-ref-ivy-bibtex-notes-path "~/Dropbox/notes")
(define-key org-mode-map (kbd "C-c )") 'reftex-citation)

(require 'org-ref)

;;;;;;;;;;;;;;;;;;;; ditaa
(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
(setq org-image-actual-width '(400))
(org-babel-do-load-languages
 'org-babel-load-languages
  '((ditaa . t) (dot . t) (emacs-lisp . t) (R . t) (python . t) (gnuplot . t) (latex . t) (org . t))) ; this line activates ditaa


(provide 'init-org)

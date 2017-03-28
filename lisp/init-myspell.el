(require 'ispell)
(require 'flyspell)
(setq ispell-program-name "aspell")
(setq flyspell-default-dictionary "english")
(setq ispell-dictionary "english")
(setq ispell-local-dictionary "en_US")
(setq ispell-personal-dictionary "~/.aspell.en.pws")
(eval-after-load 'flyspell
  '(progn
     (require 'flyspell-lazy)
     (flyspell-lazy-mode 1)))


;; better performance
(setq flyspell-issue-message-flag nil)

;(setq ispell-local-dictionary "american")
(defun flyspell-detect-ispell-args (&optional run-together)
  "If RUN-TOGETHER is true, spell check the CamelCase words.
Please note RUN-TOGETHER will make aspell less capable. So it should only be used in prog-mode-hook."
  (let (args)
    (when ispell-program-name
      (cond
        ((string-match "aspell$" ispell-program-name)
         ;; force the English dictionary, support Camel Case spelling check (tested with aspell 0.6)
         (setq args (list "--sug-mode=ultra" "--lang=en_US"))
         (if run-together
           (setq args (append args '("--run-together" "--run-together-limit=16" "--run-together-min=2")))))
        ((string-match "hunspell$" ispell-program-name)
         (setq args nil))))
    args))


(defun text-mode-hook-setup ()
  ;; Turn off RUN-TOGETHER option when spell check text-mode
  (setq-local ispell-extra-args (flyspell-detect-ispell-args)))
(add-hook 'text-mode-hook 'text-mode-hook-setup)

;; Add auto spell-checking in comments for all programming language modes
;; if and only if there is enough memory
;; You can use prog-mode-hook instead.
 (defun can-enable-flyspell-mode ()
   (and (not *no-memory*)
        ispell-program-name
        (executable-find ispell-program-name)))

 (defun enable-flyspell-mode-conditionally ()
  (if (and (not *no-memory*)
           ispell-program-name
           (executable-find ispell-program-name))
      (flyspell-mode 1)))

(if (can-enable-flyspell-mode)
    (add-hook 'prog-mode-hook 'flyspell-prog-mode))



(global-set-key (kbd "C-c w") 'flyspell-auto-correct-word)


(defvar flyspell-check-doublon t
  "Check doublon (double word) when calling `flyspell-highlight-incorrect-region'.")
 (make-variable-buffer-local 'flyspell-check-doublon)

(defadvice flyspell-highlight-incorrect-region (around flyspell-highlight-incorrect-region-hack activate)
  (if (or flyspell-check-doublon (not (eq 'doublon (ad-get-arg 2))))
      ad-do-it))

(provide 'init-myspell)

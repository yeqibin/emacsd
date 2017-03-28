(require 'langtool)

(setq langtool-language-tool-jar "~/Downloads/Software/LanguageTool/languagetool-commandline.jar")

(global-set-key "\C-x4w" 'langtool-check)
(global-set-key "\C-x4W" 'langtool-check-done)
(global-set-key "\C-x4l" 'langtool-switch-default-language)
(global-set-key "\C-x44" 'langtool-show-message-at-point)
(global-set-key "\C-x4c" 'langtool-correct-buffer)

(defun langtool-autoshow-detail-popup (overlays)
  (when (require 'popup nil t)
    ;; Do not interrupt current popup
    (unless (or popup-instances
                ;; suppress popup after type `C-g` .
                (memq last-command '(keyboard-quit)))
      (let ((msg (langtool-details-error-message overlays)))
        (popup-tip msg)))))
(setq langtool-autoshow-message-function
      'langtool-autoshow-detail-popup)
;; Writegood-mode is a minor mode to aid in finding common writing problems.
(require 'writegood-mode)
(global-set-key "\C-cg" 'writegood-mode)
(global-set-key "\C-c\C-gg" 'writegood-grade-level)
(global-set-key "\C-c\C-ge" 'writegood-reading-ease)

;; Emacs minor mode for avoiding cliches and bad grammar when writing about art (or other topics).
(require 'artbollocks-mode)
(add-hook 'text-mode-hook 'artbollocks-mode)

;; Yet another pacakge to write well
;; (require 'textlint)

(provide 'init-grammar)
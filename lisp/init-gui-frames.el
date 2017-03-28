;;----------------------------------------------------------------------------
;; Suppress GUI features
;;----------------------------------------------------------------------------
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)

;;----------------------------------------------------------------------------
;; Show a marker in the left fringe for lines not in the buffer
;;----------------------------------------------------------------------------
(setq indicate-empty-lines t)

;; NO tool bar or scroll bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode nil))

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (with-selected-frame frame
              (unless window-system
                (set-frame-parameter nil 'menu-bar-lines 0)))))
(defun toggle-transparency()
  "Toggle frame transparency"
  (interactive)
  (setq trans (cdr (frame-parameter (selected-frame) 'alpha)))
  (setq check (list 100))
  (if (equalp trans check)
      (set-frame-parameter (selected-frame) 'alpha '(85 50))
    (set-frame-parameter (selected-frame) 'alpha '(100 100))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

(provide 'init-gui-frames)
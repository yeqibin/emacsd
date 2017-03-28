
(setq pomodoro-break-time 5)
(setq pomodoro-long-break-time 10)
(setq pomodoro-work-time 25)
(setq-default mode-line-format
              (cons '(pomodoro-mode-line-string pomodoro-mode-line-string)
                    mode-line-format))
(global-set-key (kbd "<f12>") 'tomatinho)
(provide 'init-pomodoro)

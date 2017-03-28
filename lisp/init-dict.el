;; ==================== DICT ==================================

(global-set-key [mouse-3] 'dictionary-mouse-popup-matching-words)
(global-set-key (kbd "C-c d") 'dictionary-lookup-definition)
(global-set-key (kbd "C-c s") 'dictionary-search)
(global-set-key (kbd "C-c m") 'dictionary-match-words)
;; choose a dictionary server
(setq dictionary-server "localhost")

(defun bing-dict ()
 "Search current word in bing dictionary."
 (interactive)
 (save-restriction
 (let (start end)
 (skip-chars-backward "A-Za-z0–9") (setq start (point))
 (skip-chars-forward "A-Za-z0–9") (setq end (point))
 (setq current-word (buffer-substring start end))
 (w3m (concat "http://cn.bing.com/dict/search?q=" current-word))
 (if (not (string= (buffer-name) "*w3m*"))
     (switch-to-buffer-other-window "*w3m*"))
 (hl-line-mode "*w3m*")
 ;wait for 2 second, because the buffer will refresh soon and it go back to top line.
 (sit-for 2)
 (search-forward current-word nil t 2)
 ;mark the word for 1 second 
 (end-of-line)
 (set-mark (line-beginning-position))
 (sit-for 1)
 (deactivate-mark)
 ))
)
(global-set-key (kbd "C-c z b") 'bing-dict)

(defun cambridge-dict ()
 "Search current word in cambridge dictionary."
 (interactive)
 (save-restriction
 (let (start end)
 (skip-chars-backward "A-Za-z0–9") (setq start (point))
 (skip-chars-forward "A-Za-z0–9") (setq end (point))
 (setq current-word (buffer-substring start end))
 (w3m (concat "http://dictionary.cambridge.org/dictionary/english/" current-word))
 (if (not (string= (buffer-name) "*w3m*"))
     (switch-to-buffer-other-window "*w3m*"))
 (hl-line-mode "*w3m*")
 ;wait for 2 second, because the buffer will refresh soon and it go back to top line.
 (sit-for 2)
 (search-forward current-word nil t 2)
 ;mark the word for 1 second 
 (end-of-line)
 (set-mark (line-beginning-position))
 (sit-for 1)
 (deactivate-mark)
 ))
)
(global-set-key (kbd "C-c z c") 'cambridge-dict)


(global-set-key (kbd "C-c r")
       (lambda ()
       (interactive)
       (eww (format "http://dictionary.reference.com/browse/%s"
           (read-string "Search word: " (current-word))))))

(global-set-key (kbd "C-c f")
    (lambda ()
       (interactive)
       (w3m (format "http://www.thefreedictionary.com/%s"
           (read-string "Search word: " (current-word)))))
)



(provide 'init-dict)

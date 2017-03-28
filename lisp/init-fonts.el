(require 'cl)


;(require 'chinese-fonts-setup)
;(chinese-fonts-setup-enable)
;(setq cfs-profiles `("program" "org-mode" "read-book"))
;与 org-mode 配合使用
;(setq cfs-use-face-font-rescale t)

;(setq-default line-spacing 0) 

(set-default-font "Ubuntu Mono 18"); DejaVu Sans Mono 16 ; Ubuntu Mono 18; Inconsolata 18
;Ubuntu Mono ;Consolas; Monaco 
(add-to-list 'default-frame-alist '(font. "Ubuntu Mono-18"))
;(set-default-font "Monaco 13")
;(set-default-font "DejaVu Sans Mono 13")
;; ;; ;; Chinese Font
;(set-frame-font "-unknown-文泉驿等宽微米黑-normal-normal-normal-*-21-*-*-*-*-0-iso10646-1")
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (if (display-graphic-p)
      (progn
        (set-fontset-font (frame-parameter nil 'font)
                          charset (font-spec :family "Noto Sans Mono CJK SC" :size 24)))
    ))

(defconst cfs--test-string "
| 正常字体    | 粗体        | 粗斜体        |
|-------------+-------------+---------------|
| 堂堂正正    | *五大三粗*  | /东倒西歪/    |
| I'm normal. | *I'm bold!* | /I'm italic?/ |
| 𠄀𠄁𠄂𠄃    | *𠄄𠄅𠄆𠄇*  | /𠄈𠄉𠄊𠄋/    |

请看上面表格线能否对齐, 如果没有对齐，请调整 profile 文件
中变量 `cfs--custom-set-fontsizes' 列表各个数字的大小。")

;(set-fontset-font t 'symbol  (font-spec :family "Symbola") nil 'append)
;(set-fontset-font t 'unicode "Noto Emoji" nil 'append) 
                                        ;(set-fontset-font t 'unicode "STIX" nil 'append)

;; (defun my-set-symbol-fonts (fontsizes-list)
;;   (let* ((fontname "Symbola")
;;           (fontsize (nth 0 fontsizes-list))
;;          (fontspec (font-spec :name fontname
;;                               :size fontsize
;;                               :weight 'normal
;;                               :slant 'normal)))
;;     (if (cfs--fontspec-valid-p fontspec)
;;         (set-fontset-font "fontset-default" 'symbol fontspec nil 'append)
;;       (message "字体 %S 不存在！" fontname))))

;; (add-hook 'cfs-set-font-finish-hook 'my-set-symbol-fonts)


 (require 'company-emoji)
 (add-to-list 'company-backends 'company-emoji) 
 (set-fontset-font t 'symbol (font-spec :family "Noto Emoji")  nil 'prepend)
 (set-fontset-font t 'unicode (font-spec :family "Symbola")  nil 'prepend)


(defun my-set-exta-fonts (fontsizes-list)
  (let* ((fontname "微软雅黑")
         (fontsize (nth 1 fontsizes-list))
         (fontspec (font-spec :name fontname
                              :size fontsize
                              :weight 'normal
                              :slant 'normal)))
    (if (cfs--fontspec-valid-p fontspec)
        (set-fontset-font "fontset-default" '(#x3400 . #x4DFF) fontspec nil 'append)
      (message "字体 %S 不存在！" fontname))))
(add-hook 'cfs-set-font-finish-hook 'my-set-exta-fonts)

(provide 'init-fonts)

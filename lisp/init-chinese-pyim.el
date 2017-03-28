
(require 'chinese-pyim)

(setq default-input-method "chinese-pyim")
(setq pyim-default-pinyin-scheme 'pyim-shuangpin)

;;emacs 启动时加载 chinese-pyim 词库
(add-hook 'emacs-startup-hook
          #'(lambda () (pyim-restart-1 t)))

;(require 'chinese-pyim-basedict)
;(chinese-pyim-basedict-enable)
(require 'chinese-pyim-greatdict)
(chinese-pyim-greatdict-enable)

(setq pyim-use-tooltip 'popup
      pyim-page-length 5) ; don't use tooltip
;(set-face-attribute 'popup-tip-face nil :height 140) 

(global-set-key (kbd "C-\\") 'toggle-input-method)


(setq-default pyim-english-input-switch-functions
              '(pyim-probe-dynamic-english
                pyim-probe-isearch-mode
                pyim-probe-program-mode
                pyim-probe-org-structure-template))
;; ;
(setq-default pyim-puncturation-half-width-functions
              '(pyim-probe-punctuation-line-beginning
                pyim-probe-punctuation-after-punctuation))

(global-set-key (kbd "M-p") 'pyim-convert-pinyin-at-point)
;(global-set-key (kbd "C-;") 'pyim-delete-word-from-personal-buffer)
(global-set-key (kbd "C-;") 'pyim-toggle-input-ascii)
(global-set-key (kbd "C-c i") 'pyim-punctuation-translate-at-point)
;;; ;;;;
;为 isearch 相关命令添加拼音搜索支持
(setq pyim-isearch-enable-pinyin-search t)
;强制关闭 isearch 搜索框中文输入

;; ;; ;
;; ;; ;

(setq debug-on-error t)
;(setq pyim-punctuation-translate-p nil) ;; use western punctuation (ban jiao fu hao)
(setq pyim-personal-file "~/.eim/pyim-personal.txt")
( setq pyim-dicts '(
                ;    (:name "sgcore" :file "~/.emacs.d/pyim/dicts/pyim-sgcore.pyim" :coding utf-8-unix :dict-type pinyin-dict)
                   (:name "profdict" :file "~/.emacs.d/pyim/dicts/mater-metall.pyim" :coding utf-8-unix :dict-type pinyin-dict)
                 ;  (:name "bigdict" :file "~/.emacs.d/pyim/dicts/pyim-bigdict.pyim" :coding utf-8-unix :dict-type pinyin-dict)
		   )
       )


;(setq pyim-enable-words-predict '(pinyin-znabc pinyin-shouzimu guess-words))
(setq pyim-enable-words-predict nil)

; 中文词语没有空格分词，内置命令在中文环境下直接按句子跳，用 下面命令解决：
(global-set-key (kbd "M-f") 'pyim-forward-word)
(global-set-key (kbd "M-b") 'pyim-backward-word)

;改善中文补全功能
(require 'chinese-pyim-company)
(setq pyim-company-max-length 6)

(provide 'init-chinese-pyim)

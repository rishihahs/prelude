(key-chord-define-global "jj" nil)
(key-chord-define-global "jk" nil)
(key-chord-define-global "jl" nil)
(key-chord-define-global "JJ" nil)
(key-chord-define-global "uu" nil)
(key-chord-define-global "xx" nil)
(key-chord-define-global "yy" nil)

(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

;; JS-Mode
(prelude-require-packages '(js2-mode
                            flycheck
                            web-beautify
                            auto-complete
                            tern
                            tern-auto-complete))
(add-hook 'js-mode-hook 'js2-minor-mode) ;; js2 mode
(setq js2-highlight-level 3)
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode)) ;; json files are js2 mode

;; JSHint
(add-hook 'js-mode-hook
          (lambda () (flycheck-mode t)))
;; JSBeautify
(add-hook 'js-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'web-beautify-js-buffer t t)))

;; Autocomplete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(ac-config-default)

;; Tern
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

;; Jade Mode
(prelude-require-package 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; Solarized Theme
(prelude-require-package 'solarized-theme)
(load-theme 'solarized-light t)

;; Comment Cmd-/
(defun comment-current-line-dwim ()
  "Comment or uncomment the current line."
  (interactive)
  (save-excursion
    (push-mark (beginning-of-line) t t)
    (end-of-line)
    (comment-dwim nil)))

(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map (kbd "s-/")
                                    'comment-current-line-dwim)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode 1)

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

;; Look and Feel
(setq redisplay-dont-pause t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)

;; Soft-wrap lines
(global-visual-line-mode t)

;; Linum format to avoid graphics glitches in fringe
(setq linum-format " %4d ")
(global-linum-mode t)

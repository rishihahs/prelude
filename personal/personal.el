(key-chord-define-global "jj" nil)
(key-chord-define-global "jk" nil)
(key-chord-define-global "jl" nil)
(key-chord-define-global "JJ" nil)
(key-chord-define-global "uu" nil)
(key-chord-define-global "xx" nil)
(key-chord-define-global "yy" nil)

(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

;; Helm ggtags for C++
(setq
  helm-gtags-ignore-case t
  helm-gtags-auto-update t
  helm-gtags-use-input-at-cursor t
  helm-gtags-pulse-at-cursor t
  helm-gtags-prefix-key "\C-cg"
  helm-gtags-suggested-key-mapping t
  )

(prelude-require-package 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
     (define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
     (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)))

;; function-args for C++
(prelude-require-package 'function-args)
(fa-config-default)

;; SR-Speedbar
(prelude-require-package 'sr-speedbar)

;; Semantic Mode for C++
(prelude-require-packages '(cc-mode
                            semantic))

(eval-after-load "semantic"
  '(progn
     (global-semanticdb-minor-mode 1)
     (global-semantic-idle-scheduler-mode 1)
     (global-semantic-idle-summary-mode 1)
     (global-semantic-stickyfunc-mode 1)))

(semantic-mode 1)

;; EDE for C++
(prelude-require-package 'ede)
(global-ede-mode)

;; Company-C-Headers
(prelude-require-package 'company-c-headers)
(add-to-list 'company-backends 'company-c-headers)

;; C++ Headers
(defun ede-object-system-include-path ()
  "Return the system include path for the current buffer."
  (when ede-object
    (ede-system-include-path ede-object)))

(setq company-c-headers-path-system 'ede-object-system-include-path)

;; Support for Source Code folding
(add-hook 'c-mode-common-hook 'hs-minor-mode)

(global-set-key (kbd "RET") 'newline-and-indent)  ; automatically indent when press RET

;; Package: clean-aindent-mode
(prelude-require-package 'clean-aindent-mode)
(add-hook 'prog-mode-hook 'clean-aindent-mode)

;; Package: dtrt-indent
(prelude-require-package 'dtrt-indent)
(dtrt-indent-mode 1)
(setq dtrt-indent-verbosity 0)

;; Package: ws-butler
(prelude-require-package 'ws-butler)
(add-hook 'c-mode-common-hook 'ws-butler-mode)

;; JS-Mode
(prelude-require-packages '(flycheck
                            web-beautify
                            auto-complete
                            tern
                            tern-auto-complete))
(setq js2-highlight-level 3)

;; JSHint
(add-hook 'js2-mode-hook
          (lambda () (flycheck-mode t)))
;; JSBeautify
(add-hook 'js2-mode-hook
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

;; Wolfram Language
(prelude-require-package 'wolfram-mode)
(autoload 'wolfram-mode "wolfram-mode" nil t)
(autoload 'run-wolfram "wolfram-mode" nil t)
(setq wolfram-program "/Applications/Mathematica.app/Contents/MacOS/WolframKernel")
(add-to-list 'auto-mode-alist '("\\.m$" . wolfram-mode))

;; Multi-Term
(prelude-require-package 'multi-term)
(setq multi-term-program "/usr/local/bin/zsh")

(add-hook 'term-mode-hook
          (lambda ()
            (setq show-trailing-whitespace nil)))

(defcustom term-unbind-key-list
  '("C-z" "C-x" "C-c" "C-h" "C-y" "<ESC>")
  "The key list that will need to be unbind."
  :type 'list
  :group 'multi-term)
 
(defcustom term-bind-key-alist
  '(
    ("C-c C-c" . term-interrupt-subjob)
    ("C-p" . previous-line)
    ("C-n" . next-line)
    ("C-s" . isearch-forward)
    ("C-r" . isearch-backward)
    ("C-m" . term-send-raw)
    ("M-f" . term-send-forward-word)
    ("M-b" . term-send-backward-word)
    ("M-o" . term-send-backspace)
    ("M-p" . term-send-up)
    ("M-n" . term-send-down)
    ("M-M" . term-send-forward-kill-word)
    ("M-N" . term-send-backward-kill-word)
    ("M-r" . term-send-reverse-search-history)
    ("M-," . term-send-input)
    ("M-." . comint-dynamic-complete))
  "The key alist that will need to be bind.
If you do not like default setup, modify it, with (KEY . COMMAND) format."
  :type 'alist
  :group 'multi-term)

(add-hook 'term-mode-hook
          (lambda ()
            (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
            (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))))

(add-hook 'term-mode-hook
          (lambda ()
            (define-key term-raw-map (kbd "C-y") 'term-paste)))

;; Use Emacs terminfo, not system terminfo
(setq system-uses-terminfo nil)

;; Solarized Theme
(prelude-require-package 'solarized-theme)
(load-theme 'solarized-light t)

;; CLisp
(setq slime-default-lisp 'clisp)
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "clisp")

;; Disable Dialogue Box
(defadvice yes-or-no-p (around prevent-dialog activate)
  "Prevent yes-or-no-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))

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

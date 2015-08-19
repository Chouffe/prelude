;; TODO: ace-window mode
;; TOOD: all other packages installed
;; http://www.emacswiki.org/emacs/WinnerMode
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Highlight-Interactively.html https://www.masteringemacs.org/article/highlighting-by-word-line-regexp
;; TODO: full screen
;; TODO: take a look at key-chord (enabled by prelude, try typing jj or JJ)

;; TODO: slow Helm
;; TODO: Helm customize
;; 'master' (scroll another buffer without leaving the current one)
;; 'align' (code editing, align assignments etc.)
;;
;; TODO: todo-mode
;; TODO: timeclock

(powerline-center-theme)

(prelude-require-packages
 '(;; -- Done
   session             ;; for saving command history etc.
   popwin              ;; helm/other windows popping in and out
   ;; use-package down below
   point-undo          ;; position-only undo
   smooth-scrolling    ;; scrolling offset at top/bottom
   smart-mode-line-powerline-theme  ;; TODO: coloring
   ;; -- TODO: Emacs core-related
   ;; ace-window       ;; prelude
   ;; rich-minority    ;; prelude
   ace-jump-helm-line
   ace-jump-mode
   visual-regexp-steroids
   bind-key
   use-package
   sublimity
   projectile-speedbar

   ;; -- TODO: Helm
   helm-bind-key
   helm-cider-history
   helm-commandlinefu
   helm-company
   helm-css-scss
   helm-dash
   helm-flycheck
   helm-git-grep
   helm-google
   helm-gtags
   helm-package
   helm-proc
   helm-swoop
   helm-themes
   helm-aws

   ;; -- TODO: Clojure
   clj-refactor
   cljr-helm
   clojure-cheatsheet
   clojure-mode-extra-font-locking
   clojure-snippets
   latest-clojure-libraries
   midje-mode
   midje-test-mode
   discover
   discover-clj-refactor
   edn
   slamhound

   ;; -- TODO: Code editing
   aggressive-indent
   evil-nerd-commenter
   hideshow-org
   hideshowvis
   indent-guide
   ;; easy-kill       ;; prelude
   multiple-cursors
   visual-regexp
   visual-regexp-steroids
   whitespace-cleanup-mode

   ;; -- TODO: Fly check
   flycheck-clojure
   flycheck-color-mode-line
   flycheck-pos-tip))

;; TODO: ideally we'd use that everywhere instead of prelude-packages
(require 'use-package)
;; shows all key bindings defined with use-package
(global-set-key (kbd "C-h p") 'describe-personal-keybindings)

;; -- Clear all hooks and font-locks for config reloading without
;; restarting Emacs
(dolist (hook '(clojure-mode-hook
                emacs-lisp-mode-hook
                lisp-mode-hook
                lisp-interaction-mode-hook
                before-save-hook
                smartparens-mode-hook
                cider-mode-hook
                cider-repl-mode-hook
                lisp-interaction-mode-hook))
  (setq hook nil))
(setq font-lock-keywords-alist nil)

(load-file "~/.emacs.d.current/utils.el")
(load-file (concat "~/.emacs.d.current/profile-" (getenv "EMACS_PROFILE") ".el"))

;; -- Backups & autosave
(defconst backup-directory "~/.backups-emacs/")
(if (not (file-exists-p backup-directory))
    (make-directory backup-directory t))

(setq backup-directory-alist `(("." . ,backup-directory))
      auto-save-file-name-transforms
        `((".*" ,(expand-file-name backup-directory) t))
      auto-save-list-file-prefix (concat backup-directory "autosave-filenames/"))

(setq make-backup-files    t
      vc-make-backup-files t    ;; even if under version control
      backup-by-copying    t    ;; don't clobber symlinks
      version-control      t    ;; add version numbers for backup files
      delete-old-versions  t    ;; delete excess backup files silently
      ;; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-old-versions    100
      auto-save-default    t    ;; auto-save every buffer that visits a file
      auto-save-timeout    20   ;; number of seconds idle time before auto-save
      auto-save-interval   200) ;; number of keystrokes between auto-saves

;; -- Windows

(defun configure-frame-layout ()
  (interactive)
  (let (frame (current-frame))
    (set-frame-width    frame 165)
    (set-frame-height   frame 56)
    (set-frame-position frame 260 0))

  (delete-other-windows)
  (split-window-right)
  (split-window-below)
  (windmove-right)
  (split-window-below))

(configure-frame-layout)
(global-set-key (kbd "C-c w") 'configure-frame-layout)

;; kill buffer in the current window
(global-set-key (kbd "C-w") (lambda () (interactive) (kill-this-buffer)))
;; kill buffer in the other window (for error messages, greps etc)
(global-set-key (kbd "C-q")
                  (lambda () (interactive)
                    (kill-buffer (window-buffer (previous-window)))))

;; so that quit (escape) doesn't unsplit all the windows
(defadvice one-window-p (around always (arg))
  (setq ad-return-value t))

(defun keyboard-escape-quit-leave-windows-alone ()
  (interactive)
  (ad-enable-advice 'one-window-p 'around 'always)
  (ad-activate 'one-window-p)
  (unwind-protect
      (keyboard-escape-quit)
    (ad-disable-advice 'one-window-p 'around 'always)
    (ad-deactivate 'one-window-p)))

;; switch esc and ctrl+g and use only one escape instead of 3
;;(global-set-key (kbd "<escape>") 'keyboard-quit)
;;(global-set-key (kbd "C-g") 'keyboard-escape-quit)
(global-set-key (kbd "<escape>")
                (lambda () (interactive)
                  (keyboard-escape-quit-leave-windows-alone)
                  (keyboard-quit)))

;; -- Popwin

(require 'popwin)
(popwin-mode 1)

(setq popwin:special-display-config
      '(("*Miniedit Help*" :noselect t)
        help-mode
        (completion-list-mode :noselect t)
        (compilation-mode :noselect t)
        (grep-mode :noselect t)
        (occur-mode :noselect t)
       (" *undo-tree*" :width 60 :position right)
       (" *undo-tree*" :width 60 :position right)
;;        ("*undo-tree Diff*" :height 0.3 :position bottom)
        ;; TODO: increase height for descbinds
        ;; seems like descbinds breaks my bindings! (cmd+c)
        ("^\*helm.*\*$" :regexp t)
        ("*cider-error*" :height 0.3)
        ("*Messages*" :height 0.3)
        ))

(global-set-key (kbd "M-w") popwin:keymap)

;; -- Various settings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-interval nil)
 '(column-number-mode t)
 '(comint-scroll-to-bottom-on-input (quote all))
 '(company-auto-complete t)
 '(company-auto-complete-chars (quote (32 40 46)))
 '(company-idle-delay 0.3)
 '(company-minimum-prefix-length 2)
 '(default-tab-width 2 t)
 '(eshell-scroll-to-bottom-on-input (quote this))
 '(frame-title-format (quote ("%f")) t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(kill-whole-line t)
 '(menu-bar-mode nil)
 '(mouse-wheel-scroll-amount (quote (1 ((shift) . 1))))
 '(org-M-RET-may-split-line t)
 '(org-table-auto-blank-field t)
 '(rainbow-ansi-colors (quote auto))
 '(rainbow-ansi-colors-major-mode-list
   (quote
    (sh-mode c-mode c++-mode clojure-mode emacs-lisp-mode html-mode)))
 '(recentf-max-menu-items 200)
 '(recentf-max-saved-items 200)
 '(safe-local-variable-values
   (quote
    ((outline-minor-mode)
     (whitespace-style face tabs spaces trailing lines space-before-tab::space newline indentation::space empty space-after-tab::space space-mark tab-mark newline-mark))))
 '(tool-bar-mode nil))

(scroll-bar-mode -1)
(delete-selection-mode t)

;; just 'y'/'n' instead of 'yes'/'no'
(defalias 'yes-or-no-p 'y-or-n-p)

;; revert files when they change
(global-auto-revert-mode t)

;; --- Org mode
;; Emacs comes with org-mode, but ours is hacked so need to load locally
;; TODO: modified!
(load-file "~/.emacs.d.current/org-mode/lisp/org-table.el")
;; -- Orgtbl-mode for table editing (useful for Midje tests)
;; TODO: ??? global now
;;(add-hook 'clojure-mode-hook 'orgtbl-mode)

;; Clipboard (?TODO:)
;; -- Shift selection mode
(global-unset-key (vector (list 'shift 'left)))
(global-unset-key (vector (list 'shift 'right)))
(global-unset-key (vector (list 'shift 'up)))
(global-unset-key (vector (list 'shift 'down)))

;; -- Clipboard and undo
(setq undo-limit 100000)

(use-package undo-tree
  :ensure t
  :demand t
  :config
  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist `(("." . ,(expand-file-name backup-directory)))
        undo-tree-visualizer-timestamps t
        undo-tree-visualizer-diff t)
  (global-undo-tree-mode)
  :bind
  (("C--" . undo-tree-undo)
   ("C-=" . undo-tree-redo)
   ("A--" . undo-tree-visualize)))

(require 'point-undo)
(global-set-key (kbd "M--") 'point-undo)
(global-set-key (kbd "M-=") 'point-redo)

;; -- Clipboard

(setq x-select-enable-clipboard t)
(global-set-key (kbd "M-c") 'kill-ring-save)
(global-set-key (kbd "A-c") 'kill-ring-save)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "A-v") 'yank)

;; -- Don't highlight whitespace like crazy
(setq prelude-whitespace nil)

;; -- Set font and the current line highlighting
(set-face-attribute 'default nil :family "MenloClojure"
                    :weight 'normal :height 120)
(global-hl-line-mode 1)
(set-face-background 'hl-line "#FFD")

;; -- Mac-specific including key bindings
(menu-bar-mode)

;; TODO
;; (defun sfp-page-down (&optional arg)
;;   (interactive "^P")
;; ;;  (setq this-command 'next-line)
;;   (next-line
;;    (- (window-text-height)
;;       next-screen-context-lines)))

;; ;; TODO
;; (defun sfp-page-up (&optional arg)
;;   (interactive "^P")
;; ;;  (setq this-command 'previous-line)
;;   (previous-line
;;    (- (window-text-height)
;;       next-screen-context-lines))
;;   )

;; TODO
;; (global-set-key (kbd "<next>") 'sfp-page-down)
;; (global-set-key (kbd "<prior>") 'sfp-page-up)

;; -- Arrow key bindings

;; * shift                Marking in the buffer
;; * cmd                  Beginning/end of line (left/right) or the doc (up/down)
;; * cmd+shift            Mark until beginning/end of line or document
;; * ctrl+alt             Switch desktop space (OS X, TotalSpaces2)
;; * ctrl+alt+shift       Move window to another space (OS X, TotalSpaces2)
;; * alt                  Left/right: next/prev word; down/up - split/join sexpr
;; * alt+shift            Left-right: mark to next/prev word; down/up - split
;;                        sexpr killing backward/forward
;; * ctrl                 Backward/forward/down/up sexpr
;; * ctrl+shift           Mark until backward/forward/down/up sexpr
;; * cmd+ctrl             Org-table mode: move row or column left/right/down/up
;; * cmd+ctrl+shift       Org-table mode: insert (down) or delete (up) row/column
;; * cmd+alt              Select window to the left/right/down/up
;; * cmd+alt+shift        Move (swap with) selected window left/right/down/up
;; - cmd+alt+ctrl       
;; - cmd+alt+ctrl+shift 
;;
;; * ctrl+backspace       Backward-kill sexp
;; * ctrl+delete          Forward-kill sexp

;; * alt+], alt+shift+]   slurp/barf forwards
;; * alt+[, alt+shift+[   slurp/barf backwards
;;
;; * alt+cmd+], alt+cmd+[ Switch to next/previous buffer (in the same window)

;; -- Smartparens

(smartparens-global-mode -1)

(use-package smartparens
  :ensure t
  :defer t
  :config
  (setq sp-cancel-autoskip-on-backward-movement nil)
  (setq sp-hybrid-kill-entire-symbol t)
  (setq sp-hybrid-kill-excessive-whitespace t)
  (setq sp-navigate-close-if-unbalanced t)
  (setq sp-successive-kill-preserve-whitespace 2)
  :bind (;; -- indentation
         ("RET"           . indent-new-comment-line)
         ("<backtab>"     . sp-indent-defun)
         ;; -- moving
         ("C-<left>"      . sp-backward-sexp)
         ("C-<right>"     . sp-forward-sexp)
         ("C-<down>"      . sp-down-sexp)
         ("C-<up>"        . sp-up-sexp)
         ;; -- killing
         ("C-k"           . sp-kill-hybrid-sexp)  ;; kill line respecting forms
         ("M-<delete>"    . sp-kill-word)
         ("C-<delete>"    . sp-kill-sexp)
         ("M-<backspace>" . sp-backward-kill-word)
         ("C-<backspace>" . sp-backward-kill-sexp)
         ;; -- barfing/slurping
         ("M-]"           . sp-forward-slurp-sexp)
         ("M-}"           . sp-forward-barf-sexp)
         ("M-["           . sp-backward-slurp-sexp)
         ("M-{"           . sp-backward-barf-sexp)
         ("M-<down>"      . sp-split-sexp)
         ("M-<up>"        . sp-join-sexp))
  :bind* (("M-S-<up>"     . sp-splice-sexp-killing-backward)
          ("M-S-<down>"   . sp-splice-sexp-killing-forward)))
;; TODO: right now for unwrapping one should do up/down sexpr, and
;; then a slice-killing (reverse which is confusing): 1. maybe up
;; sexpr should end up at the beginning, not end of sexpr and then it
;; would make sense? 2. we should have a separate binding for slicing

;; TODO: doens't work, key binding conflict, need to figure out how
;; to set precedence 
(use-package hungry-delete
  :ensure t)

;; -- Helm

;; TODO: put inside!
(defun helm-resume-from ()
  (interactive)
  (helm-resume 1))

(use-package projectile
  :init
  (use-package helm
    :config
    (set-face-attribute 'helm-source-header nil :family "Menlo"
                        :weight 'normal :height 100)
    ;; TODO:
    (require 'helm-buffers)
;;    (require 'helm-core)
    (setq helm-always-two-windows               nil
          helm-adaptive-mode                    t   ;; TODO: ???
          helm-split-window-default-side        'other
          helm-quick-update                     t
          helm-buffer-skip-remote-checking      t ;; NOT-CONFIRMED
          helm-candidate-number-limit         500
          helm-mode-fuzzy-match                 t
          helm-M-x-fuzzy-match                  t
          helm-apropos-fuzzy-match              t
          helm-buffers-fuzzy-matching           t
          helm-locate-fuzzy-match               t
          helm-recentf-fuzzy-match              t
          helm-tramp-verbose                    6 ;; NOT-CONFIRMED
          helm-buffers-favorite-modes           '(clojure-mode org-mode) ;; NOT-CONFIRMED
          helm-descbinds-window-style           'split-window
          helm-ff-file-name-history-use-recentf t
          helm-move-to-line-cycle-in-source nil
          helm-ff-history-max-length            500 ;; NOT-CONFIRMED
          helm-ff-skip-boring-files             t   ;; NOT-SURE
          ;;  helm-ff-transformer-show-only-basename nil ;; NOT-SURE NOT-CONFIRMED
          ;;       ;;helm-reuse-last-window-split-state    t ;; NOT-SURE
          )
    ;; -- grep coloring
    (setq helm-grep-default-command
          "ack-grep -Hn --smart-case --no-group %e %p %f"
          helm-grep-default-recurse-command
          "ack-grep -H --smart-case --no-group %e %p %f"
          helm-ls-git-grep-mmand
          (concat "git grep -n%cH --color=always --exclude-standard"
                  " --no-index --full-name -e %p %f")
          helm-default-zgrep-command "zgrep --color=always -a -n%cH -e %p %f")
    (use-package helm-ag
      :ensure t
      :defer t
      :config
      (setq helm-ag-fuzzy-match t
            helm-ag-insert-at-point 'symbol
            helm-ag-source-type 'file-line
            helm-ag-use-agignore t))
    :bind
    (;;("<tab>"   . helm-execute-persistent-action)  ;; TODO:
     ;;("M-z"     . helm-select-action)
     ("C-y"     . helm-show-kill-ring)
     ("C-<tab>" . helm-mini)
     ("C-\\"    . helm-resume)
     ("C-|"     . helm-resume-from)
     ("M-X"     . helm-complex-command-history)
     ))
  :config
  (setq projectile-enable-caching t)
  (global-unset-key (kbd "C-x b"))
  (global-unset-key (kbd "C-x C-b"))
  :bind
  (
   ("C-x C-l" . helm-projectile-find-file-dwim)

   ("C-x s"   . helm-projectile-switch-project)
   ("C-x d"   . helm-projectile-find-dir)

   ;; Main idea behind the bindings:
   ;; 
   ;; ctrl+<letter>  this object
   ;; ctrl+alt+<letter> "open" objects
   ;; ctrl+shift+<letter> all objects

   ;; Search
   ("C-o"   . helm-occur)                       ;; this file
   ("C-M-o" . helm-multi-occur)                 ;; open files
   ("C-S-o" . helm-do-ag-project-root)          ;; all files in the project

   ;; Finding files
   ("C-p"   . helm-projectile)                  ;; this project
   ;; ;; open/existing/all projects
   ("C-M-p" . helm-projectile-find-file-in-known-projects)
   ("C-S-p" . helm-locate)                      ;; all files in the system

   ;; Switching buffers (recentf is kinda like closed buffers)
   ("C-b"   . helm-projectile-switch-to-buffer) ;; this project's open buffers
   ("C-M-b" . helm-buffers-list)                ;; all project's open buffers
   ("C-S-b" . helm-recentf)))                   ;; all buffers, even closed :)

;; (add-hook 'helm-minibuffer-set-up-hook
;;           (lambda ()
;;             (message "ME")
;;            (helm-attrset 'follow 1 helm-source-buffers-list)
;;             ))


(defun helm-debug-toggle ()
  (interactive)
  (setq helm-debug (not helm-debug))
  (message "Helm Debug is now %s"
           (if helm-debug "Enabled" "Disabled")))


;; helm-mode keys
(define-key helm-map (kbd "A-<up>") 'helm-beginning-of-buffer)
(define-key helm-map (kbd "A-<down>") 'helm-end-of-buffer)

(global-set-key (kbd "A-M-[") 'switch-to-prev-buffer)
(global-set-key (kbd "A-M-]") 'switch-to-next-buffer)
(global-set-key (kbd "A-M-p") (lambda () (interactive) (switch-to-buffer nil)))

;; -- Projectile

(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal





(global-set-key (kbd "M-p") (make-sparse-keymap))

;; -- Search
;; TODO: delete
;; make clipboard work in isearch
(define-key isearch-mode-map (kbd "A-v") 'isearch-yank-kill)

;; don't need isearch extended actions
(global-unset-key (kbd "M-s"))
;; but occur mode is handy
;;(global-set-key (kbd "C-o") 'occur)

;; multi-occur will search all buffers in the current mode

(defun get-buffers-matching-mode (mode)
  "Returns a list of buffers where their major-mode is equal to MODE"
  (let ((buffer-mode-matches '()))
   (dolist (buf (buffer-list))
     (with-current-buffer buf
       (if (eq mode major-mode)
           (add-to-list 'buffer-mode-matches buf))))
   buffer-mode-matches))

(defun multi-occur-in-this-mode ()
  "Show all lines matching REGEXP in buffers with this major mode."
  (interactive)
  (multi-occur
   (get-buffers-matching-mode major-mode)
   (car (occur-read-primary-args))))

(global-set-key (kbd "C-c C-o") 'multi-occur-in-this-mode)

;; -- Other key bindings
;; auto-complete on Ctrl-Enter
(global-set-key (kbd "C-<return>") 'dabbrev-expand)

;; recording and replaying macros
(global-set-key (kbd "C-,") 'kmacro-start-macro-or-insert-counter)
(global-set-key (kbd "C-.") 'kmacro-end-or-call-macro)

;; rgrep & cider stacktrace
(defun next-frame-or-error ()
  (interactive)
  (let ((error-buffer (get-buffer "*cider-error*")))
    (if (not error-buffer)
        (next-error)
      (pop-to-buffer error-buffer)
      (forward-line)
      (cider-stacktrace-jump))))

;; TODO: DRY
(defun previous-frame-or-error ()
  (interactive)
  (let ((error-buffer (get-buffer "*cider-error*")))
    (if (not error-buffer)
        (previous-error)
      (pop-to-buffer error-buffer)
      (forward-line -1)
      (cider-stacktrace-jump))))

;;
(global-set-key (kbd "M-g s") 'rgrep)
(global-set-key (kbd "C->") 'next-frame-or-error)      ;; Control + Shift + >
(global-set-key (kbd "C-<") 'previous-frame-or-error)  ;; Control + Shift + <

;; quick mode toggling and text properties
(defun list-text-properties-at (&optional pos)
  (interactive)
  (setq pos (or pos (point)))
  (let ((properties (text-properties-at pos))
      (buf (get-buffer-create "*Text properties*")))
    (set-buffer buf)
    (erase-buffer)
    (insert (format "%s" properties))
    (pop-to-buffer buf)))

(defun list-text-overlays-at (&optional pos)
  "Describe overlays at POS or point."
  (interactive)
  (setq pos (or pos (point)))
  (let ((overlays (overlays-at pos))
        (obuf (current-buffer))
        (buf (get-buffer-create "*Overlays*"))
        (props '(priority window category face mouse-face display
                 help-echo modification-hooks insert-in-front-hooks
                 insert-behind-hooks invisible intangible
                 isearch-open-invisible isearch-open-invisible-temporary
                 before-string after-string evaporate local-map keymap
                 field))
        start end text)
    (if (not overlays)
        (message "None.")
      (set-buffer buf)
      (erase-buffer)
      (dolist (o overlays)
        (setq start (overlay-start o)
              end (overlay-end o)
              text (with-current-buffer obuf
                     (buffer-substring start end)))
        (when (> (- end start) 13)
          (setq text (concat (substring text 1 10) "...")))
        (insert (format "From %d to %d: \"%s\":\n" start end text))
        (dolist (p props)
          (when (overlay-get o p)
            (insert (format " %15S: %S\n" p (overlay-get o p))))))
      (pop-to-buffer buf))))

(global-set-key (kbd "M-m") (make-sparse-keymap))
(global-set-key (kbd "M-m c") 'clojure-mode)
(global-set-key (kbd "M-m o") 'org-mode)
(global-set-key (kbd "M-m t") 'text-mode)
(global-set-key (kbd "M-m l") 'emacs-lisp-mode)
(global-set-key (kbd "M-m p") 'list-text-properties-at)
(global-set-key (kbd "M-m o") 'list-text-overlays-at)

;; -- Smooth scrolling
(require 'smooth-scrolling)
(setq smooth-scroll-margin 3)

;; -- Multiple cursors
;; TODO: DRY
(require 'multiple-cursors)
(global-unset-key (kbd "C-M-c"))
(global-unset-key (kbd "C-M-."))
(global-unset-key (kbd "C-M-."))
(global-set-key (kbd "A-m r") 'mc/edit-lines)
(global-set-key (kbd "A-.") 'mc/mark-next-like-this)
(global-set-key (kbd "A-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "A-m a") 'mc/mark-all-like-this)

;; -- Autofill (very useful for writing comments)
(add-hook 'clojure-mode-hook 'auto-fill-mode)

;; -- Clojure mode
(require 'aggressive-indent)
;;(global-aggressive-indent-mode)  TODO:

(require 'clojure-mode)

(setq open-paren-in-column-0-is-defun-start nil)
(setq clojure--prettify-symbols-alist nil)

(setq clojure-docstring-fill-prefix-width 3)

;; indentation
(setq clojure-use-backtracking-indent nil)

;; TODO: consolidate
(mapc (lambda (x) (put-clojure-indent x 1))
      '(if-let if-not-let when-let when-not-let
        if-nil if-not-nil when-nil when-not-nil
        if-nil-let if-not-nil-let when-nil-let when-not-nil-let
       if-empty if-not-empty when-empty when-not-empty
       if-empty-let if-not-empty-let when-empty-let when-not-empty-let
       if-coll if-not-coll when-coll when-not-coll
       if-coll-let if-not-coll-let when-coll-let when-not-coll-let
       if-list if-not-list when-list when-not-list
       if-list-let if-not-list-let when-list-let when-not-list-let
       if-vector if-not-vector when-vector when-not-vector
       if-vector-let if-not-vector-let when-vector-let when-not-vector-let
       if-string if-not-string when-string when-not-string
       if-string-let if-not-string-let when-string-let when-not-string-let
       match match-fn))
(mapc (lambda (x) (put-clojure-indent x 'defun))
      '(defn+ fn+ facts fact tabular decorate catch-all catch+ update-error))

;; syntax highlighting
(defmacro defclojureface (name color desc &optional others)
  `(defface ,name
     '((((class color)) (:foreground ,color ,@others))) ,desc :group 'faces))

(defclojureface clojure-parens       "#999999"   "Clojure parens")
(defclojureface clojure-braces       "#49b2c7"   "Clojure braces")
(defclojureface clojure-brackets     "#4682b4"   "Clojure brackets")
(defclojureface clojure-keyword      "#2e8b57"   "Clojure keywords")
(defclojureface clojure-namespace    "#c476f1"   "Clojure namespace")
(defclojureface clojure-java-call    "#4bcf68"   "Clojure Java calls")
(defclojureface clojure-special      "#4682b4"   "Clojure special")
(defclojureface clojure-double-quote "#4682b4"   "Clojure double quote")

;; TODO: clojure's (comment) should be highlighted as a comment
;; (maybe they do it in the latest version already?)

(defun replacement (txt)
  `(0 (progn
        ;; (put-text-property (match-beginning 1)
        ;;                         (match-end 1)
        ;;                         'display
        ;;                         ,txt)
        ;;      (put-text-property (match-beginning 1)
        ;;                         (match-end 1)
        ;;                         'intangible
        ;;                         t)
        ;;      (add-face-text-property (match-beginning 1)
        ;;                              (+ 1 (match-beginning 1))
        ;;                              '(:foreground "red"))
        ;;      (add-face-text-property (match-beginning 1)
        ;;                              (+ 1 (match-beginning 1))
        ;;                              'bold)
        ;;      (add-face-text-property (match-beginning 1)
        ;;                              (match-end 1)
        ;;                              '(:raise 1))
        ;; TODO: not 1!
;;        (let ((overlay (make-overlay (match-beginning 1)
  ;;                                   (match-end 1))))
    ;;      (overlay-put overlay 'display ,txt)
;;          (overlay-put overlay 'face '(:foreground "red"))
        ;;    )
;;        (compose-region (match-beginning 1)
  ;;                      (match-end 1)
        ;;                    ,txt)
        (when (not (member (get-text-property (match-beginning 1) 'face)
                           '(font-lock-comment-face
                             font-lock-string-face
                             font-lock-doc-face)
                       ))
            (put-text-property (match-beginning 1)
                               (match-end 1)
                               'display
                               ,txt
                               ))
;;        (put-text-property (match-beginning 1)
;;                           (match-end 1)
;;                           'intangible
;;                           12
;;                           )
        ;; TODO: help-echo
        nil)))

;; http://www.emacswiki.org/emacs/InPlaceAnnotations
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Overlay-Properties.html
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Fields.html#Fields
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Special-Properties.html#Special-Properties
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Other-Display-Specs.html
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Replacing-Specs.html#Replacing-Specs
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Display-Property.html
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Changing-Properties.html
;; http://www.emacswiki.org/emacs/TextProperties#text_property
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Changing-Properties.html
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Multiline-Font-Lock.html#Multiline-Font-Lock

;; (defun let-font-lock-extend-region1 ()
;;   "Extend the search region to include an entire block of text."
;;   ;; Avoid compiler warnings about these global variables from font-lock.el.
;;   ;; See the documentation for variable `font-lock-extend-region-functions'.
;;   (message "%s" "yay")
;;   (eval-when-compile (defvar font-lock-beg) (defvar font-lock-end))
;;   (message "point: %d" (point))
;;   (let ((sexp-beg (nth 1 (syntax-ppss))))
;;     (message "sexp-beg: %d" sexp-beg)
;;     (if (= ?[ (char-after sexp-beg))
;;            ;; NEED TO SET END?
;;            (progn
;;              (setq font-lock-beg sexp-beg)
;;              (setq font-lock-end (+ 20 sexp-beg)))
;;            )
;;         )
;;     )
;;   )

;; (defun let-font-lock-extend-region ()
;; ;;  (message "extend point %d" (point))
;;   (if (<= (point) 300)
;;       (progn (setq font-lock-beg (point))
;;              (setq font-lock-end (+ (point) 10)))
;;     nil)
;;   ;; return t!
;;   )

;; (defun let-font-lock-match-blocks1 (last)
;;   (message "%s" "blocks now")
;;   (set-match-data (list (+ point 2)
;;                         (+ point 4)
;;                         )
;;                   )
;;   )

;; TODO: extra font-locking in clojure mode


(defun down-or-out-sexp ()
  "Moves the point deeper into the s-expression tree, if there are no
  levels deeper moves it forward and out of the current s-expression."
  (let ((pos (point)))
    (sp-down-sexp)
    (if (<= (point) pos)
        (sp-up-sexp))))

;; if-not-string-let etc.
;; TODO: for doseq etc
;;(setq let-symbols '("let" "if-let"))

;; (defun clojure-match-pairs-step (last)
;;   ;; TODO: doc
;;   ;; (setq m t)
;;   ;; (if m (message "-- point %d" (point)))
;;   (let ((pos (point))
;;         (syntax (syntax-ppss))
;;         (result nil))
;;     ;; (if m (message "pos: %d, syntax: %s" pos syntax))
;;     ;; skip comments
;;     (if (nth 4 syntax)
;;         (sp-up-sexp)
;;       ;; let is at least 2 levels deep
;;       (if (< (nth 0 syntax) 2)
;;           (progn
;;             ;; (if m (message "not enough depth"))
;;             (down-or-out-sexp))
;;         ;; ok, we're inside an s-expression at least 2 levels deep
;;         ;; let's look at the 2nd inner level and make sure that
;;         ;; the symbol is one that we support (let, if-let etc.)
;;         (let ((sexps-stack (reverse (nth 9 syntax))))
;;           (let ((sexp-beg (second sexps-stack)))
;;             (if (not (member (save-excursion
;;                                (goto-char sexp-beg)
;;                                (forward-char)
;;                                (forward-sexp)
;;                                (thing-at-point 'symbol))
;;                              let-symbols))
;;                 ;; nope, it wasn't, now we can either look deeper or go
;;                 ;; to the next one
;;                 (progn
;;                   ;; (if m (message "not a member of let family"))
;;                   (down-or-out-sexp))
;;               ;; ok, we're in let - let's see how many arguments we'd need
;;               ;; to skip in the argument list to get to where we were
;;               ;; and determine if it's an odd or an even arg
;;               ;; (if m (message "in let, point: %d" (point)))
;;               (goto-char (first sexps-stack))
;;               (forward-char)
;;               (let ((end-of-let (save-excursion
;;                                   (sp-end-of-sexp)
;;                                   (point))))
;;                 ;; (if m (message "let form: (%d %d)" (1- (point)) end-of-let))
;;                 (let ((last-sexp (sp-forward-sexp)))
;;                   (let ((even t))
;;                     ;; (if m (message "after the first one, point: %d"
;;                     ;;                (point)))
;;                     (while (< (point) pos)
;;                       ;; (if m (message "looping... %d" (point)))
;;                       (setq even (not even))
;;                       (setq last-sexp (sp-forward-sexp)))
;;                     ;; (when m
;;                     ;;   (message "last-sexp: %s" last-sexp)
;;                     ;;   (message "even: %s" even))
;;                     ;; if it's an odd one, try to mark the one after it
;;                     (when (not even)
;;                       (setq last-sexp (sp-forward-sexp))
;;                       ;; (if m (message "last-sexp reset to: %s" last-sexp))
;;                       )
;;                     ;; if we ran out of let by this point, there's
;;                     ;; nothing to report
;;                     (when (>= (point) end-of-let)
;;                       ;; it doesn't exist
;;                       ;; (if m (message "reached the end of let"))
;;                       (setq last-sexp nil)))
;;                   (if last-sexp
;;                       (setq result (list (sp-get last-sexp :beg)
;;                                          (sp-get last-sexp :end))))
;;                   (forward-sexp))))))))
;;     ;; (if m (message "-> %s \"%s\""
;;     ;;                result (if result
;;     ;;                           (apply 'buffer-substring result)
;;     ;;                         "")))
;;     ;; if the point didn't advance we're done searching, so move it manually
;;     (if (= (point) pos)
;;         (goto-char (1+ last)))
;;     (if result
;;         (progn (set-match-data result) t)
;;       nil)))

;; TODO: rename
;; (defun perf (last)
;; ;;  (message "-- let-font-lock-match-blocks %d last %d" (point) last)
;;   (let ((result nil))
;;     (while (and (not result) (<= (point) last))
;;       (setq result (clojure-match-pairs-step last)))
;;     result))

;; (defun pperf (last)
;;   (while (< (point) last)
;; ;;    (message "pp point = %d" (point))
;;     (perf (buffer-size))))

;; (defun let-font-lock-match-blocks (last)
;; ;;  (message "-- let-font-lock-match-blocks %d last %d" (point) last)
;;   nil)

(defvar clojure-font-locks
      ;;       '(("data" 0 font-lock-keyword-face))
      ;;       '(let-font-lock-match-blocks . font-lock-keyword-face)
      (nconc
       ;;       '((let-font-lock-match-blocks 0 font-lock-keyword-face))
       ;; what is <?
       ;; TODO: different font face for doc?
       `(("\\<\\(DOC\\|FIX\\|FIXME\\|TODO\\|BUG\\|CODEQUALITY\\):"
          1 font-lock-warning-face t))
       (mapcar (lambda (pair) `(,(first pair) . ,(replacement (second pair))))
               ;; TODO: instead of '(' need to detect if those symbols are
               ;; keywords
               '(("(\\(fn\\)[\[[:space:]]"          "ƒ")
                 ;; TODO: bigger plus
                 ("(\\(fn\\+\\)[\[[:space:]]"       "ƒ⁺")
                 ("\\b\\(defn\\)\\b"
                  (concat
                   (propertize "∎" 'face 'bold)
                   (propertize "ƒ" 'help-echo "help-text")
                   )
                  )
                 ("\\b\\(defn\\+\\)\\b"
                  (concat
                   (propertize "∎" 'face 'bold)
                   (propertize "ƒ⁺" 'help-echo "help-text")
                   )
                  )
                 ("\\b\\(defmacro\\)\\b"
                  (concat
                   (propertize "∎" 'face 'bold)
                   (propertize "Ƒ" 'help-echo "help-text")
                   )
                  )
                 ("\\b\\(def\\)\\b"
                  (concat
                   (propertize "∎" 'face 'bold)
                   )
                  )
                 ("\\b\\(complement\\|!\\)\\b"
                  (concat
                   (propertize "∁")
                   )
                  )
                 ;; ("\\(comp\\|[|]\\)\\(\\b\\| \\)"
                 ;;  (concat
                 ;;   (propertize "∘")
                 ;;   )
                 ;;  )
                 ("\\b\\(not\\)\\b"
                  "¬"
                  )
                 ("\\b\\(min\\)\\b"
                  "꜖"
                  )
                 ("\\b\\(max\\)\\b"
                  "꜒"
                  )
                 ;; TODO: vector versions
                 ;; TODO: ++ and -- as one symbol
                 ("\\b\\(nil\\)\\b"
                  "∅"
                  )
                 ("\\b\\(if-nil\\)\\b"
                  "if-∅"
                  )
                 ("\\b\\(nil\\?\\)\\b"
                  "∄"
                  )
                 ("\\b\\(some\\?\\)\\b"
                  "∃"
                  )
                 ("\\b\\(con>\\)\\b"
                  "☰"
                  )
                 ("\\b\\(con<\\)\\b"
                  "☱"
                  )
                 ("\\b\\(concat\\)\\b"
                  "☲"
                  )
                 ;; TODO: parens with indexes for highlights?
                 ;; TODO: reverse and reverse-args
                 ;; TODO: loop/recur
                 ("\\b\\(\\*>\\)\\b"
                  "λ…"
                  )
                 ("\\b\\(partial\\)\\b"
                  "λ…"
                  )
                 ("\\b\\(\\*<\\)\\b"
                  "…λ"
                  )
                 ("\\b\\(let\\)\\b"
                  "∎"
                  )
                 ("\\b\\(ns\\)\\b"
                  "§"
                  )
                 ("\\b\\(map\\)\\b"
                  "↦"
                  )
                 ("\\b\\(last\\)\\b"
                  "↩"
                  )
                 ("\\b\\(first\\)\\b"
                  "↪"
                  )
                 ("\\b\\(for\\)\\b"
                  "∀"
                  )
                 ("\\b\\(not=\\)\\b"
                  "≠"
                  )
                 ("\\b\\(<=\\)\\b"
                  "≤"
                  )
                 ("\\b\\(>=\\)\\b"
                  "≥"
                  )
                 ;;                ("\\(def-decorator\\)[\[[:space:]]"
                 ;;                 (concat
                 ;; ;;                 (propertize "⊐" 'face 'bold 'intangible 'def-decorator)
                 ;;                  (propertize "q" 'face '(:foreground "green")
                 ;;                              'help-echo "help-text"
                 ;;                              'intangible 'def-decorator)
                 ;;                  ))
                 ;; ("(\\(defn\\+\\)[\[[:space:]]"     "⌝ƒ⁺")
               ;;;; ("(\\(defmacro\\)[\[[:space:]]"    "⌉Ƒ")
                 ;;("(\\(defn\\+\\)[\[[:space:]]"     "⊐ƒ⁺")
                 ;;("(\\(defmacro\\)[\[[:space:]]"    "⊐Ƒ")
                 ;;("(\\(defmacro\\+\\)[\[[:space:]]" "⊐Ƒ⁺")
                 ;;("(\\(def\\)[\[[:space:]]"         "⊐")
                 ;;("(\\(def\\+\\)[\[[:space:]]"      "⊐⁺")
                 ;;("\\(#\\)("                        "λ")
                 ;;("(\\(ns\\)("                      "§")
                 ;;("(\\(comp\\)("                    "∘")
                 ;;("(\\(\\|\\)("                     "∘")
                 ))))
;; TODO: reloding without restarting
;; copy/paste/text-modes
;; overlays vs text properties


;; TODO: TODO, FIXME and BUG
;; also:
;; (defvar font-lock-format-specifier-face
;;   'font-lock-format-specifier-face
;;   "Face name to use for format specifiers.")

;; (defface font-lock-format-specifier-face
;;   '((t (:foreground "OrangeRed1")))
;;   "Font Lock mode face used to highlight format specifiers."
;;   :group 'font-lock-faces)

;; (add-hook 'c-mode-common-hook
;; 	  (lambda ()
;; 	    (font-lock-add-keywords nil
;; 				    '(("[^%]\\(%\\([[:digit:]]+\\$\\)?[-+' #0*]*\\([[:digit:]]*\\|\\*\\|\\*[[:digit:]]+\\$\\)\\(\\.\\([[:digit:]]*\\|\\*\\|\\*[[:digit:]]+\\$\\)\\)?\\([hlLjzt]\\|ll\\|hh\\)?\\([aAbdiuoxXDOUfFeEgGcCsSpn]\\|\\[\\^?.[^]]*\\]\\)\\)"
;; 				       1 font-lock-format-specifier-face t)
;; 				      ("\\(%%\\)"
;; 				       1 font-lock-format-specifier-face t)) )))

;;(font-lock-add-keywords 'clojure-mode clojure-font-locks)

;; TODO: needs to be highlighted: throw+, try+

;; -- Identifier highlighting
;; (add-to-list 'load-path "~/.emacs.d.current/color-identifiers-mode/")
;; (require 'color-identifiers-mode)
;; (setq color-identifiers:timer
;;       (run-with-idle-timer 0.1 t 'color-identifiers:refresh))
;; (add-hook 'clojure-mode-hook 'color-identifiers-mode)

(defun reload-syntax-highlighting ()
  (interactive)
  (eval-buffer)
  (other-window -1)
  (set-text-properties 1 (buffer-size) nil)
  (remove-overlays)
  (clojure-mode)
  (other-window -1))

(global-set-key (kbd "C-c s") 'reload-syntax-highlighting)

;;(setq font-lock-multiline t)

(add-hook 'clojure-mode-hook
          (lambda ()
            ;; cleanup
            (font-lock-remove-keywords 'clojure-mode clojure-font-locks)
;;            (remove-hook 'font-lock-extend-region-functions
  ;;                       'let-font-lock-extend-region)
            ;; setup
            (setq font-lock-extra-managed-props '(composition display))
;;            (set (make-local-variable 'font-lock-multiline) t)
;;            (add-hook 'font-lock-extend-region-functions
  ;;                    'let-font-lock-extend-region)
            (font-lock-add-keywords 'clojure-mode clojure-font-locks)
            (orgtbl-mode)
            ))

;; -- Window navigation
(global-set-key (kbd "A-M-<left>")  'windmove-left)
(global-set-key (kbd "A-M-<right>") 'windmove-right)
(global-set-key (kbd "A-M-<down>")  'windmove-down)
(global-set-key (kbd "A-M-<up>")    'windmove-up)
(global-unset-key (kbd "C-x o"))

(add-to-list 'load-path "~/.emacs.d.current/modules/buffer-move/")
(require 'buffer-move)
(global-set-key (kbd "A-M-S-<left>")  'buf-move-left)
(global-set-key (kbd "A-M-S-<right>") 'buf-move-right)
(global-set-key (kbd "A-M-S-<down>")  'buf-move-down)
(global-set-key (kbd "A-M-S-<up>")    'buf-move-up)

;; (defun comment-sexp (arg)
;;   "Comment out the sexp at point."
;;   (save-excursion
;;     (paredit-forward)
;;     (call-interactively 'set-mark-command)
;;     (paredit-backward)
;;     (paredit-comment-dwim arg)))

;;                  ("M-;"       . (lambda () (interactive) (comment-sexp 1)))
;;                  ("C-M-;"     . (lambda () (interactive) (comment-sexp -1)))

;; (add-hook 'paredit-mode-hook
;;                  ;; closing TODO: needed?
;;                  ("S-<return>"  . paredit-close-parenthesis-and-newline)
;;                  ("A-)"         . paredit-close-round)
;;                  ("A-}"         . paredit-close-curly)
;;                  ("A-]"         . paredit-close-bracket)
;;                  ("A-\""        . paredit-meta-doublequote)
;;                  ;; killing
;;                  ;; if a selection is active, use the default behavior
;;                  ;; (see delete-selection-mode above) otherwise call
;;                  ;; paredit

;;                  ;; TODO:
;;                  ;; killing sexpr under cursor
;;                  )))

;; -- Parenthesis highlighting
;; TODO: better colors, maybe slightly darker background or symbols
;; like )1 )2 )3 etc - this is probably even better
;; symbols?
;; TODO: red/different background for unbalanced ones?
(add-to-list 'load-path "~/.emacs.d.current/modules/highlight-parentheses.el/")
(require 'highlight-parentheses)
(add-hook 'clojure-mode-hook '(lambda () (highlight-parentheses-mode 1)))
(setq hl-paren-colors
      '("#ff0000" "#0000ff" "#00ff00" "#ff00ff" "#ffff00" "#00ffff"))

;; -- Tramp
;; TODO: is scp faster? which one is the fastest one?
(setq tramp-default-method "ssh")
(setq tramp-verbose 10)
(require 'tramp)
(setcdr (assoc 'tramp-remote-shell (assoc "ssh" tramp-methods))
        '("/bin/bash"))
(setcdr (assoc 'tramp-remote-shell (assoc "scp" tramp-methods))
        '("/bin/bash"))
(setcdr (assoc 'tramp-remote-shell (assoc "rsync" tramp-methods))
        '("/bin/bash"))

;; disable version control (???)
;; (setq vc-ignore-dir-regexp
;;                 (format "\\(%s\\)\\|\\(%s\\)"
;;                         vc-ignore-dir-regexp
;;                         tramp-file-name-regexp))

;; --- Emacs Lisp
(global-prettify-symbols-mode +1)

;; printing and evaluation
(global-set-key [remap eval-expression] 'pp-eval-expression)
(global-set-key [remap eval-last-sexp] 'pp-eval-last-sexp)
(defun eval-region-print ()
  (interactive)
  (if (use-region-p)
    (eval-region (region-beginning) (region-end) t)
    (message "No region")))

;; key bindings are similar to CIDER
(global-set-key (kbd "C-c C-e") 'eval-last-sexp)
(global-set-key (kbd "C-c C-k") 'eval-buffer)
(global-set-key (kbd "C-c C-r") 'eval-region-print)

;; --- CIDER

(defun cider-local ()
  (interactive)
  (cider-connect "127.0.0.1" 12121))

(use-package cider
  :ensure t
  :config
  (setq nrepl-log-messages t
        nrepl-buffer-name-show-port t
        nrepl-hide-special-buffers t
        cider-prefer-local-resources t
        cider-stacktrace-fill-column 80
        cider-prompt-save-file-on-load nil
        cider-auto-select-error-buffer t
        cider-repl-display-in-current-window nil
        cider-repl-use-clojure-font-lock t
        cider-repl-tab-command 'indent-for-tab-command
        cider-repl-history-file (concat (expand-file-name backup-directory)
                                        "cider-repl-history")
        cider-repl-history-size 2000
        cider-repl-use-pretty-printing t)
  (add-hook 'cider-repl-mode-hook (lambda ()
                                    (bind-keys
                                     :map cider-repl-mode-map
                                     ("M-<up>"     . cider-repl-previous-input)
                                     ("M-<down>"   . cider-repl-next-input)
                                     ("M-S-<up>"   . cider-repl-previous-prompt)
                                     ("M-S-<down>" . cider-repl-next-prompt))))
  :bind
  ;; TODO: this still doesn't work conflicts with look up symbol + doc
  ;; which should be meta+, . in our case
  ;; TODO: also add switch to the last clojure buffer
  ;; also these commands should be global anyway (in a special overriding mode)
  (("C-c C-l"    . cider-local)
   ("C-c C-d"    . cider-switch-to-repl-buffer)))

(require 'cider-macroexpansion)

;; TODO: do we actually need it/or taken care by Prelude???
(add-hook 'cider-mode-hook 'eldoc-mode)
(add-hook 'clojure-mode-hook 'eldoc-mode)

;; TODO: was for syntax highlighting, but problem with namespaces now
;; should turn syntax highlighting on somehow else
;;(add-hook 'cider-repl-mode-hook 'clojure-mode)

;;(add-hook 'cider-repl-mode-hook 'paredit-mode)

;; -- Autocomplete (in mini-buffer)
(require 'icomplete)
(icomplete-mode 99)

(require 'ido)
(ido-mode t)
(setq ido-default-buffer-method 'selected-window)

(add-to-list 'load-path "~/.emacs.d.current/modules/flx")
(require 'flx-ido)

(ido-mode 1)
;; TOOD: possible to use on Meta-X?
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;; -- Symbol completion
(require 'company)
(global-company-mode)
(global-set-key (kbd "M-<return>") 'company-complete)

;; -- Magit
;; 
(use-package magit
  :ensure t
  :config
  ;; TODO: DRY
  (global-unset-key (kbd "C-x g"))
  (global-unset-key (kbd "C-x M-g"))
  (global-set-key   (kbd "C-g")             'goto-line)
  (global-set-key   (kbd "M-g")             (make-sparse-keymap))
  (global-set-key   (kbd "M-g M-g")         'magit-status)
  (global-set-key   (kbd "M-g m")           'magit-commit)
  (global-set-key   (kbd "M-g P")           'magit-push)
  (global-set-key   (kbd "M-g d")           'magit-diff)
  (global-set-key   (kbd "M-g c")           'magit-checkout)
  (global-set-key   (kbd "M-g g")           'magit-dispatch-popup)
  (global-set-key   (kbd "M-g l")           'magit-log)
  (global-set-key   (kbd "M-g f")           'magit-log-buffer-file)
  (global-set-key   (kbd "M-g b")           'magit-blame)
  (global-set-key   (kbd "M-g <backspace>") 'magit-file-delete)
  (global-set-key   (kbd "M-g n")           'smerge-next)
  (global-set-key   (kbd "M-g p")           'smerge-prev)
  ;; (k)eep or (t)ake
  (global-set-key   (kbd "M-g k b")         'smerge-keep-base)  
  (global-set-key   (kbd "M-g t b")         'smerge-keep-base)   
  (global-set-key   (kbd "M-g k m")         'smerge-keep-mine)
  (global-set-key   (kbd "M-g t m")         'smerge-keep-mine)
  (global-set-key   (kbd "M-g k o")         'smerge-keep-other)
  (global-set-key   (kbd "M-g t o")         'smerge-keep-other))

;; -- Finding any file in the current git repository
(add-to-list 'load-path "~/.emacs.d.current/modules/find-file-in-repository")
(require 'find-file-in-repository)
(global-set-key (kbd "C-x C-g") 'find-file-in-repository)
(put 'narrow-to-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; -- Sessions
;; (despite the name, sessions package is only used for saving command's history
;; while workgroups2 handles windows and buffers)
;; also, according to workgroups2 docs, it needs to be at the bottom of the file
(unless (boundp 'loaded-once)
  (add-to-list 'load-path "~/.emacs.d.current/modules/f.el/")
  (add-to-list 'load-path "~/.emacs.d.current/modules/s.el/")
  (add-to-list 'load-path "~/.emacs.d.current/modules/anaphora/")
  (add-to-list 'load-path "~/.emacs.d.current/modules/workgroups2/src/")
  (require 'workgroups2)

  (workgroups-mode 1)
  (setq loaded-once t))

;; the bindings we use which are also defined in Prelude
(define-key prelude-mode-map (kbd "C--") nil)
(define-key prelude-mode-map (kbd "C-_") nil)
(define-key prelude-mode-map (kbd "C-=") nil)
(define-key prelude-mode-map (kbd "C-+") nil)
(define-key prelude-mode-map (kbd "A--") nil)
(define-key prelude-mode-map (kbd "M-o") nil)
(define-key prelude-mode-map (kbd "C-c w") nil)

(message "Initialization succesfull")


;; TODO:
;; 1. Finish with the docs and configuration of Helm
;; 2. Finish with the docs and configuration of Prelude
;; 3. Quelpa auto-upgrade (in prelude-packages)

;; shows all key bindings defined with use-package
(global-set-key (kbd "C-h p") 'describe-personal-keybindings)

;; ------------------
;; Arrow key bindings
;; ------------------

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
;;
;; * ctrl+shift+>         Next grep match (in rgrep mode) or stacktrace frame
;; * ctrl+shift+<         Previous grep match (in rgrep mode) or stacktrace frame
;;
;; * alt+shift+>          Next VC change
;; * alt+shift+<          Previous VC change

;; ----------------------------------------------------------------------------
;; Clear all hooks and font-locks for config reloading without restarting Emacs
;; ----------------------------------------------------------------------------
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
(load-file (concat "~/.emacs.d.current/profile-"
                   (getenv "EMACS_PROFILE") ".el"))

;; --------------------------------
;; TODO: packages not yet looked at
;; --------------------------------
;;
;; TODO: from Helm/Projectile (packages we don't want need to be REMOVED from
;; prelude-packages):
;; 
;; ace-window
;; easy-kill
;; anzu (http://melpa.org/#/anzu)
;; smart-mode-line
;; volatile-highlights (http://melpa.org/#/volatile-highlights)
;; expand-region (http://melpa.org/#/expand-region)
;; browse-kill-ring (http://melpa.org/#/browse-kill-ring)
;; gist
;; git-commit
;; git-timemachine
;; gitconfig-mode
;; gitignore-mode
;; grizzl
;; move-text
;; rich-minority
;; zop-to-char
;;
;; TODO: Emacs core
;; 
;; ace-jump-helm-line
;; ace-jump-mode
;; bind-key
;; sublimity
;; projectile-speedbar
;; http://www.emacswiki.org/emacs/WinnerMode
;;
;; TODO: Helm
;;
;; helm-aws
;; helm-bind-key
;; helm-cider-history
;; helm-commandlinefu
;; helm-company
;; helm-css-scss
;; helm-dash
;; helm-flycheck
;; helm-git-grep
;; helm-google
;; helm-gtags
;; helm-package
;; helm-proc
;; helm-swoop
;; helm-themes
;;
;; TODO: Clojure
;; 
;; clj-refactor       
;; cljr-helm          
;; clojure-cheatsheet 
;; clojure-mode-extra-font-lock
;; clojure-snippets
;; latest-clojure-libraries
;; midje-mode
;; midje-test-mode
;; discover (http://www.masteringemacs.org/articles/2013/12/21/discoverel-discover-emacs-context-menus/)
;; discover-clj-refactor
;; edn
;; slamhound
;;
;; TODO: Code editing
;;
;; evil-nerd-commenter
;; hideshow-org
;; hideshowvis
;; indent-guide
;; visual-regexp
;; visual-regexp-steroids
;; whitespace-cleanup-mode
;; json-mode
;; json-reformat
;; json-rpc
;; json-snatcher
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Highlight-Interactively.html
;; https://www.masteringemacs.org/article/highlighting-by-word-line-regexp
;;
;; TODO: syntax highlighting
;; 
;; http://www.emacswiki.org/emacs/InPlaceAnnotations
;;
;; TODO: uncategorized
;; 
;; google
;; inflections
;; key-chord
;; less-css-mode
;; logito
;; makey
;; markdown-mode
;; move-text
;; pcache
;; peg
;; popup
;; powerline
;; scss-mode
;; vkill
;; web-mode
;; with-editor
;; yaml-mode
;; yasnippet
;; master
;; align

;; ----------------
;; Various settings
;; ----------------

;; no tabs
(setq indent-tabs-mode nil)

(scroll-bar-mode -1)
(delete-selection-mode t)

;; just 'y'/'n' instead of 'yes'/'no'
(defalias 'yes-or-no-p 'y-or-n-p)

;; revert (reload) files when they change
(global-auto-revert-mode t)

;; -- Set font and the current line highlighting
(set-face-attribute 'default nil :family "MenloClojure"
                    :weight 'normal :height 120)
(global-hl-line-mode 1)
(set-face-background 'hl-line "#FFD")

(menu-bar-mode)

(use-package smooth-scrolling
  :quelpa t
  :demand t
  :config
  (setq smooth-scroll-margin 3))

;; ---------
;; Clipboard
;; ---------

(setq x-select-enable-clipboard t)
(global-set-key (kbd "M-c") 'kill-ring-save)
(global-set-key (kbd "A-c") 'kill-ring-save)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "A-v") 'yank)

;; -- Shift selection mode
(global-unset-key (vector (list 'shift 'left)))
(global-unset-key (vector (list 'shift 'right)))
(global-unset-key (vector (list 'shift 'up)))
(global-unset-key (vector (list 'shift 'down)))

;; -----------------
;; Backup & autosave
;; -----------------

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

;; ----
;; Undo
;; ----

(setq undo-limit 100000)

(use-package undo-tree
  :quelpa (:stable nil)
  :demand t
  :config
  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `(("." . ,(expand-file-name backup-directory)))
        undo-tree-visualizer-timestamps t
        undo-tree-visualizer-diff t)
  (global-undo-tree-mode)
  :bind (("C--" . undo-tree-undo)
         ("C-=" . undo-tree-redo)
         ("A--" . undo-tree-visualize)))

(use-package point-undo
  :quelpa t
  :demand t
  :bind (("M--" . point-undo)
         ("M-=" . point-redo)))

;; ----------------
;; Multiple cursors
;; ----------------

(use-package multiple-cursors
  :quelpa t
  :bind (("C-M-c" . nil)
         ("C-M-." . nil)
         ("C-M-." . nil)
         ("A-m r" . mc/edit-lines)
         ("A-."   . mc/mark-next-like-this)
         ("A-,"   . mc/mark-previous-like-this)
         ("A-m a" . mc/mark-all-like-this)))

;; -------
;; Windows
;; -------

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

(use-package windmove
  :quelpa t
  :demand t
  :bind
  (("A-M-<left>"  . windmove-left)
   ("A-M-<right>" . windmove-right)
   ("A-M-<down>"  . windmove-down)
   ("A-M-<up>"    . windmove-up)
   ("C-x o"       . nil)))

(use-package buffer-move
  :quelpa t
  :demand t
  :bind
  (("A-M-S-<left>"  . buf-move-left)
   ("A-M-S-<right>" . buf-move-right)
   ("A-M-S-<down>"  . buf-move-down)
   ("A-M-S-<up>"    . buf-move-up)))

;; --------------
;; The escape key
;; --------------

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
;; TODO:
;;(global-set-key (kbd "<escape>") 'keyboard-quit)
;;(global-set-key (kbd "C-g") 'keyboard-escape-quit)
(global-set-key (kbd "<escape>")
                (lambda () (interactive)
                  (keyboard-escape-quit-leave-windows-alone)
                  (keyboard-quit)))

;; ------
;; Popwin
;; ------
;; TODO: finish

(use-package popwin
  :quelpa t
  :demand t
  :config
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
          ("*Messages*" :height 0.3)))
  :bind (("M-w" . popwin:keymap)))

;; ------
;; Search
;; ------

;; -- isearch
;; make clipboard work 
(define-key isearch-mode-map (kbd "A-v") 'isearch-yank-kill)
(define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch)
;; don't need extended actions
(global-unset-key (kbd "M-s"))

;; -- multi-occur
;; will search all buffers in the current mode (keys bound in use-package helm)

(defun get-buffers-matching-mode (mode)
  "Returns a list of buffers where their major-mode is equal to MODE"
  (let ((buffer-mode-matches '()))
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (if (eq mode major-mode)
            (add-to-list 'buffer-mode-matches buf))))
    buffer-mode-matches))

(defun helm-multi-occur-in-this-mode ()
  "Show all lines matching REGEXP in buffers with this major mode."
  (interactive)
  (helm-multi-occur (get-buffers-matching-mode major-mode)))

;; -- rgrep and CIDER stack stacktrace

(defun navigate-frames-or-rgrep (arg)
  (let ((error-buffer (get-buffer "*cider-error*")))
    (if (not error-buffer)
        (if (= arg -1)
            (previous-error)
          (next-error))
      (pop-to-buffer error-buffer)
      (forward-line arg)
      (cider-stacktrace-jump))))

(global-set-key (kbd "C->")                          
                (lambda () (interactive) (navigate-frames-or-rgrep 1)))      
(global-set-key (kbd "C-<")                    
                (lambda () (interactive) (navigate-frames-or-rgrep -1)))      

;; -----------
;; Smartparens
;; -----------
;; TODO: figure out killing s-expressions under cursor (could be use sequentially
;; to kill higher and higher level s-expr?)

(use-package smartparens
  :quelpa t
  :demand t
  :config
  (setq smartparens-global-mode -1)
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


;; TODO: is this still needed or smartparens now has a function for that?
;; (defun comment-sexp (arg)
;;   "Comment out the sexp at point."
;;   (save-excursion
;;     (paredit-forward)
;;     (call-interactively 'set-mark-command)
;;     (paredit-backward)
;;     (paredit-comment-dwim arg)))
;;                  ("M-;"       . (lambda () (interactive) (comment-sexp 1)))
;;                  ("C-M-;"     . (lambda () (interactive) (comment-sexp -1)))
;;                  )))

;; ----
;; Helm
;; TODO: finish
;; ----

;; TODO: put inside! + what 
(defun helm-resume-from ()
  (interactive)
  (helm-resume 1))

(use-package projectile
  :quelpa t
  :demand t
  :init
  (quelpa 'epl :stable nil)
  (use-package helm
    :quelpa t
    :bind
    (;;("<tab>"   . helm-execute-persistent-action)  ;; TODO:
     ;;("M-z"     . helm-select-action)
     ("C-y"     . helm-show-kill-ring)
     ("C-<tab>" . helm-mini)
     ("C-\\"    . helm-resume)
     ("C-|"     . helm-resume-from)
     ("M-X"     . helm-complex-command-history))
    :init
    (use-package helm-buffers
      :quelpa t
      :config
      (setq helm-buffer-skip-remote-checking t   ;; TODO: NOT-CONFIRMED
            helm-buffers-fuzzy-matching      t 	 ;; TODO: NOT-CONFIRMED
            ;; TODO: ?
            helm-buffers-favorite-modes      '(clojure-mode org-mode)))
    :config
    ;; TODO: figure out action vs persistent action, read Helm doc
    (set-face-attribute 'helm-source-header nil :family "Menlo"
                        :weight 'normal :height 100)
    (setq helm-always-two-windows               nil
          helm-adaptive-mode                    t   ;; TODO: ???
          helm-split-window-default-side        'other
          helm-quick-update                     t
          helm-candidate-number-limit         500
          helm-mode-fuzzy-match                 t
          helm-M-x-fuzzy-match                  t
          helm-apropos-fuzzy-match              t
          helm-locate-fuzzy-match               t
          helm-recentf-fuzzy-match              t
          helm-tramp-verbose                    6   ;; TODO: NOT-CONFIRMED
          helm-descbinds-window-style           'split-window
          helm-ff-file-name-history-use-recentf t
          helm-move-to-line-cycle-in-source nil
          helm-ff-history-max-length            500 ;; TODO: NOT-CONFIRMED
          helm-ff-skip-boring-files             t   ;; TODO: NOT-SURE
          ;; TODO: NOT-SURE NOT-CONFIRMED
          ;;  helm-ff-transformer-show-only-basename nil 
          ;;  helm-reuse-last-window-split-state    t ;; TODO: NOT-SURE
          )
    ;; -- grep coloring
    (setq helm-grep-default-command
          "ack-grep -Hn --smart-case --no-group %e %p %f"
          helm-grep-default-recurse-command
          "ack-grep -H --smart-case --no-group %e %p %f"
          helm-ls-git-grep-mmand
          (concat "git grep -n%cH --color=always --exclude-standard"
                  " --no-index --full-name -e %p %f")
          helm-default-zgrep-command
          "zgrep --color=always -a -n%cH -e %p %f")
    (use-package helm-ag
      :quelpa t
      :defer t
      :config
      (setq helm-ag-fuzzy-match t
            helm-ag-insert-at-point 'symbol
            helm-ag-source-type 'file-line
            helm-ag-use-agignore t)))
  :config
  (setq projectile-enable-caching t)
  (global-unset-key (kbd "C-x b"))
  (global-unset-key (kbd "C-x C-b"))
  :bind
  (("C-x C-l" . helm-projectile-find-file-dwim)
   ("C-x s"   . helm-projectile-switch-project)
   ("C-x d"   . helm-projectile-find-dir)

   ;; Main idea behind the bindings:
   ;; 
   ;; ctrl+<letter>  this object
   ;; ctrl+alt+<letter> "open" objects
   ;; ctrl+shift+<letter> all objects

   ;; Search
   ("C-o"   . helm-occur)                       ;; this file
   ("C-M-o" . helm-multi-occur-in-this-mode)    ;; open files
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

(defun helm-debug-toggle ()
  (interactive)
  (setq helm-debug (not helm-debug))
  (message "Helm Debug is now %s" (if helm-debug "Enabled" "Disabled")))

;; helm-mode keys
(define-key helm-map (kbd "A-<up>") 'helm-beginning-of-buffer)
(define-key helm-map (kbd "A-<down>") 'helm-end-of-buffer)

(global-set-key (kbd "A-M-[") 'switch-to-prev-buffer)
(global-set-key (kbd "A-M-]") 'switch-to-next-buffer)
(global-set-key (kbd "A-M-p") (lambda () (interactive) (switch-to-buffer nil)))

;; -------
;; Prelude
;; -------

;; the bindings we use which are also defined in Prelude
(define-key prelude-mode-map (kbd "C--") nil)
(define-key prelude-mode-map (kbd "C-_") nil)
(define-key prelude-mode-map (kbd "C-=") nil)
(define-key prelude-mode-map (kbd "C-+") nil)
(define-key prelude-mode-map (kbd "A--") nil)
(define-key prelude-mode-map (kbd "M-o") nil)
(define-key prelude-mode-map (kbd "C-c s") nil)
(define-key prelude-mode-map (kbd "C-c w") nil)

;; -------
;; Clojure
;; -------

(use-package aggressive-indent
  :quelpa t
  :demand t
  :config
  (global-aggressive-indent-mode))

(use-package clojure-mode
  :quelpa (clojure-mode :fetcher github
                        :repo "aboytsov/clojure-mode"
                        :stable nil)
  :demand t
  :config
  (setq open-paren-in-column-0-is-defun-start nil
        clojure--prettify-symbols-alist nil
        clojure-docstring-fill-prefix-width 3
        clojure-use-backtracking-indent nil)

  ;; -- indentation
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
                 if-vector-let if-not-vector-let
                 when-vector-let when-not-vector-let
                 if-string if-not-string when-string when-not-string
                 if-string-let if-not-string-let when-string-let
                 when-not-string-let
                 match match-fn))
  (mapc (lambda (x) (put-clojure-indent x 'defun))
        '(defn+ fn+ facts fact tabular decorate catch-all catch+ update-error))

  ;; -- syntax highlighting
  ;; TODO:
  ;; 1. (comment + 1 2) and #_(+ 1 2) should be highlighted same as comments
  ;; 2. Try italic fonts
  ;; 3. Take a look at clojure-mode-extra-font-lock package
  ;; 4. try+/throw+ like try/throw

  ;; TODO: this seems unnecessarily custom, see what the default is
  ;; (font-lock-add-keywords 'clojure-mode clojure-font-locks) <= is this?
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

  ;; -- symbol replacement
  
  ;; TODO:
  ;; 1. finish and clean up
  ;; 2. ++ and -- as one symbol
  ;; 3. parens with indexes for highlights?
  ;; 4. reverse
  ;; 5. loop/recur
  ;; 6. if/when/cond
  ;; 7. exceptions

  (defun replacement (txt)
    `(0 (progn
          (when (not (member (get-text-property (match-beginning 1) 'face)
                             '(font-lock-comment-face
                               font-lock-string-face
                               font-lock-doc-face)))
            ;; TODO: resolve the overlay vs. text-property question
            (put-text-property (match-beginning 1) (match-end 1) 'display ,txt))
          ;; TODO: help-echo
          nil)))

  (defvar clojure-font-locks
    (nconc
     ;; TODO:
     ;; 1. what is <?
     ;; 2. different font face for doc?
     ;; 3. Look at ov (https://github.com/ShingoFukuyama/ov.el)
     `(("\\<\\(DOC\\|FIX\\|FIXME\\|TODO\\|BUG\\|CODEQUALITY\\):"
        1 font-lock-warning-face t))
     (mapcar (lambda (pair) `(,(first pair) . ,(replacement (second pair))))
             ;; TODO: instead of '(' need to detect if those symbols are
             ;; keywords
             '(("(\\(fn\\)[\[[:space:]]" "ƒ")
               ;; TODO: bigger plus here
               ("(\\(fn\\+\\)[\[[:space:]]" "ƒ⁺")
               ("\\b\\(defn\\)\\b"
                (concat
                 (propertize "∎" 'face 'bold)
                 (propertize "ƒ" 'help-echo "help-text")))
               ("\\b\\(defn\\+\\)\\b"
                (concat
                 (propertize "∎" 'face 'bold)
                 (propertize "ƒ⁺" 'help-echo "help-text")))
               ("\\b\\(defmacro\\)\\b"
                (concat
                 (propertize "∎" 'face 'bold)
                 (propertize "Ƒ" 'help-echo "help-text")))
               ("\\b\\(def\\)\\b" (propertize "∎" 'face 'bold))
               ("\\b\\(complement\\|!\\)\\b" "∁")
               ("\\(comp\\|[|]\\)\\(\\b\\| \\)" "∘")
               ("\\b\\(not\\)\\b" "¬")
               ("\\b\\(min\\)\\b" "꜖")
               ("\\b\\(max\\)\\b" "꜒")
               ;; TODO: vector versions
               ("\\b\\(nil\\)\\b" "∅")
               ("\\b\\(if-nil\\)\\b" "if-∅")
               ("\\b\\(nil\\?\\)\\b" "∄")
               ("\\b\\(some\\?\\)\\b" "∃")
               ("\\b\\(con>\\)\\b" "☰")
               ("\\b\\(con<\\)\\b" "☱")
               ("\\b\\(concat\\)\\b" "☲")
               ("\\b\\(\\*>\\)\\b" "λ…")
               ("\\b\\(partial\\)\\b" "λ…")
               ("\\b\\(\\*<\\)\\b" "…λ")
               ("\\b\\(let\\)\\b" "∎")
               ("\\b\\(ns\\)\\b" "§")
               ("\\b\\(map\\)\\b" "↦")
               ("\\b\\(last\\)\\b" "↩")
               ("\\b\\(first\\)\\b" "↪")
               ("\\b\\(for\\)\\b" "∀")
               ("\\b\\(not=\\)\\b" "≠")
               ("\\b\\(<=\\)\\b" "≤")
               ("\\b\\(>=\\)\\b" "≥")))))

  ;; -- parenthesis highlighting
  ;; TODO: better colors, maybe slightly darker background or symbols?
  ;; subscript as in )1 )2 )3 etc? - this is probably better
  ;; single symbols with the same idea? - would be awesome!
  ;; TODO: red/different background for unbalanced ones?
  (use-package highlight-parentheses
    :quelpa t
    :demand t
    :config
    ;; TODO: are these better than defaults?
    (setq hl-paren-colors
          '("#ff0000" "#0000ff" "#00ff00" "#ff00ff" "#ffff00" "#00ffff"))
    (add-hook 'clojure-mode-hook
              (lambda ()
                (font-lock-remove-keywords 'clojure-mode clojure-font-locks)
                (setq font-lock-extra-managed-props '(composition display))
                (font-lock-add-keywords 'clojure-mode clojure-font-locks)
                (auto-fill-mode)                   ;; useful for comments
                (highlight-parentheses-mode)
                (message "Clojure mode initialized")))))

;; ---------------
;; Emacs Lisp mode
;; ---------------

(global-prettify-symbols-mode +1)

(add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)

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

;; -------------
;; Hungry delete
;; -------------

;; TODO: need to fix to work with smartparens in Clojuer and Emacs Lisp
;; (use-package hungry-delete
;;   :quelpa t
;;   :demand t
;;   :config
;;   (add-hook 'clojure-mode-hook 'hungry-delete-mode))

;; --------
;; Org-mode
;; --------

(use-package org
  :quelpa (org-mode :fetcher github
                    :repo "aboytsov/org-mode"
                    :stable nil)
  :config
  (add-hook 'clojure-mode-hook 'orgtbl-mode))

;; -----
;; CIDER
;; -----

(defun cider-local ()
  (interactive)
  (cider-connect "127.0.0.1" 12121))

(use-package cider
  :quelpa (:stable t)
  :demand t           
  :bind
  ;; TODO: this still doesn't work conflicts with look up symbol + doc
  ;; which should be meta+, . in our case
  ;; TODO: also add switch to the last clojure buffer
  ;; also these commands should be global anyway (in a special overriding mode)
  (("C-c C-l"    . cider-local)
   ("C-c C-d"    . cider-switch-to-repl-buffer))
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
  (add-hook 'cider-repl-mode-hook
            (lambda () (bind-keys :map cider-repl-mode-map
                             ("M-<up>"     . cider-repl-previous-input)
                             ("M-<down>"   . cider-repl-next-input)
                             ("M-S-<up>"   . cider-repl-previous-prompt)
                             ("M-S-<down>" . cider-repl-next-prompt))))
  ;; TODO: do we actually need it/or taken care by Prelude???
  ;;  (add-hook 'cider-mode-hook 'eldoc-mode)
  ;;  (add-hook 'clojure-mode-hook 'eldoc-mode)
  )

;; ------------
;; Coding tools
;; ------------

(use-package company
  :quelpa t
  :demand t
  :config
  (global-company-mode)
  :bind ("M-<return>" . company-complete))

;; auto-complete on Ctrl-Enter
(global-set-key (kbd "C-<return>") 'dabbrev-expand)

;; recording and replaying macros
(global-set-key (kbd "C-,") 'kmacro-start-macro-or-insert-counter)
(global-set-key (kbd "C-.") 'kmacro-end-or-call-macro)

;; --------
;; Flycheck
;; --------
;; TODO: finish

;;(use-package flycheck :demand t)

;; (use-package flycheck-clojure
;;   :quelpa t
;;   :demand t           
;;   :init
;;   (use-package flycheck
;;     :quelpa t
;;     :demand t
;;     ;;:config
;;     ;;(use-package flycheck-color-mode-line :quelpa t)
;;     ;;(use-package flycheck-pos-tip :quelpa t)
;;     ))

;; -----
;; Magit
;; -----

(use-package diff-hl
  :quelpa (:stable nil)
  :config
  (global-diff-hl-mode 1)
  :bind (("M->" . diff-hl-next-hunk)
         ("M-<" . diff-hl-previous-hunk)
         ("M-R" . diff-hl-revert-hunk)
         ("M-H" . diff-hl-diff-goto-hunk)))

(use-package magit
  :quelpa t
  :bind (("C-x g"   . nil)
         ("C-x M-g" . nil)
         ("C-g"     . goto-line)
         ("M-g M-g" . magit-status)
         ("M-g c"   . magit-commit)
         ("M-g P"   . magit-push)
         ("M-g d"   . magit-diff)
         ("M-g b"   . magit-checkout)
         ("M-g g"   . magit-dispatch-popup)
         ("M-g l"   . magit-log)
         ("M-g f"   . magit-log-buffer-file)
         ("M-g w"   . magit-blame)       ;; (w)ho
         ("M-g n"   . smerge-next)
         ("M-g p"   . smerge-prev)
         ("M-g <backspace>" . magit-file-delete)
         ;; (k)eep or (t)ake
         ("M-g k b" . smerge-keep-base)  
         ("M-g t b" . smerge-keep-base)   
         ("M-g k m" . smerge-keep-mine)
         ("M-g t m" . smerge-keep-mine)
         ("M-g k o" . smerge-keep-other)
         ("M-g t o" . smerge-keep-other))
  :config
  (use-package magit-popup :quelpa t))

;; -----
;; Modes
;; -----

(global-set-key (kbd "M-m") (make-sparse-keymap))
(global-set-key (kbd "M-m c") 'clojure-mode)
(global-set-key (kbd "M-m o") 'org-mode)
(global-set-key (kbd "M-m t") 'text-mode)
(global-set-key (kbd "M-m l") 'emacs-lisp-mode)

;; -------------------
;; Smartline/powerline
;; -------------------

;; TODO: finish
;; (use-package smart-mode-line-powerline-theme
;;   :config (powerline-center-theme))

;; ----------------------------
;; Text properties and overlays
;; ----------------------------

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

(global-set-key (kbd "M-m p") 'list-text-properties-at)
(global-set-key (kbd "M-m o") 'list-text-overlays-at)

;; TODO: doesn't work well with sessions now
(defun reload-syntax-highlighting ()
  (interactive)
  (eval-buffer)
  (other-window -1)
  (set-text-properties 1 (buffer-size) nil)
  (remove-overlays)
  (clojure-mode)
  (other-window 1))

(global-set-key (kbd "C-c s") 'reload-syntax-highlighting)

;; -----
;; Tramp
;; -----

;; TODO:
;; 1. is scp faster? which one is the fastest one?
;; 2. should we disable version control?
;; (setq vc-ignore-dir-regexp (format "\\(%s\\)\\|\\(%s\\)"
;;                              vc-ignore-dir-regexp
;;                              tramp-file-name-regexp))

(use-package tramp
  :quelpa t
  :config
  (setq tramp-default-method "ssh"
        tramp-verbose 10)
  (setcdr (assoc 'tramp-remote-shell (assoc "ssh" tramp-methods))
          '("/bin/bash"))
  (setcdr (assoc 'tramp-remote-shell (assoc "scp" tramp-methods))
          '("/bin/bash"))
  (setcdr (assoc 'tramp-remote-shell (assoc "rsync" tramp-methods))
          '("/bin/bash")))

(message "Initialization succesfull")

;; --------
;; Sketches
;; --------

;; TODO: finish
;; This was supposed to be PgDn/Up with more conventional behavior

;; (defun sfp-page-down (&optional arg)
;;   (interactive "^P")
;; ;;  (setq this-command 'next-line)
;;   (next-line
;;    (- (window-text-height)
;;       next-screen-context-lines)))
;;       
;; (defun sfp-page-up (&optional arg)
;;   (interactive "^P")
;; ;;  (setq this-command 'previous-line)
;;   (previous-line
;;    (- (window-text-height)
;;       next-screen-context-lines)))
;;
;; (global-set-key (kbd "<next>") 'sfp-page-down)
;; (global-set-key (kbd "<prior>") 'sfp-page-up)

;; -----------------------
;; Let highlighting sketch
;; -----------------------
;;
;; (setq font-lock-multiline t)
;;
;; TODO: we might not need this after all as highlight-modifiers give each
;; identifier its own color anyway

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
;;              (setq font-lock-end (+ 20 sexp-beg)))))))

;; (defun let-font-lock-extend-region ()
;; ;;  (message "extend point %d" (point))
;;   (if (<= (point) 300)
;;       (progn (setq font-lock-beg (point))
;;              (setq font-lock-end (+ (point) 10)))
;;     nil))
;;   ;; return t!

;; (defun let-font-lock-match-blocks1 (last)
;;   (message "%s" "blocks now")
;;   (set-match-data (list (+ point 2)
;;                         (+ point 4))))

;; (defun down-or-out-sexp ()
;;   "Moves the point deeper into the s-expression tree, if there are no
;;   levels deeper moves it forward and out of the current s-expression."
;;   (let ((pos (point)))
;;     (sp-down-sexp)
;;     (if (<= (point) pos)
;;         (sp-up-sexp))))

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

;; --------
;; Sessions
;; --------

;; according to the docs, it needs to be at the bottom of the init.el
(use-package workgroups2
  :quelpa (:stable nil)
  :demand t
  :config
  (workgroups-mode 1)
  ;; below is emacs built-in
  (savehist-mode 1)
  (setq savehist-file (concat backup-directory "savehist")))

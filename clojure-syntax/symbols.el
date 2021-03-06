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
  ;; TODO:
  ;;   0. need to detect keywords instead of looking at '(' and spaces
  ;;   1. what is <?
  ;;   2. different font face for doc?
  ;;   3. tooltips, e.g.  (propertize "ƒ" 'help-echo "help-text")
  ;;   4. Look at ov (https://github.com/ShingoFukuyama/ov.el)
  (nconc
   `(("\\<\\(DOC\\|FIX\\|FIXME\\|TODO\\|BUG\\|CODEQUALITY\\):"
      1 font-lock-warning-face t))
   (mapcar
    (lambda (pair) `(,(first pair) . ,(replacement (second pair))))
    '(("(\\(fn\\)[\[[:space:]]"     "ƒ")
      ("(\\(fn\\+\\)[\[[:space:]]"  "ƒ⁺")    ;; TODO: a bigger +
      ("\\b\\(defn\\)\\b"           (concat (propertize "∎" 'face 'bold) "ƒ"))
      ("\\b\\(defn\\+\\)\\b"        (concat (propertize "∎" 'face 'bold) "ƒ⁺"))
      ("\\b\\(defmacro\\)\\b"       (concat (propertize "∎" 'face 'bold) "Ƒ"))
      ("\\b\\(def\\)\\b"            (propertize "∎" 'face 'bold))
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

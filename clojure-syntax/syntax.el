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

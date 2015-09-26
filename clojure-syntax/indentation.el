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
      '(defn+ fn+ facts fact tabular decorate catch-all catch+ update-error
         cache/wrap-with-codec cached for-map arg-> let-with-arg->
         fnk test-extractor test-extractor-db guard))

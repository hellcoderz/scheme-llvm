(require-extension syntax-case)

(use test)
(load "scheme-parser.scm")


(test-group "identifier"
	    (test '((id . "abc") . 3) (identifier "abc" 0))
	    (test '((id . "...") . 3) (identifier "..." 0))
	    (test '((id . "ab@cd") . 5) (identifier "ab@cd" 0))
	    (test '((id . "$ab@cd") . 6) (identifier "$ab@cd" 0))
	    (test #f (identifier "@ab@cd" 0))
	    (test '((id . "+") . 1) (identifier "+34abc" 0))
	    (test #f (identifier "34abc" 0))
)

(test-group "string"
	    (test '((string . "abc") . 5) (string "\"abc\"" 0))
	    (test '((string . "a\"c") . 6) (string "\"a\\\"c\"" 0))
	    (test '((string . "a\\c") . 6) (string "\"a\\\\c\"" 0))
	    (test #f (string "34abc" 0))
)

(test-group "literal"
	    (test '((literal string . "abc") . 5) (literal "\"abc\"" 0))
	    (test '((literal quote id . "abc") . 4) (literal "'abc" 0))
	    (test '((literal quote id . "abc") . 11) (literal "(quote abc)" 0))
	    (test '((literal quote id . "abc") . 14) (literal "(quote    abc)" 0))
)

(test-group "number"
	    (test '(123 . 3) (number "123" 0))
	    (test '(64 . 5) (number "#o100" 0))
	    (test '(4 . 5) (number "#b100" 0))
	    (test '(256 . 5) (number "#x100" 0))
)

(test-group "list"
	    (test '(() . 2) (datum "()" 0))
	    (test '((1) . 3) (datum "(1)" 0))
	    (test '((1 2) . 5) (datum "(1 2)" 0))
	    (test '((1 (3 4) 2) . 11) (datum "(1 (3 4) 2)" 0))
	    (test '((1 . 2) . 7) (datum "(1 . 2)" 0))
	    (test '((1 2 . 3) . 9) (datum "(1 2 . 3)" 0))
)

(test-exit)
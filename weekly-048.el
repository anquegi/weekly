;;; weekly-048.el --- Weekly challenge 048  -*- lexical-binding: t; -*-

;;; Commentary:
;; 
;; Task 1 uses Elisp ring data structure
;; Task 3 since string are chorts 8 charaters there is no need to implement a fast iterative function

;;; Code:

;; task 1
;; Response heavely based https://emacs.stackexchange.com/questions/55622/not-understanding-ring-structure/55633#55633

(defun weekly-048-survivor-circular (n)
  "Solve the Survivor puzzle for numbers 1 through N.
Return the single surviving number.
Implemented using a circular list."
  (let ((circle (number-sequence 1 last)))
    (nconc circle circle)
    (while (not (eq circle (cdr circle)))
      (setcdr circle (cddr circle))
      (pop circle))
    (or (car circle) 1)))


;; task 2

; Palindrome Dates between 2000 and 2999. The format of date is mmddyyyy

(mapcar
 #'(lambda (s) (concat (reverse s) s))
 (seq-filter
  (lambda (str)
    (string-match-p
     (rx bol
         "2"
         (any "0" "1" "2")
         (or (sequence (any "0-2") "1")
             (sequence (any "1-9") "1"))
         eol)
     str))
  (mapcar #'number-to-string (number-sequence 2000 2999))))




(provide 'weekly-048)

;;; weekly-048.el ends here


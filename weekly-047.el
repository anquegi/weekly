;;; weekly-047.el --- Solve perl week 47

;;; Commentary:
;; 

;; Task 1

(require 'rst)

(defun operate-with-roman-numerals-in-region (begin end)
  "apply operation on numerals"
  (interactive "r")
  (message "%d"
           (let ((op (s-split " " (buffer-substring begin end))))
                 (funcall (intern-soft (second op))
                 (rst-roman-to-arabic (first op))
                 (rst-roman-to-arabic (third op))))))

;;VI + IV

(defun count-lines-region (start end)
  "Print number of lines and characters in the region."
  (interactive "r")
  (message "Region has %d lines, %d characters"
       (count-lines start end) (- end start)))

;; TASK 2

(defun weekly-047-gapful-number-p (n)
  "Return t if N is a Gapful Number, nil otherwise."
  (let ((str (number-to-string n)))
    (zerop (% n (string-to-number (concat (s-left 1 str) (s-right 1 str)))))))

(defun weekly-047-find-gapful-numbers (n start)
  "Find N first Gapful starting at START."
  (let ((acc ()))
    (while (< (length acc) n)
      (when (weekly-047-gapful-number-p start)
        (push start acc))
      (incf start))
    acc))

(weekly-047-find-gapful-numbers 20 100)
                                        ;(190 187 180 176 170 165 160 154 150 143 140 135 ...)


(provide 'weekly-047)

;;; weekly-047.el ends here

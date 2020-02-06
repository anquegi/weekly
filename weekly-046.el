;;; weekly-046.el --- Perl week 046  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; The room type is a cons with a number and a Symbol :close or :open

(require 's)

;;; Code:

;; Task 01

(defun weekly-046-decrypt-region (beg end)
  "Get region and decrypt it."
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list (point-min) (point-min))))
  (let* ((selection (buffer-substring-no-properties beg end))
         (ll (mapcar #'(lambda (x) (s-split " " x)) (s-split "\n" selection))))
    (message "%S" (apply #'concat (flatten-list (apply #'mapcar* #'weekly-046--get-duplicates ll))))))

(defun weekly-046--get-duplicates (&rest list)
  "Get duplicates from arguments LIST."
  (let ((ht (make-hash-table :test #'equal))
        ret)
    (dolist (x list)
      (incf (gethash x ht 0)))
    (maphash (lambda (key value) (when (> value 1) (push key ret)))
             ht)
    ret))

;; Task 02

(defun weekly-046-open-door (r)
  "Opens the door of room R."
  (cons (car r) :open))

(defun weekly-046-close-door (r)
  "Closes the door of room R."
  (cons (car r) :close))

(defun weekly-046-toggle-door (r)
  "Toggle the door of room R."
  (pcase r
    (`(,_ . :close) (weekly-046-open-door r))
    (`(,_ . :open) (weekly-046-close-door r))))

(defun weekly-046-toggle-by-n-multiple (r n)
  "Toggle the door of room R if N is multiple."
  (if (zerop (% (car r) n)) (weekly-046-toggle-door r)
    r))

(defun weekly-046-rooms (n)
  "Create lazy stream of closed rooms beginning with N."
    (stream-cons (cons n :close) (rooms (1+ n))))

(defun weekly-046-simulation (n)
     (let ((list-of-rooms (seq-into (seq-take (weekly-046-rooms n)) 'list)))
       (dotimes (i n mi-hotel)
         (setf mi-hotel (seq-map (lambda (r) (weekly-046-toggle-by-n-multiple r (1+ i))) mi-hotel)))))


(provide 'weekly-046)

;;; weekly-046.el ends here

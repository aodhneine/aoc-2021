#lang racket/base

(require
  (only-in racket/list first second third))

(provide compute)

(define (fold-instructions instructions)
  (foldl
    (lambda (current accumulator)
      (let ([instruction (car current)]
            [value (cdr current)]
            [distance (first accumulator)]
            [depth (second accumulator)]
            [aim (third accumulator)])
        (case instruction
          ['forward (list (+ distance value) (+ depth (* aim value)) aim)]
          ['up (list distance depth (- aim value))]
          ['down (list distance depth (+ aim value))])))
    (list 0 0 0) ; distance, depth, aim
    instructions))

;; Computes the problem.
(define (compute instructions)
  (let ([result (fold-instructions instructions)])
    (* (first result) (second result))))

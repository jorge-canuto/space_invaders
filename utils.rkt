#lang racket

(provide (all-defined-out))

;; distancia: Natural Natural Natural Natural -> Numero
;; calcula a distancia euclidiana entre dois pontos

;; stub
;; (define (distancia x1 y1 x2 y2) x1)

(define (distancia x1 y1 x2 y2)
  (sqrt (+ (sqr (- x2 x1)) (sqr (- y2 y1)))))
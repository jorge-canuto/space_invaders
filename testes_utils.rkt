#lang racket
(require rackunit)

(require "utils.rkt")

; Testes distancia
(check-equal? (distancia 0 0 3 4) 5)
(check-equal? (distancia 2 3 5 3) 3)
(check-equal? (distancia 1 1 4 5) 5)
(check-equal? (distancia 2 3 2 3) 0)

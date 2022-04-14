#lang racket

(require "constantes.rkt")

(provide (all-defined-out))

;; Definições de dados:
(define-struct tiro (x y dx))
;; Tiro é (make-personagem Natural Natural Inteiro)
;; interp. tiro do personagem nos eixos x e y, em pixels.
;; dx reprensenta a velocidade de deslocamento

;; Exemplos NAVE:
(define TIRO-INICIO (make-tiro (/ LARGURA-TIRO 2) (/ ALTURA-CENARIO 2) 3))

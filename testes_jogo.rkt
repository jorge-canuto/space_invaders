#lang racket

(require rackunit)
(require "constantes.rkt")
(require "jogo.rkt")
(require "personagem.rkt")


;; Testes trata-tecla
(check-equal? (trata-tecla-nave (make-personagem (/ LARGURA-CENARIO 2) (/ ALTURA-CENARIO 2) 3 5) TECLA-DIREITA)
              (make-personagem (+ (/ LARGURA-CENARIO 2) 3) (/ ALTURA-CENARIO 2) 3 5))
(check-equal? (trata-tecla-nave (make-personagem (/ LARGURA-CENARIO 2) (/ ALTURA-CENARIO 2) 3 5) TECLA-ESQUERDA)
              (make-personagem (- (/ LARGURA-CENARIO 2) 3) (/ ALTURA-CENARIO 2) -3 5))
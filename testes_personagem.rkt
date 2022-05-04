#lang racket

(require rackunit)
(require 2htdp/image)

(require "constantes.rkt")
(require "personagem.rkt")


; move-personagem
(check-equal? (move-personagem (make-personagem (/ LARGURA-CENARIO 2) (/ ALTURA-CENARIO 2) 3 0)) 
                               (make-personagem (- (/ LARGURA-CENARIO 2) 3) (/ ALTURA-CENARIO 2) 3 0))


;; Testes do colidindo?
(check-equal? (colidindo? NAVE-INICIO NAVE-INIMIGA-INICIO)  #true)
(check-equal? (colidindo? NAVE-INICIO NAVE-INIMIGA-MEIO)  #false)
(check-equal? (colidindo? NAVE-INIMIGA-MEIO NAVE-INICIO)  #false)

;; Testes do colidindo-com-algum?
(check-equal? (colidindo-com-algum? NAVE-INICIO (list NAVE-INIMIGA-MEIO NAVE-INIMIGA-FINAL-CENARIO)) #false)
(check-equal? (colidindo-com-algum? NAVE-INICIO (list NAVE-INIMIGA-FINAL-CENARIO NAVE-INIMIGA-MEIO)) #false)
(check-equal? (colidindo-com-algum? NAVE-INICIO (list NAVE-INIMIGA-FINAL-CENARIO NAVE-INIMIGA-INICIO)) #true)

;; Testes do move-personagens
(check-equal? (move-personagens (list NAVE-INIMIGA-INICIO NAVE-INIMIGA-MEIO))
              (list (make-personagem (- (/ LARGURA-NAVE-INIMIGA 2) 3) (/ ALTURA-CENARIO 2) 3 0)
                    (make-personagem (- (/ LARGURA-CENARIO 2) 3) (/ ALTURA-CENARIO 2) 3 3)))

(check-equal? (move-personagens (list NAVE-INIMIGA-MEIO NAVE-INIMIGA-INICIO))
              (list (make-personagem (- (/ LARGURA-CENARIO 2) 3) (/ ALTURA-CENARIO 2) 3 3)
                    (make-personagem (- (/ LARGURA-NAVE-INIMIGA 2) 3) (/ ALTURA-CENARIO 2) 3 0)))
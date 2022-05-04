#lang racket

(require rackunit)
(require "constantes.rkt")
(require "jogo.rkt")
(require "personagem.rkt")
(require "tiro.rkt")


;; Testes trata-tecla-nave
(check-equal? (trata-tecla-nave (make-personagem (/ LARGURA-CENARIO 2) (/ ALTURA-CENARIO 2) 3 5) TECLA-DIREITA)
              (make-personagem (+ (/ LARGURA-CENARIO 2) 3) (/ ALTURA-CENARIO 2) 3 5))
(check-equal? (trata-tecla-nave (make-personagem (/ LARGURA-CENARIO 2) (/ ALTURA-CENARIO 2) 3 5) TECLA-ESQUERDA)
              (make-personagem (- (/ LARGURA-CENARIO 2) 3) (/ ALTURA-CENARIO 2) -3 5))


;; Testes atualiza-jogo
; CASO NORMAL
(check-equal? (atualiza-jogo JOGO-INICIO)
              (make-jogo NAVE-INICIO
                         (list (make-personagem (- (- LARGURA-CENARIO (/ LARGURA-NAVE-INIMIGA 2)) 3) (/ ALTURA-CENARIO 2)
                                                DX-PADRAO-NAVE-INIMIGA DY-PADRAO-NAVE-INIMIGA))
                         empty empty 1 0 #false))


; CASO GAME-OVER
(check-equal? (atualiza-jogo (make-jogo NAVE-INICIO (list NAVE-INIMIGA-INICIO) empty empty 0 1 #true))
              JOGO-GAME-OVER)


;; Testes trata-tecla-jogo
(check-equal? (trata-tecla-jogo
               (make-jogo NAVE-INICIO (list NAVE-INIMIGA-INICIO) empty empty 0 0 #false)
               TECLA-ATIRAR
               )
              (make-jogo NAVE-INICIO (list NAVE-INIMIGA-INICIO)
                         (list (make-tiro LARGURA-NAVE (/ ALTURA-CENARIO 2) DX-PADRAO-TIROS)) empty 0 0 #false)
              )
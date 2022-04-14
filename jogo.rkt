#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require rackunit)

(require "constantes.rkt")
(require "personagem.rkt")
(require "tiro.rkt")
(require "utils.rkt")

(provide (all-defined-out))

;; ==========================================================================================
;; Definições de dados:

(define-struct jogo (nave ldin ldt ldtin mortes game-over?)#:transparent)
;; Jogo é (make-jogo Personagem List<Personagem> Natural Boolean)
;; interp. jogo contendo uma nave, varias naves inimigas, uma contagem de mortes, e uma flag
;; que indica se o jogo está em estado de game over ou não

;; Exemplo:
(define JOGO-INICIO (make-jogo NAVE-INICIO (list NAVE-INIMIGA-MEIO) (list empty) (list empty) 0 #false))

#;
(define (fn-para-jogo j)
  (... (jogo-nave j)
       (jogo-ldin j)
       (jogo-ldt j)
       (jogo-ldtin j)
       (jogo-mortes j)
       (jogo-game-over? j))
  )


;; =================
;; Funções:


;; Jogo -> Jogo
;; produz o próximo estado do jogo

;stub
;(define (atualiza-jogo j) j)

(define (atualiza-jogo j)
  (cond
    [(jogo-game-over? j) j]
    [(colidindo-com-algum? (jogo-nave j) (jogo-ldin j))
     (make-jogo
      (jogo-nave j)
      (jogo-ldin j)
      (jogo-ldt j)
      (jogo-ldtin j)
      (+ (jogo-mortes j) 1)
      #true)]
    [else
     (make-jogo
      (move-personagem (jogo-nave j))
      (move-personagens (jogo-ldin j))
      (jogo-ldt j)
      (jogo-ldtin j)
      (jogo-mortes j)
      (jogo-game-over? j))]
    )
  )



;; stub
;; (define (colidindo-tiro? t p2) #true)
;;!!!!!!!!!!!!!!!!!!!
(define (colidindo-tiro? t p)
  (let* (
         [soma-dos-raios-t-p (+ (/ LARGURA-TIRO 2) (/ LARGURA-NAVE-INIMIGA 2))]
         )
    (<= (distancia (personagem-x p) (personagem-y p) (tiro-x t) (tiro-y t))
        soma-dos-raios-t-p)
      )
  )
 

;; Jogo -> Image
;; desenha o jogo com os seus elementos

;stub
(define (desenha-jogo j)
  (let* ([contagem-mortes (text (string-append "mortes: " (number->string (jogo-mortes j))) 15 "red")])
    
    (place-image contagem-mortes (- LARGURA-CENARIO 40) 10 
               (if (jogo-game-over? j)
                   (place-image (text "GAME OVER" 50 "red") (/ LARGURA-CENARIO 2) (/ ALTURA-CENARIO 2) CENARIO)
                   (desenha-personagem (jogo-nave j) IMG-NAVE
                                      (desenha-personagens (jogo-ldin j) IMG-NAVE-INIMIGA CENARIO)
                                      )              
                 )
               )
    )
  )

;; Jogo KeyEvent -> Jogo
;; quando as teclas TECLA-CIMA, TECLA-BAIXO, TECLA-DIREITA, TECLA-ESQUERDA E TECLA-ATIRAR forem pressionada
;; produz os movimentos cima, baixo, direta e esquerda. Além disso, produz o tiro do personagem quando a TECLA-ATIRAR for pressionada.
#;
(define (trata-tecla-jogo j ke)
  (cond [(key=? ke " ") (... j)]
        [else
         (... j)]))


;; trata-tecla-nave: Personagem KeyEvent ->  Personagem
;; interp.quando as teclas de movimento (TECLA-CIMA, TECLA-BAIXO, TECLA-DIREITA, TECLA-ESQUERDA) forem pressionadas
;; movimenta o personagem nas quatro direções (inverte dx ou inverte o dy)

;stub
;(define (trata-tecla-nv nv ke) nv)

(define (trata-tecla-nave nv ke)
  (cond [(key=? ke TECLA-CIMA)
         (make-personagem (personagem-x nv) (personagem-y nv) (personagem-dx nv) (- DY-PADRAO-NAVE))]
        [(key=? ke TECLA-BAIXO)
         (make-personagem (personagem-x nv) (personagem-y nv) (personagem-dx nv) (abs (personagem-dy nv)))]
        [(key=? ke TECLA-DIREITA)
         (make-personagem (personagem-x nv) (personagem-y nv) (- (personagem-dx nv)) (personagem-dy nv))]
        [(key=? ke TECLA-ESQUERDA)
         (make-personagem (personagem-x nv) (personagem-y nv) (abs (personagem-dx nv)) (personagem-dy nv))]
        [else nv])
        )

;; Jogo KeyEvent ->  Jogo
;; interp.quando as teclas de movimento (TECLA-CIMA, TECLA-BAIXO, TECLA-DIREITA, TECLA-ESQUERDA) forem pressionadas
;; movimenta o personagem nas quatro direções (inverte dx ou inverte o dy)
;stub
;(define (trata-tecla-jogo j ke) j) 

(define (trata-tecla-jogo j ke)
         (make-jogo (trata-tecla-nave (jogo-nave j) ke) (jogo-ldin j) (jogo-ldt j) (jogo-ldtin j) (jogo-mortes j) (jogo-game-over? j)) 
        )


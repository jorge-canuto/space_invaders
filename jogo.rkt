#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require rackunit)

(require "constantes.rkt")
(require "personagem.rkt")
(require "tiro.rkt")
(require "utils.rkt")

(provide (all-defined-out))

;; =======================================================================================================================================
;; Definições de dados:

(define-struct jogo (nave ldin ldt ldtin counter mortes game-over?)#:transparent)
;; Jogo é (make-jogo Personagem List<Personagem> Natural Boolean)
;; interp. jogo contendo uma nave, varias naves inimigas, uma lista de tiros, um contador, uma contagem de mortes e uma flag
;; que indica se o jogo está em estado de game over ou não

;; Exemplo:
(define JOGO-INICIO (make-jogo NAVE-INICIO (list NAVE-INIMIGA-FINAL-CENARIO) empty empty 0 0 #false))
(define JOGO-GAME-OVER (make-jogo NAVE-INICIO (list NAVE-INIMIGA-INICIO) empty empty 0 1 #true))

#;
(define (fn-para-jogo j)
  (... (jogo-nave j)
       (jogo-ldin j)
       (jogo-ldt j)
       (jogo-ldtin j)
       (jogo-counter j)
       (jogo-mortes j)
       (jogo-game-over? j))
  )


;; ------------------------------------ INICIO DAS FUNCOES DO JOGO -----------------------------------------

;; Jogo -> Jogo
;; produz o próximo estado do jogo

;stub
;(define (atualiza-jogo j) j)

(define (atualiza-jogo j)
  (let* (
         [remocao-tiro-nave (verifica-tiro-nave (jogo-ldt j) (jogo-ldin j))]
         )
  (cond 
    [(jogo-game-over? j) j]
    [(colidindo-com-algum? (jogo-nave j) (jogo-ldin j))
     (make-jogo
      (jogo-nave j)
      (jogo-ldin j)
      (jogo-ldt j)
      (jogo-ldtin j)
      (+ (jogo-mortes j) 1)
      (+ (jogo-counter j) 1)
      #true)]
    [(= (jogo-counter j) 100)
      (make-jogo
      (move-personagem (jogo-nave j))
      (move-personagens (cons (make-personagem (- LARGURA-CENARIO LARGURA-NAVE) (random ALTURA-CENARIO) 3 3) (jogo-ldin j)))
      (move-tiros (jogo-ldt j))
      (jogo-ldtin j)
      (- (jogo-counter j) 100)
      (jogo-mortes j)
      (jogo-game-over? j))
     ]
    [else
     (make-jogo
      (move-personagem (jogo-nave j))
      (move-personagens (remove* (second remocao-tiro-nave)(jogo-ldin j)))
      (move-tiros (remove* (first remocao-tiro-nave)(jogo-ldt j)))
      (jogo-ldtin j)
      (+ (jogo-counter j) 1)
      (jogo-mortes j)
      (jogo-game-over? j))]
    )
   )
  )




;; colidindo-tiro?: Tiro Personagem -> boolean
;; retorna true se aconter uma colisão entre um tiro e um personagem, ou retorna false caso contrário

;; stub
;; (define (colidindo-tiro? t p2) #true)
(define (colidindo-tiro? t p)
  (let* (
         [soma-dos-raios-t-p (+ (/ LARGURA-TIRO 2) (/ LARGURA-NAVE-INIMIGA 2))]
         )
    (<= (distancia (personagem-x p) (personagem-y p) (tiro-x t) (tiro-y t))
        soma-dos-raios-t-p)
      )
  )






;; verifica-tiro-nave: List<Tiro> List<Personagem> -> List<List<Tiro> List<Personagem>>
;; retorna uma lista que possui duas listas, uma lista de tiros que destruiram naves inimigas
;; e uma lista de naves inimigas destruídas

;; stub
;; (define (verifica-tiro-nave ldt ldin) ldt)

(define (verifica-tiro-nave ldt ldin)
            (for/lists (firsts seconds #:result (list firsts seconds))
                   ([tiro ldt]
                    [nave ldin]
                    #:when (colidindo-tiro? tiro nave))
              (values tiro nave)
              )
        )






;;(define (tiro-acertou-algum?  ldt ldin)
;;  (cond [(or (empty? ldt)(empty? ldin)) false]                   ;CASO BASE (CONDIÇÃO DE PARADA)
;;        [(or (verifica-tiro? (first ldt) ldin)                    ;String
;;             (tiro-acertou-algum? (rest ldt) ldin))]))

;;(define (verifica-tiro? t ldin)
;;  (cond [(empty? ldin) false]                   ;CASO BASE (CONDIÇÃO DE PARADA)
;;        [(or (colidindo-tiro? t (first ldin))               ;String
;;             (verifica-tiro? t (rest ldin)))])) ;RECURSÃO EM CAUDA

;;(define (identifica-inimigo-destruido ldt ldin)
;;  (cond [(empty? ldin) empty]                   ;CASO BASE (CONDIÇÃO DE PARADA)
;;        [else(verifica-tiro? (first ldt) ldin (remove (first ldin) ldin)               ;String
;;          (verifica-tiro? (rest ldt) ldin))]))

;;(define (verifica-tiro-inimigo? ldt inimigo)
;;  (cond [(empty? ldt) false]                   ;CASO BASE (CONDIÇÃO DE PARADA)
;;        [else (colidindo-tiro? (first ldt) inimigo               ;String
;;                   (verifica-tiro-inimigo? (rest ldt) inimigo))])) ;RECURSÃO EM CAUDA









;; desenha-jogo: Jogo -> Image
;; desenha o jogo com os seus elementos

;;stub
;(define (desenha-jogo j) CENARIO)

(define (desenha-jogo j)
  (let* ([contagem-mortes (text (string-append "Mortes: " (number->string (jogo-mortes j))) 15 "red")])
    
    (place-image contagem-mortes (- LARGURA-CENARIO 40) 10 
               (if (jogo-game-over? j)
                   (place-image (text "GAME OVER" 50 "red") (/ LARGURA-CENARIO 2) (/ ALTURA-CENARIO 2) CENARIO)
                   (desenha-personagem (jogo-nave j) IMG-NAVE
                                      (desenha-personagens (jogo-ldin j) IMG-NAVE-INIMIGA
                                                           (desenha-tiros (jogo-ldt j) IMG-TIRO CENARIO)
                                                           )
                                      )              
                 )
               )
    )
  )






;; trata-tecla-nave: Personagem KeyEvent ->  Personagem
;; interp.quando as teclas de movimento (TECLA-CIMA, TECLA-BAIXO, TECLA-DIREITA, TECLA-ESQUERDA) forem pressionadas
;; movimenta o personagem nas quatro direções (inverte dx ou inverte o dy)

;stub
;(define (trata-tecla-nave nv ke) nv)

#;
(define (trata-tecla-nave nv ke)
  (cond [(key=? ke TECLA-CIMA) (... nv)]
        [else
         (... nv)]))

(define (trata-tecla-nave nv ke)
  (cond [(key=? ke TECLA-CIMA)
         (make-personagem (personagem-x nv) (- (personagem-y nv) DY-PADRAO-NAVE) (personagem-dx nv) (personagem-dy nv))]
        [(key=? ke TECLA-BAIXO)
         (make-personagem (personagem-x nv) (+ (personagem-y nv) DY-PADRAO-NAVE) (personagem-dx nv) (abs (personagem-dy nv)))]
        [(key=? ke TECLA-DIREITA)
         (make-personagem (+ (personagem-x nv) DX-PADRAO-NAVE) (personagem-y nv) (abs (personagem-dx nv)) (personagem-dy nv))]
        [(key=? ke TECLA-ESQUERDA)
         (make-personagem (- (personagem-x nv) DX-PADRAO-NAVE) (personagem-y nv) (- (personagem-dx nv)) (personagem-dy nv))]
        [else nv])
        )






;; trata-tecla-jogo: Jogo KeyEvent -> Jogo
;; quando as teclas TECLA-CIMA, TECLA-BAIXO, TECLA-DIREITA, TECLA-ESQUERDA E TECLA-ATIRAR forem pressionadas
;; produz os movimentos cima, baixo, direta e esquerda. Além disso, produz o tiro do personagem quando a TECLA-ATIRAR for pressionada.

;stub
;(define (trata-tecla-jogo j ke) j)

#;
(define (trata-tecla-jogo j ke)
  (cond [(key=? ke TECLA-ATIRAR) (... j)]
        [else
         (... j)]))


(define (trata-tecla-jogo j ke)
  (cond [(key=? ke TECLA-ATIRAR)
         (make-jogo (jogo-nave j) (jogo-ldin j) (cons(make-tiro (+ (personagem-x (jogo-nave j)) (/ LARGURA-NAVE 2)) (personagem-y (jogo-nave j)) DX-PADRAO-TIROS) (jogo-ldt j)) (jogo-ldtin j) (jogo-counter j) (jogo-mortes j) (jogo-game-over? j))] 
         [else (make-jogo (trata-tecla-nave (jogo-nave j) ke) (jogo-ldin j) (jogo-ldt j) (jogo-ldtin j) (jogo-counter j) (jogo-mortes j) (jogo-game-over? j))] 
        ))






;; release-tecla-nave: Personagem keyEvent -> Personagm
;; retorna um novo personagem dado o estado atual de um personagem e uma interação com o teclado

;stub
;(define (release-tecla-nave nv ke) nv)

#;
(define (release-tecla-nave nv ke)
  (cond [(key=? ke TECLA-CIMA) (... nv)]
        [else
         (... nv)]))


(define (release-tecla-nave nv ke)
  (cond [(key=? ke TECLA-CIMA)
         (make-personagem (personagem-x nv) (personagem-y nv) (personagem-dx nv) 0)]
        [(key=? ke TECLA-BAIXO)
         (make-personagem (personagem-x nv) (personagem-y nv) (personagem-dx nv) 0)]
        [(key=? ke TECLA-DIREITA)
         (make-personagem (personagem-x nv) (personagem-y nv) 0 (personagem-dy nv))]
        [(key=? ke TECLA-ESQUERDA)
         (make-personagem (personagem-x nv) (personagem-y nv) 0 (personagem-dy nv))]
        [else nv])
        )






;; release-tecla: Jogo keyEvent -> Jogo
;; retorna um novo estado do mundo dado o estado atual do jogo e uma interação com o teclado

;stub
;(define (release-tecla j ke) j)

#;
(define (release-tecla j ke)
  (cond [(key=? ke " ") (... j)]
        [else
         (... j)]))

(define (release-tecla j ke)
  (make-jogo (release-tecla-nave (jogo-nave j) ke) (jogo-ldin j) (jogo-ldt j) (jogo-ldtin j) (jogo-counter j) (jogo-mortes j) (jogo-game-over? j))
        )

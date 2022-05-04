#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require "constantes.rkt")
(require "utils.rkt")

(provide (all-defined-out))


;;============================================================================================================================================
;; Definições de dados:

(define-struct personagem (x y dx dy)#:transparent)
;; Personagem é (make-personagem Natural Natural Inteiro Inteiro Natural Natural)
;; interp. posicao do personagem nos eixos x e y, em pixels.
;; e dx e dy representando o vetor de deslocamento
;; isto é, direção, sentido e módulo da velocidade

;; Exemplos NAVE:
(define NAVE-INICIO (make-personagem (/ LARGURA-NAVE 2) (/ ALTURA-CENARIO 2) 0 0))
(define NAVE-MEIO (make-personagem (/ LARGURA-CENARIO 2) (/ ALTURA-CENARIO 2) DX-PADRAO-NAVE DY-PADRAO-NAVE))
(define NAVE-FINAL-CENARIO (make-personagem (- LARGURA-CENARIO LARGURA-NAVE) (/ ALTURA-CENARIO 2) DX-PADRAO-NAVE DY-PADRAO-NAVE))
(define NAVE-FINAL-CENARIO2 (make-personagem (- LARGURA-CENARIO LARGURA-NAVE) (/ ALTURA-CENARIO 3) DX-PADRAO-NAVE DY-PADRAO-NAVE))

;; Exemplos NAVE-INIMIGA
(define NAVE-INIMIGA-INICIO (make-personagem (/ LARGURA-NAVE-INIMIGA 2) (/ ALTURA-CENARIO 2) DX-PADRAO-NAVE-INIMIGA 0))
(define NAVE-INIMIGA-MEIO (make-personagem (/ LARGURA-CENARIO 2) (/ ALTURA-CENARIO 2) DX-PADRAO-NAVE-INIMIGA DY-PADRAO-NAVE-INIMIGA))
(define NAVE-INIMIGA-FINAL-CENARIO (make-personagem (- LARGURA-CENARIO (/ LARGURA-NAVE-INIMIGA 2)) (/ ALTURA-CENARIO 2) DX-PADRAO-NAVE-INIMIGA DY-PADRAO-NAVE-INIMIGA))


#;
(define (fn-para-personagem p)
  (... (personagem-x p)
       (personagem-y p)
       (personagem-dx p)
       (personagem-dy p)
       (personagem-largura p)
       (personagem-altura p))
  )

;; List<Personagem> é (cons Personagem List<Personagem>)
;; interp. lista de personagens
; Exemplos
(define LISTA-INIMIGOS-VAZIA empty)
(define LISTA-INIMIGOS (list NAVE-INIMIGA-INICIO NAVE-INIMIGA-MEIO NAVE-INIMIGA-FINAL-CENARIO))

#;
(define (fn-para-ldp ldp)
  (cond [(empty? ldp) (...)]                   ;CASO BASE (CONDIÇÃO DE PARADA)
        [else (... (first ldp)                 ;String
                   (fn-for-ldp (rest ldp)))])) ;RECURSÃO EM CAUDA

;;============================================================================================================================================

;; ------------------------------------ INICIO DAS FUNCOES DO PERSONAGEM -----------------------------------------

;; Personagem -> Personagem
;; move o personagem de acordo com seu valor dx

(define (move-personagem p)
  (let* (
      [novo-x (- (personagem-x p) (personagem-dx p))]
      )
    
  (make-personagem
   ;x:
   novo-x
   ;y:
   (personagem-y p)
   ;dx
   ;;(if (or bateu-no-limite-direito? bateu-no-limite-esquerdo?)
   ;;    (- (personagem-dx p)) ;then
   ;;    (personagem-dx p))  ;else
   (personagem-dx p)
   ;dy
   ;;(if (or bateu-no-limite-cima? bateu-no-limite-baixo?)
   ;;    (- (personagem-dy p)) ;then
   ;;    (personagem-dy p))  ;else
   (personagem-dy p)
   )
    )
  )


;; move-personagens: List<Personagem> -> List<Personagem>
;; move todos os personagens de uma lista

;; stub
;;(define move-persongens ldp) ldp)

;(define (move-personagens ldp)
;  (cond [(empty? ldp) empty]                   ;CASO BASE (CONDIÇÃO DE PARADA)
;        [else (cons (move-personagem (first ldp))                 ;String
;                   (move-personagens (rest ldp)))])) ;RECURSÃO EM CAUDA

(define (move-personagens ldp)
  (map move-personagem ldp)
  )




;; colidindo?: Personagem Personagem -> boolean
;; retorna true se par de personagens estiverem colidindo, ou false caso contrario

;; stub
;; (define (colidindo? p1 p2) #true)

(define (colidindo? p1 p2)
  (let* (
         [soma-dos-raios-dos-personagens (+ (/ LARGURA-NAVE 2) (/ LARGURA-NAVE-INIMIGA 2))]
         )
    (<= (distancia (personagem-x p1) (personagem-y p1) (personagem-x p2) (personagem-y p2))
        soma-dos-raios-dos-personagens)
      )
  )




;; colidindo-com-algum?: Personagem List<Personagem> -> boolean
;; retorna true se o primeiro personagem colide com algum dos outros personagens

;; stub
;; (define (colidindo-com-algum? p1 ldin) #false)

;(define (colidindo-com-algum? p ldp)
;  (cond [(empty? ldp) #false]                   ;CASO BASE (CONDIÇÃO DE PARADA)
;        [else (or (colidindo? p (first ldp))                 ;String
;                   (colidindo-com-algum? p (rest ldp)))])) ;RECURSÃO EM CAUDA

(define (colidindo-com-algum? p ldin)
  (ormap (lambda (p1) (colidindo? p p1)) ldin)
 )






;; desenha-tela: Image Image -> Image
;; desenha a tela de fundo do jogo

;(define (desenha-tela img cena)
;  (place-image img
;               (/ ALTURA-CENARIO 2)
;               (/ LARGURA-CENARIO 2)
;               cena)
;  )






;; desenha-personagem: Personagem Image Image -> Image
;; desenha o personagem na tela

;; stub
;(define (desenha-personagem p img fundo) fundo)

(define (desenha-personagem p img fundo)
 (place-image img
               (personagem-x p)
               (personagem-y p)
               fundo
               )
  )







;; desenha-personagens: List<Personagem> Image Image -> Image
;; desenha varios personagens na tela

;(define (desenha-personagens ldp img fundo) fundo)
(define (desenha-personagens  ldin img fundo)
  (cond [(empty? ldin) fundo]                   ;CASO BASE (CONDIÇÃO DE PARADA)
        [else (desenha-personagem (first ldin) img                 ;String
                   (desenha-personagens (rest ldin) img fundo))]))
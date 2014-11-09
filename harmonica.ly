%{
A small file to help when scoring notation for harmonicas.

This file relies heavily on work presented by Bradford Powell in
the following thread;

http://osdir.com/ml/lilypond-user-gnu/2010-04/msg00250.html

  %}

\version "2.18.0"

slap =
#(let ((m (make-articulation "flageolet")))
   (set! (ly:music-property m 'tweaks)
      (acons 'font-size -3 (ly:music-property m 'tweaks)))
   m)

#(define (NoteEvent? music)
   (equal? (ly:music-property music 'name) 'NoteEvent))

#(define* (blow hole #:optional (bends 0))
  (case bends
    ((0) (markup (#:concat (hole "+"))))
    ((1) (markup (#:concat (hole "+'"))))
    ((2) (markup (#:concat (hole "+''"))))
    ((3) (markup (#:concat (hole "+'''"))))
    (else (markup " "))))


#(define* (draw hole #:optional (bends 0))
  (case bends
    ((0) (markup hole))
    ((1) (markup (#:concat (hole "'"))))
    ((2) (markup (#:concat (hole "''"))))
    ((3) (markup (#:concat (hole "'''"))))
    (else (markup " "))))

#(define (get-harmonica-tab NoteEvent)
   (case (ly:pitch-semitones (ly:music-property NoteEvent 'pitch))
    ((-12) (blow "1"))
    ((-11) (draw "1" 1))
    ((-10) (draw "1"))
    ;((-9) (overblow "1"))
    ((-8) (blow "2"))
    ((-7) (draw "2" 2))
    ((-6) (draw "2" 1))
    ((-5) (draw "2"))
    ;((-5) (blow "3"))
    ((-4) (draw "3" 3))
    ((-3) (draw "3" 2))
    ((-2) (draw "3" 1))
    ((-1) (draw "3"))
    ((0) (blow "4"))
    ((1) (draw "4" 1))
    ((2) (draw "4"))
    ;((3) (overblow "4"))
    ((4) (blow "5"))
    ((5) (draw "5"))
    ;((6) (overblow "5"))
    ((7) (blow "6"))
    ((8) (draw "6" 1))
    ((9) (draw "6"))
    ;((10) (overblow "6"))
    ((11) (draw "7"))
    ((12) (blow "7"))
    ;((13) (overdraw "7"))
    ((14) (draw "8"))
    ((15) (blow "8" 1))
    ((16) (blow "8"))
    ((17) (draw "9"))
    ((18) (blow "9" 1))
    ((19) (blow "9"))
    ;((20) (overdraw "9"))
    ((21) (draw "10"))
    ((22) (blow "10" 2))
    ((23) (blow "10" 1))
    ((24) (blow "10"))
    (else (markup #:simple " "))))

#(define (make-textscript dir txt)
   (make-music 'TextScriptEvent
               'direction dir
               'text txt))

#(define (make-tab-number NoteEvent)
   (make-textscript
     UP
     (get-harmonica-tab NoteEvent)))

#(define (make-tab-numbers EventChord)
   (let ((elts (ly:music-property EventChord 'elements)))
     (map make-tab-number (filter NoteEvent? elts))))

% (ly:warning "msg")
#(define (append-property! music property element)
     (set! (ly:music-property music property)
                (append! (ly:music-property music property)
		                    (list element)))
				         music)
#(define (add-tab-numbers m)
   (cond ((music-is-of-type? m 'event-chord)
       (set! (ly:music-property m 'elements)
             (append (ly:music-property m 'elements)
                     (make-tab-numbers m))))
         ((music-is-of-type? m 'note-event)
       (set! (ly:music-property m 'articulations)
             (append (ly:music-property m 'articulations)
                     (list (make-tab-number m)))))
	(else #f)
    )
    m)

harmonicaTab =
#(define-music-function
  (parser location music)
  (ly:music?)
  (music-map add-tab-numbers music))


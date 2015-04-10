%{
A small file to help when scoring notation for harmonicas.

This file relies heavily on work presented by Bradford Powell in
the following thread;

http://osdir.com/ml/lilypond-user-gnu/2010-04/msg00250.html

  %}

\version "2.18.0"

shake = #(define-event-function (parser location) ()
  #{ :32 #}
)

slap =
#(let ((m (make-articulation "flageolet")))
   (set! (ly:music-property m 'tweaks)
      (acons 'font-size -3 (ly:music-property m 'tweaks)))
   m)

dip =
#(let ((m (make-articulation "upbow")))
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
    ;;; ((0) (markup hole))
    ((0) (if (equal? hole "2")(markup "2/3+")(markup hole)))
    ((1) (markup (#:concat (hole "'"))))
    ((2) (markup (#:concat (hole "''"))))
    ((3) (markup (#:concat (hole "'''"))))
    (else (markup " "))))

#(define (get-harmonica-tab NoteEvent)
   (case (ly:pitch-semitones (ly:music-property NoteEvent 'pitch))
    ((0) (blow "1"))
    ((1) (draw "1" 1))
    ((2) (draw "1"))
    ;((3) (overblow "1"))
    ((4) (blow "2"))
    ((5) (draw "2" 2))
    ((6) (draw "2" 1))
    ((7) (draw "2"))
    ;((7) (blow "3"))
    ((8) (draw "3" 3))
    ((9) (draw "3" 2))
    ((10) (draw "3" 1))
    ((11) (draw "3"))
    ((12) (blow "4"))
    ((13) (draw "4" 1))
    ((14) (draw "4"))
    ;((15) (overblow "4"))
    ((16) (blow "5"))
    ((17) (draw "5"))
    ;((18) (overblow "5"))
    ((19) (blow "6"))
    ((20) (draw "6" 1))
    ((21) (draw "6"))
    ;((22) (overblow "6"))
    ((23) (draw "7"))
    ((24) (blow "7"))
    ;((25) (overdraw "7"))
    ((26) (draw "8"))
    ((27) (blow "8" 1))
    ((28) (blow "8"))
    ((29) (draw "9"))
    ((30) (blow "9" 1))
    ((31) (blow "9"))
    ;((32) (overdraw "9"))
    ((33) (draw "10"))
    ((34) (blow "10" 2))
    ((35) (blow "10" 1))
    ((36) (blow "10"))
    (else (markup #:simple " "))))

#(define (make-textscript dir txt)
   (make-music 'TextScriptEvent
               'direction dir
               'text txt))

#(define (make-tab-number NoteEvent)
   (make-textscript
     DOWN
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


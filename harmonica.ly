%{
A small file to help when scoring notation for harmonicas.

This file relies heavily on work presented by Bradford Powell in
the following thread;

http://osdir.com/ml/lilypond-user-gnu/2010-04/msg00250.html
%}

\version "2.24.0"

flutter = #(define-event-function (parser location) ()
  #{ :32 #}
)

shake = #(define-event-function (parser location) ()
  #{ :32 #}
)


pull = {
   \once \override Staff.NoteHead.style = #'slash
  }

quartertone =
#(let ((m (make-articulation 'stopped)))
   (set! (ly:music-property m 'tweaks)
      (acons 'font-size 2 (ly:music-property m 'tweaks)))
   m)
slap =
#(let ((m (make-articulation 'flageolet)))
   (set! (ly:music-property m 'tweaks)
      (acons 'font-size -3 (ly:music-property m 'tweaks)))
   m)

dip =
#(let ((m (make-articulation 'upbow)))
   (set! (ly:music-property m 'tweaks)
      (acons 'font-size -3 (ly:music-property m 'tweaks)))
   m)

#(define (NoteEvent? music)
   (equal? (ly:music-property music 'name) 'NoteEvent))

#(define* (blow hole #:optional (bends 0))
  (case bends
    ((0) (markup (#:concat ("+" hole))))
    ((1) (markup (#:concat ("+" hole "'"))))
    ((2) (markup (#:concat ("+" hole "''"))))
    (else (markup "B"))))

#(define* (draw hole #:optional (bends 0))
  (case bends
    ((0) (markup (#:concat ("-" hole))))
    ((1) (markup (#:concat ("-" hole "'"))))
    ((2) (markup (#:concat ("-" hole "''"))))
    ((3) (markup (#:concat ("-" hole "'''"))))
    (else (markup "D"))))

#(define (overblow hole)
   (markup (#:concat ("+" hole "o"))))

#(define (overdraw hole)
   (markup (#:concat ("-" hole "o"))))

#(define (slide hole)
   (markup (#:concat (hole "<"))))

#(define (low-register hole)
   (markup (#:concat (hole "°"))))

#(define (get-diatonic-b-ritcher-tab NoteEvent)
   (case (ly:pitch-semitones (ly:music-property NoteEvent 'pitch))
    ((-1) (blow "1"))
    ((0) (draw "1" 1))
    ((1) (draw "1"))
    ((2) (overblow "1"))
    ((3) (blow "2"))
    ((4) (draw "2" 2))
    ((5) (draw "2" 1))
    ((6) (draw "2"))
    ((7) (draw "3" 3))
    ((8) (draw "3" 2))
    ((9) (draw "3" 1))
    ((10) (draw "3"))
    ((11) (blow "4"))
    ((12) (draw "4" 1))
    ((13) (draw "4"))
    ((14) (overblow "4"))
    ((15) (blow "5"))
    ((16) (draw "5"))
    ((17) (overblow "5"))
    ((18) (blow "6"))
    ((19) (draw "6" 1))
    ((20) (draw "6"))
    ((21) (overblow "6"))
    ((22) (draw "7"))
    ((23) (blow "7"))
    ((24) (overdraw "7"))
    ((25) (draw "8"))
    ((26) (blow "8" 1))
    ((27) (blow "8"))
    ((28) (draw "9"))
    ((29) (blow "9" 1))
    ((30) (blow "9"))
    ((31) (overdraw "9"))
    ((32) (draw "10"))
    ((33) (blow "10" 2))
    ((34) (blow "10" 1))
    ((35) (blow "10"))
    (else (markup "X"))))

#(define (get-diatonic-c-ritcher-tab NoteEvent)
   (case (ly:pitch-semitones (ly:music-property NoteEvent 'pitch))
    ((0) (blow "1"))
    ((1) (draw "1" 1))
    ((2) (draw "1"))
    ((3) (overblow "1"))
    ((4) (blow "2"))
    ((5) (draw "2" 2))
    ((6) (draw "2" 1))
    ((7) (draw "2"))
    ((8) (draw "3" 3))
    ((9) (draw "3" 2))
    ((10) (draw "3" 1))
    ((11) (draw "3"))
    ((12) (blow "4"))
    ((13) (draw "4" 1))
    ((14) (draw "4"))
    ((15) (overblow "4"))
    ((16) (blow "5"))
    ((17) (draw "5"))
    ((18) (overblow "5"))
    ((19) (blow "6"))
    ((20) (draw "6" 1))
    ((21) (draw "6"))
    ((22) (overblow "6"))
    ((23) (draw "7"))
    ((24) (blow "7"))
    ((25) (overdraw "7"))
    ((26) (draw "8"))
    ((27) (blow "8" 1))
    ((28) (blow "8"))
    ((29) (draw "9"))
    ((30) (blow "9" 1))
    ((31) (blow "9"))
    ((32) (overdraw "9"))
    ((33) (draw "10"))
    ((34) (blow "10" 2))
    ((35) (blow "10" 1))
    ((36) (blow "10"))
    (else (markup "X"))))

#(define (get-chromatic-c-solo-tab NoteEvent)
   (case (ly:pitch-semitones (ly:music-property NoteEvent 'pitch))
    ((-12) (blow (low-register "1")))          
    ((-11) (blow (slide (low-register "1"))))  
    ((-10) (draw (low-register "1")))          
    ((-9) (draw (slide (low-register "1"))))   
    ((-8) (blow (low-register "2")))           
    ((-7) (draw (low-register "2")))           
    ((-6) (draw (slide (low-register "2"))))   
    ((-5) (blow (low-register "3")))           
    ((-4) (blow (slide (low-register "3"))))   
    ((-3) (draw (low-register "3")))           
    ((-2) (draw (slide (low-register "3"))))   
    ((-1) (draw (low-register "4")))           
    
    ((0) (blow "1"))           
    ((1) (slide (blow "1")))   
    ((2) (draw "1"))           
    ((3) (slide (draw "1")))    
    ((4) (blow "2"))           
    ((5) (draw "2"))           
    ((6) (slide (draw "2")))   
    ((7) (blow "3"))           
    ((8) (slide (blow "3")))   
    ((9) (draw "3"))           
    ((10) (slide (draw "3")))  
    ((11) (draw "4"))          
    
    ((12) (blow "5"))          
    ((13) (slide (blow "5")))   
    ((14) (draw "5"))           
    ((15) (slide (draw "5")) )   
    ((16) (blow "6"))           
    ((17) (draw "6"))           
    ((18) (slide (draw "6")))   
    ((19) (blow "7"))           
    ((20) (slide (blow "7")))   
    ((21) (draw "7"))           
    ((22) (slide (draw "7")))  
    ((23) (draw "8"))          
    
    ((24) (blow "9"))           
    ((25) (slide (blow "9")))    
    ((26) (draw "9"))            
    ((27) (slide (draw "9")))   
    ((28) (blow "10"))           
    ((29) (draw "10"))           
    ((30) (slide (draw "10")))   
    ((31) (blow "11"))           
    ((32) (slide (blow "11")))   
    ((33) (draw "11"))           
    ((34) (slide (draw "11")))  
    ((35) (draw "12"))          
    
    ((36) (blow "12"))          
    ((37) (slide (blow "12")))  
    ((38) (slide (draw "12")))  
    (else (markup "X"))))

#(define (make-textscript dir txt)
   (make-music 'TextScriptEvent
               'direction dir
               'text txt))

#(define (make-tab-number NoteEvent tuning)
   (make-textscript
     DOWN
     (case tuning
       ((diatonic-c-ritcher) (get-diatonic-c-ritcher-tab NoteEvent))
       ((diatonic-b-ritcher) (get-diatonic-b-ritcher-tab NoteEvent))
       ((chromatic-c-solo) (get-chromatic-c-solo-tab NoteEvent))
       (else (diatonic-c-ritcher) (get-diatonic-c-ritcher-tab NoteEvent)))))

#(define (make-tab-numbers EventChord tuning)
   (let ((elts (ly:music-property EventChord 'elements)))
     (map make-tab-number (filter NoteEvent? elts))))

#(define (append-property! music property element)
     (set! (ly:music-property music property)
                (append! (ly:music-property music property)
		                    (list element)))
				         music)

#(define* (add-harmonica-tabs tuning m)
   (cond ((music-is-of-type? m 'event-chord)
       (set! (ly:music-property m 'elements)
             (append (ly:music-property m 'elements)
                     (reverse (make-tab-numbers m tuning)))))
         ((music-is-of-type? m 'note-event)
       (set! (ly:music-property m 'articulations)
             (append (ly:music-property m 'articulations)
                     (list (make-tab-number m tuning)))))
	(else #f)
    )
    m)


diatonicHarmonicaTabB =
#(define-music-function
  (parser location music)
  (ly:music?)
  (music-map (lambda (m) (add-harmonica-tabs 'diatonic-b-ritcher m)) music))

diatonicHarmonicaTabC =
#(define-music-function
  (parser location music)
  (ly:music?)
  (music-map (lambda (m) (add-harmonica-tabs 'diatonic-c-ritcher m)) music))

chromaticHarmonicaTabC =
#(define-music-function
  (parser location music)
  (ly:music?)
  (music-map (lambda (m) (add-harmonica-tabs 'chromatic-c-solo m)) music))

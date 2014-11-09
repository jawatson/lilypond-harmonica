
\version "2.18.0"

\include "harmonica.ly"


\layout {
   #(layout-set-staff-size 16)

   \context { \Score
      \override MetronomeMark #'padding = #'5
   }
   \context { \Staff
      \override TimeSignature #'style = #'numbered
      \override StringNumber #'transparent = ##t
   }
   \context { \TabStaff
      \override TimeSignature #'style = #'numbered
      \override Stem #'transparent = ##t
      \override Flag #'transparent = ##t
      \override Beam #'transparent = ##t
   }
   \context { \TabVoice
      \override Tie #'stencil = ##f
   }
   \context { \StaffGroup
      \consists "Instrument_name_engraver"
   }
}

\harmonicaTab \relative c' {
  \override TextScript.extra-offset = #'(0 . -11) 
  d,4 e4\slap g4 <b c>8 c8 \tuplet 3/2 {b8 g e}
}

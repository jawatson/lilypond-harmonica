\version "2.22.0"

\layout {
   #(layout-set-staff-size 20)

   \context { \Score
      \override MetronomeMark #'padding = #5
      \override SpacingSpanner.base-shortest-duration = #(ly:make-moment 1/128)
      \override TextScript.font-size = #-2
        \override TextScript.padding = #5
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

\paper {
  system-system-spacing.minimum-distance = #20
}

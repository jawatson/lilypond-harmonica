
\version "2.22.0"

\include "harmonica.ly"
\include "style.ly"

chromaticScale = {
   b16 c cis d dis e f fis gis a ais b c
   cis d dis e f fis gis a ais b c
   cis d dis e f fis gis a ais b c
   cis d dis e f fis gis a ais b c cis d dis
 }
   
\chromaticHarmonicaTab \relative c {
  \time 2/4
  \chromaticScale
} 

\diatonicHarmonicaTab \relative c {
  \time 2/4
  \chromaticScale
} 

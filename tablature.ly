
\version "2.24.0"

\include "harmonica.ly"
\include "style.ly"

chromaticScale = {
   b16 c cis d dis e f fis gis a ais b c
   cis d dis e f fis gis a ais b c
   cis d dis e f fis gis a ais b c
   cis d dis e f fis gis a ais b c cis d dis
 }

\chromaticHarmonicaTabC \relative c {
  \time 2/4
  \chromaticScale
}

\diatonicHarmonicaTabC \relative c {
  \time 2/4
  \chromaticScale
}

\diatonicHarmonicaTabB \relative c {
  \time 2/4
  \chromaticScale
}

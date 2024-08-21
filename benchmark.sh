#!/bin/bash

compiler="pdflatex"
for EXT in pdf png; do
  mkdir -p $EXT
  
  HEADER="\documentclass{article}\usepackage{graphicx}\begin{document}"
  
  echo $HEADER > $EXT-example.tex
  echo "$EXT files" >> $EXT-example.tex
  
  for i in $(seq -w 0 29); do
    if [ ! -f $EXT/trophy-$i.$EXT ]; then
      cp trophy.$EXT $EXT/trophy-$i.$EXT
    fi
    echo "\includegraphics{$EXT/trophy-$i.$EXT}" >> $EXT-example.tex
  done
  
  FOOTER="\end{document}"
  echo $FOOTER >> $EXT-example.tex
  
  # Capure time to print nicely
  TIME=$( { time (pdflatex -interaction=batchmode "$EXT-example.tex" >/dev/null 2>&1); } 2>&1 | grep real)
  
  # Remove 'real' and format the output
  TIME=${TIME#real}

  echo "$compiler using .$EXT images: $TIME"

  # clean up tex mess
  rm $EXT-example.{aux,log,pdf,tex}
done


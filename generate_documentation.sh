#!/bin/bash

TARGET="fontawesome"

echo -e "Generating documentation for $TARGET\c"
lualatex --interaction=batchmode --draftmode $TARGET.tex > /dev/null       && echo -e ".\c";
makeindex -s gglo.ist -o $TARGET.gls $TARGET.glo         > /dev/null 2>&1  && echo -e ".\c";
makeindex -s gind.ist -o $TARGET.ind $TARGET.idx         > /dev/null 2>&1  && echo -e ".\c";
lualatex --interaction=batchmode $TARGET.tex             > /dev/null       && echo -e ".\c";
lualatex --interaction=batchmode $TARGET.tex             > /dev/null       && echo " done";

rm $TARGET.aux $TARGET.g* $TARGET.hd $TARGET.i* $TARGET.log $TARGET.out


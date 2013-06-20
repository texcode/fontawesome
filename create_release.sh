#!/bin/sh

TARGET="fontawesome"


# CLEANUP
#--------

rm *~;


# REGENERATE DOCUMENTATION
#-------------------------

./generate_documentation.sh > /dev/null;


# CREATE TDS ZIP
#---------------

# tex class/package
mkdir -p "tex/latex/$TARGET"
cp "$TARGET.sty" "tex/latex/$TARGET/"

# documentation
mkdir -p "doc/latex/$TARGET"
cp "README" "doc/latex/$TARGET/"
cp "$TARGET.tex" "doc/latex/$TARGET/"
cp "$TARGET.pdf" "doc/latex/$TARGET/"

# otf font
mkdir -p "fonts/opentype/public/$TARGET"
cp "FontAwesome.otf" "fonts/opentype/public/$TARGET/"

# type1 font
mkdir -p "fonts/tfm/public/$TARGET"
cp "FontAwesome--fontawesome.tfm" "fonts/tfm/public/$TARGET/"
mkdir -p "fonts/type1/public/$TARGET"
cp "fontawesome.pfb" "fonts/type1/public/$TARGET/"
mkdir -p "fonts/enc/pdftex/$TARGET"
cp "fontawesome.enc" "fonts/enc/pdftex/$TARGET/"

# zip tds directories
zip -q -r -9 "$TARGET.tds.zip" "tex/" "doc/" "fonts/"

# remove tds directories
rm -Rf "tex/" "doc/" "fonts/"


# CREATE RELEASE ZIP
#-------------------

zip -q -r -9 "$TARGET.zip" "README" "$TARGET.sty" "$TARGET.tex" "$TARGET.pdf" "FontAwesome.otf" "$TARGET.tds.zip"
mv "$TARGET.zip" ../
rm "$TARGET.tds.zip"

#!/bin/sh

TFM=texmf/fonts/tfm/fontawesome
ENC=texmf/fonts/enc/pdftex/fontawesome
T1=texmf/fonts/type1/fontawesome

mkdir -p $TFM
mkdir -p $ENC
mkdir -p $T1

otftotfm   FontAwesome.otf \
      --literal-encoding  fontawesome.enc \
      --tfm-directory=$TFM  \
      --encoding-directory=$ENC \
      --type1-directory=$T1

mv fontawesome.enc $ENC

#      --pl-directory=DIR       Put PL files in DIR [.|automatic].
#      --vpl-directory=DIR      Put VPL files in DIR [.|automatic].

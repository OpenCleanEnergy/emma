#!/usr/bin/env bash

for src in 0-raw/*.png; do
  echo $src
  NAME=$(echo $src | cut -f 2 -d '/')

  CROP='1-crop'
  mkdir -p $CROP
  magick $src -crop +26-29 -crop -26+70 $CROP/$NAME
done


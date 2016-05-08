#!/bin/sh
find . -name "*.eep" -exec git rm {} \;
find . -name "*.elf" -exec git rm {} \;
find . -name "*.hex" -exec git rm {} \;
find . -name "*.autosave" -exec git rm {} \;
find . -name "*.r2012a" -exec git rm {} \;
find . -name "slprj" -exec git rm -r {} \;
find . -name "*_ert_rtw" -exec git rm -r {} \;

find . -name "*.eep" -exec rm {} \;
find . -name "*.elf" -exec rm {} \;
find . -name "*.hex" -exec rm {} \;
find . -name "*.autosave" -exec rm {} \;
find . -name "*.r2012a" -exec rm {} \;
find . -name "slprj" -exec rm -r {} \;
find . -name "*_ert_rtw" -exec rm -r {} \;

#!/bin/bash

# Define the compiler
CC=x86_64-w64-mingw32-gcc

# Define flags
# -D_WIN32: Standard Windows define (usually auto-defined but good to be explicit)
# -DMORE_NONE: Disable the pager to avoid curses/termcap dependencies
# -DTEXTFILE=\"dtextc.dat\": Define the data file name
CFLAGS="-O2 -D_WIN32 -DMORE_NONE -DTEXTFILE=\"dtextc.dat\""

# Source files
SRCS="actors.c ballop.c clockr.c demons.c dgame.c dinit.c dmain.c \
      dso1.c dso2.c dso3.c dso4.c dso5.c dso6.c dso7.c dsub.c dverb1.c \
      dverb2.c gdt.c lightp.c local.c nobjs.c np.c np1.c np2.c np3.c \
      nrooms.c objcts.c rooms.c sobjs.c supp.c sverbs.c verbs.c villns.c"

echo "Compiling for Windows..."
$CC $CFLAGS -o zork.exe $SRCS

if [ $? -eq 0 ]; then
    echo "Build successful: zork.exe"
else
    echo "Build failed"
    exit 1
fi

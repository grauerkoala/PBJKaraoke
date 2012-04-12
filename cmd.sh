#!/bin/sh
in=input

test -e $in || echo "$in wurde nicht gefunden!"
while true; do
    echo -n "# "
    read n
    test "$n" = "quit" && exit
    echo $n>$in
done;

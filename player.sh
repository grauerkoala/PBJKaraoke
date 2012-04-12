#!/bin/sh
# This software was written by Markus Bach <markus@derpaderborner.de>
# It is licensed as beerware. So drink up and get me a beer!
# Just kidding. Have fun with this piece of crap.

# Kommandos werden in die inputdatei geschrieben, z.B. mit echo oder cat oder
# was für Blödsinn du benutzen willst.
# Momentan gibt es 2 Kommandos:
# play [file] - Versucht die Datei file mit mplayer auszugeben
# text [text] - Erzeugt ein Bild mit dem text und zeigt dieses an

inputfile=input
log=log
background=alles_ist_gut.png
textbild=$background
dir=$PWD
b=textbild.jpg

pid=0
mpid=0
play() {
    mplayer $1 &
    mpid=$!
    sleep 2s;
    test $pid -eq 0 || kill $pid
}
text() {
    test $pid -eq 0 || kill $pid
    test -e $b && rm $b
    width=$(identify -format %w $textbild)
    convert -background '#000' -fill white -gravity center -pointsize 25\
    -size ${width}x150 caption:"$1" $textbild +swap -gravity south\
    -composite $b
    feh -F "$b" &
    pid=$!
}
main() {
    feh -F $background &
    while true; do
        while read n; do
            cmd=$(expr "$n" : '\([a-Z]*\)')
            arg=${n##$cmd}
            case "$cmd" in
                play)
                    file=$(basename $arg)
                    test -f "$dir/$file" && play "$dir/$file" || echo "$(date) Datei '$file' nicht gefunden!">>$log
                    ;;
                text)
                    text "$arg"
                    ;;
                stop)
                    kill $mpid
                    kill $pid
                    ;;
            esac
        done < $inputfile
    done
    echo "Die schleife ist beendet"
    killall feh
}
main

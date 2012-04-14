// ==UserScript==
// @name           PBJ Karaoke Firefox Skript
// @updateURL      about:blank
// @description    Packt auf youtube nen button, der dann irgendwas macht
// @author         Markus Bach
// @version        0.0.2
// @include        http://youtube.com/*
// @include        https://youtube.com/*
// @include        http://www.youtube.com/*
// @include        https://www.youtube.com/*
// ==/UserScript==

var button=document.createElement("button");
button.setAttribute("class","yt-uix-button yt-uix-button-default");
button.setAttribute("role","button");
button.setAttribute("type","button");
button.setAttribute("style","color:#f00;float:left;margin-right:10px;");
button.setAttribute("id","ytdlmoep");
var buttonText=document.createElement("span");
buttonText.appendChild(document.createTextNode("DOWNLOAD"));
button.appendChild(buttonText);
document.getElementById("watch-headline-user-info").appendChild(button);

document.addEventListener('click', function(event) {
    if (event.target.getAttribute('id') =='ytdlmoep') {
        GM_xmlhttpRequest({
            method: 'GET',
            url: 'http://localhost:4242/' + window.location.href,
            headers: {
                'User-agent': 'Mozilla/4.0 (compatible) Greasemonkey',
                'Accept': 'application/atom+xml,application/xml,text/xml',
            },
            onload: function(responseDetails) {
                if(responseDetails.status == 200) {
                    document.getElementById("ytdlmoep").firstChild.innerHTML='queued';
                    document.getElementById("ytdlmoep").disabled=true;
                }
                else {
                    document.getElementById("ytdlmoep").firstChild.innerHTML="error";
                }
            },
            onerror: function(error) {
                document.getElementById("ytdlmoep").firstChild.innerHTML="error";
            }
        });
    }
}, true);

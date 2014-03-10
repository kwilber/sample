/*
 2011 Kristopher Wilber
*/
function eventSource(e) {
   var IE = document.all ? true:false;
   var DOM = document.addEventListener ? true: false;
   if (IE) return event.srcElement;
   else if (DOM) return e.currentTarget;
}

function setUpTranslation() {
   phrases = document.getElementsByTagName("p");
   for (i=0; i<phrases.length; i++) {
      phrases[i].childNodes[1].innerHTML=french[i];
      phrases[i].childNodes[1].onmousedown=swapFE;
      phrases[i].childNodes[1].onmouseup=swapEF;
   }
}

function swapFE(e) {
   phrase=eventSource(e);
   if (phrase.nodeName == "#text") phrase=eventSource(e).parentNode;
   phraseNum=parseInt(phrase.previousSibling.innerHTML);
   phrase.innerHTML=english[phraseNum-1];
   phrase.style.fontStyle="normal";
   phrase.style.color="rgb(155,102,102)";
}

function swapEF(e) {
   phrase=eventSource(e);
   if (phrase.nodeName == "#text") phrase=eventSource(e).parentNode;
   phraseNum=parseInt(phrase.previousSibling.innerHTML);
   phrase.innerHTML=french[phraseNum-1];
   phrase.style.fontStyle="italic";
   phrase.style.color="black";
}

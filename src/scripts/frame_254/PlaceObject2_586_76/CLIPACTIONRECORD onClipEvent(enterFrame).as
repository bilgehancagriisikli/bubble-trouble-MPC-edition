onClipEvent(enterFrame){
   onda = sada;
   sada = getTimer();
   _root.rate = (sada - onda) / 1000;
}

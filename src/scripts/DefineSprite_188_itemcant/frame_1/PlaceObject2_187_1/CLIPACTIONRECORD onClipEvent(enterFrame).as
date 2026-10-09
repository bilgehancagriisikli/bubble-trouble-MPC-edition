onClipEvent(enterFrame){
   pocet = getTimer();
   if(pocet - kraj >= 500)
   {
      removeMovieClip("../../../");
   }
}

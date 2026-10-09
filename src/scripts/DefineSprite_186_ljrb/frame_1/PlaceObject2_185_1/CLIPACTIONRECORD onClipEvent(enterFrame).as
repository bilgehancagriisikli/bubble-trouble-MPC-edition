onClipEvent(enterFrame){
   sadam = getTimer();
   if(sadam - omdan >= 1500)
   {
      tajsam.level = 0;
      removeMovieClip("../");
   }
}

onClipEvent(enterFrame){
   krajpauze = getTimer();
   if(1500 < krajpauze - pocetakpauze)
   {
      _root.cvrsto2.sss.removeMovieClip();
      _root.nextFrame();
   }
}

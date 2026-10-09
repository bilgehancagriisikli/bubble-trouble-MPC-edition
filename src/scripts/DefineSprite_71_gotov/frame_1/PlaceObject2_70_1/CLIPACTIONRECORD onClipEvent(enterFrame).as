onClipEvent(enterFrame){
   krajpauze = getTimer();
   if(0 >= _root.timeleft._xscale and 1500 < krajpauze - pocetakpauze)
   {
      _root.somazgoon = 1;
      _root.razina = _root.razina + 1;
      _root.gotoAndStop("razina" + _root.razina);
      removeMovieClip("../");
   }
}

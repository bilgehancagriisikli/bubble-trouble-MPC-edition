onClipEvent(enterFrame){
   krajpauze = getTimer();
   if(2000 < krajpauze - pocetakpauze)
   {
      if(_root.brigraca == 1 and _root.lives1 < 1)
      {
         _root.attachMovie("gameover","gameover",99999);
         _root.smrtdolazi.removeMovieClip();
         _root.ubojica.removeMovieClip();
      }
      else if(_root.brigraca == 3 and _root.lives2 < 1)
      {
         _root.attachMovie("gameover","gameover",99999);
         _root.smrtdolazi.removeMovieClip();
         _root.ubojica.removeMovieClip();
      }
      else if(_root.brigraca == 2)
      {
         if(_root.lives2 < 1 and _root.lives1 < 1)
         {
            _root.attachMovie("gameover","gameover",99999);
            _root.smrtdolazi.removeMovieClip();
            _root.ubojica.removeMovieClip();
         }
         if(_root.lives1 < 1)
         {
            _root.brigraca = 3;
         }
         if(_root.lives2 < 1)
         {
            _root.brigraca = 1;
         }
      }
      _root.maknisveloptice();
      _root.prevFrame();
      removeMovieClip("../");
   }
}

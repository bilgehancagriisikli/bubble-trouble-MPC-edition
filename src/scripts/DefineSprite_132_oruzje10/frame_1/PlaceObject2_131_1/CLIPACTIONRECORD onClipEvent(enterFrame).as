onClipEvent(enterFrame){
   if(!_root.somazgoon)
   {
      _root.mis["oruzje" + mojID].removeMovieClip();
   }
   thetimeisnow = getTimer();
   if(this.hitTest(_root.player1))
   {
      _root.lives1 = _root.lives1 + 1;
      _root["pl1ziv" + _root.lives1].gotoAndStop("ima");
      _root.mis["oruzje" + mojID].removeMovieClip();
   }
   if(this.hitTest(_root.player2))
   {
      _root.lives2 = _root.lives2 + 1;
      _root["pl2ziv" + _root.lives2].gotoAndStop("ima");
      _root.mis["oruzje" + mojID].removeMovieClip();
   }
   if(4000 < thetimeisnow - birth and napravljeno != "jes")
   {
      _alpha = 50;
      attachMovie("itemcant","nestani",2);
      napravljeno = "jes";
   }
   if(_root.mis["oruzje" + mojID]._y < _root.pod)
   {
      _root.mis["oruzje" + mojID]._y += _root.rate * 100;
   }
}

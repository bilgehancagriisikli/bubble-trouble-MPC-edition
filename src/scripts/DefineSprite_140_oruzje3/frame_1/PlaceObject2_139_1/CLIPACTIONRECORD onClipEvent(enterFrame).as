onClipEvent(enterFrame){
   if(!_root.somazgoon)
   {
      _root.mis["oruzje" + mojID].removeMovieClip();
   }
   thetimeisnow = getTimer();
   if(this.hitTest(_root.player1))
   {
      _root.bodovi1 += 600;
      _root.mis["oruzje" + mojID].removeMovieClip();
   }
   if(this.hitTest(_root.player2))
   {
      _root.bodovi2 += 600;
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

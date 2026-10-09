onClipEvent(enterFrame){
   if(!_root.somazgoon)
   {
      _root.mis["oruzje" + mojID].removeMovieClip();
   }
   thetimeisnow = getTimer();
   if(this.hitTest(_root.player1))
   {
      if(_root.stavistit1 != "da")
      {
         ozvuci("stit_pali");
         removeMovieClip(_root.maknistit1);
         removeMovieClip(_root.player1.stit);
         _root.player1.attachMovie("stit","stit",2);
         _root.stit1 = "da";
         _root.stavistit1 = "da";
      }
      _root.mis["oruzje" + mojID].removeMovieClip();
   }
   if(this.hitTest(_root.player2))
   {
      if(_root.stavistit2 != "da")
      {
         removeMovieClip(_root.maknistit2);
         removeMovieClip(_root.player2.stit);
         _root.player2.attachMovie("stit","stit",2);
         ozvuci("stit_pali");
         _root.stit2 = "da";
         _root.stavistit2 = "da";
      }
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

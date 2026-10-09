onClipEvent(enterFrame){
   if(_root.somazgoon)
   {
      if(_root.proslovrijeme - vrijememolim >= 2000)
      {
         _root.stit1 = "ne";
         removeMovieClip(_root.player1.stit);
         removeMovieClip("../");
      }
      _root.player1.stit.alfa._alpha -= _root.rate * 0.1;
      _root.player1.stit.resetka.play();
   }
}

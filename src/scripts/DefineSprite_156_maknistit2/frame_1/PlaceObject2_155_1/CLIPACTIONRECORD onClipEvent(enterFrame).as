onClipEvent(enterFrame){
   if(_root.somazgoon)
   {
      if(_root.proslovrijeme - vrijememolim >= 2000)
      {
         _root.stit2 = "ne";
         removeMovieClip(_root.player2.stit);
         removeMovieClip("../");
      }
      _root.player2.stit.alfa._alpha -= _root.rate * 0.1;
      _root.player2.stit.resetka.play();
   }
}

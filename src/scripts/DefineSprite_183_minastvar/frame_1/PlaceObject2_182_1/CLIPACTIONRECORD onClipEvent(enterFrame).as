onClipEvent(enterFrame){
   najnaj = getTimer();
   if(pasivnovrijeme < najnaj - dajmimoje)
   {
      if(this == _root.cvrsto2.mina1.majn and _root.mina1spremna != "da" and _root.player1.hitTest(this) and _root.somazgoon)
      {
         _root.mina1spremna = "da";
         _root.cvrsto.shot1.removeMovieClip();
         removeMovieClip("../");
      }
      if(this == _root.cvrsto2.mina2.majn and _root.mina2spremna != "da" and _root.player2.hitTest(this) and _root.somazgoon)
      {
         _root.mina2spremna = "da";
         _root.cvrsto.shot2.removeMovieClip();
         removeMovieClip("../");
      }
   }
}

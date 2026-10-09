on(release){
   if(_root.meniji2 == "ok")
   {
      if(_root.setcontrols.plast._currentframe == 1 and _root.player1move != "mis")
      {
         _root.promjenitipku = "pucaj";
         _root.setcontrols.tipka.gotoAndStop("menjaj");
      }
      else if(_root.setcontrols.plast._currentframe == 2 and _root.player2move != "mis")
      {
         _root.promjenitipku = "pucaj";
         _root.setcontrols.tipka.gotoAndStop("menjaj");
      }
   }
}

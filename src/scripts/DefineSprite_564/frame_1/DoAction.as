movieclip.prototype.tipke = function()
{
   _root.setcontrols.miso.gotoAndStop(1);
   _root.setcontrols.tasta.gotoAndStop(1);
   if(_root.setcontrols.plast._currentframe == 1)
   {
      if(_root.player2move == "mis")
      {
         _root.setcontrols.theone.gotoAndStop("theone");
      }
      else
      {
         _root.setcontrols.theone.gotoAndStop("nula");
      }
      if(_root.player1move == "mis")
      {
         _root.setcontrols.ljevo.gotoAndStop("misljevo");
         _root.setcontrols.desno.gotoAndStop("misdesno");
         _root.setcontrols.pucaj.gotoAndStop("mispucaj");
         _root.setcontrols.miso.gotoAndStop(2);
      }
      if(_root.player1move == "tastatura")
      {
         _root.setcontrols.ljevo.gotoAndStop("" + _root.keyleft1 + "");
         _root.setcontrols.desno.gotoAndStop("" + _root.keyright1 + "");
         _root.setcontrols.pucaj.gotoAndStop("" + _root.keyfire1 + "");
         _root.setcontrols.tasta.gotoAndStop(2);
      }
      if(_root.promjenitipku == "mis")
      {
         if(_root.player2move != "mis")
         {
            _root.player1move = "mis";
         }
         else
         {
            _root.setcontrols.theone.gotoAndPlay("theone");
         }
         _root.promjenitipku = "null";
      }
      else if(_root.promjenitipku == "tastatura")
      {
         _root.player1move = "tastatura";
         _root.promjenitipku = "null";
      }
   }
   if(_root.setcontrols.plast._currentframe == 2)
   {
      if(_root.player1move == "mis")
      {
         _root.setcontrols.theone.gotoAndStop("theone");
      }
      else
      {
         _root.setcontrols.theone.gotoAndStop("nula");
      }
      if(_root.player2move == "mis")
      {
         _root.setcontrols.ljevo.gotoAndStop("misljevo");
         _root.setcontrols.desno.gotoAndStop("misdesno");
         _root.setcontrols.pucaj.gotoAndStop("mispucaj");
         _root.setcontrols.miso.gotoAndStop(2);
      }
      if(_root.player2move == "tastatura")
      {
         _root.setcontrols.ljevo.gotoAndStop("" + _root.keyleft2 + "");
         _root.setcontrols.desno.gotoAndStop("" + _root.keyright2 + "");
         _root.setcontrols.pucaj.gotoAndStop("" + _root.keyfire2 + "");
         _root.setcontrols.tasta.gotoAndStop(2);
      }
      if(_root.promjenitipku == "mis")
      {
         if(_root.player1move != "mis")
         {
            _root.player2move = "mis";
         }
         else
         {
            _root.setcontrols.theone.gotoAndPlay("theone");
         }
         _root.promjenitipku = "null";
      }
      else if(_root.promjenitipku == "tastatura")
      {
         _root.player2move = "tastatura";
         _root.promjenitipku = "null";
      }
   }
};
movieclip.prototype.mjenjanjetipke = function(ebasovu)
{
   if(_root.setcontrols.plast._currentframe == 1)
   {
      if(_root.promjenitipku == "ljevo")
      {
         _root.keyleft1 = ebasovu;
      }
      else if(_root.promjenitipku == "desno")
      {
         _root.keyright1 = ebasovu;
      }
      else if(_root.promjenitipku == "pucaj")
      {
         _root.keyfire1 = ebasovu;
      }
   }
   else if(_root.setcontrols.plast._currentframe == 2)
   {
      if(_root.promjenitipku == "ljevo")
      {
         _root.keyleft2 = ebasovu;
      }
      else if(_root.promjenitipku == "desno")
      {
         _root.keyright2 = ebasovu;
      }
      else if(_root.promjenitipku == "pucaj")
      {
         _root.keyfire2 = ebasovu;
      }
   }
   _root.meniji2 = "ok";
};

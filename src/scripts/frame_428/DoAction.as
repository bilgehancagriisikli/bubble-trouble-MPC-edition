Mouse.show();
stopDrag();
stop();
movieclip.prototype.provjera = function(igrac)
{
   mjesto = 101;
   itischecked = "nope";
   _root.igralec = igrac;
   then = getTimer();
   if(3000 < then - _root.nau)
   {
      if(_root.scoretable.varzaprovjeru == "provjereno")
      {
         _root.status2 = "Connected";
         itischecked = "yup";
         _root.bods = new Array(_root.scoretable.score0,_root.scoretable.score1,_root.scoretable.score2,_root.scoretable.score3,_root.scoretable.score4,_root.scoretable.score5,_root.scoretable.score6,_root.scoretable.score7,_root.scoretable.score8,_root.scoretable.score9,_root.scoretable.score10,_root.scoretable.score11,_root.scoretable.score12,_root.scoretable.score13,_root.scoretable.score14,1);
         mjesto = 1;
         while(16 >= mjesto)
         {
            if(_root["bodovi" + igrac] >= _root.bods[mjesto - 1])
            {
               break;
            }
            mjesto++;
         }
         if(_root["bodovi" + igrac] == 0)
         {
            mjesto = 102;
         }
      }
      else
      {
         _root.nau = getTimer();
      }
   }
   if(itischecked == "yup")
   {
      if(mjesto < 16)
      {
         _root.scoretable.winscore = _root["bodovi" + _root.igralec];
         _root.statuz = "Congratulations player " + igrac + ", you ranked";
         _root.rank = mjesto + ".";
         _root.upisiime.nextFrame();
      }
      else if(igrac == "1")
      {
         _root.provjera1 = "ok";
      }
      else if(igrac == "2")
      {
         _root.provjera2 = "ok";
      }
   }
};

movieclip.prototype.initplyr = function(plyr)
{
   _root.gedredi._visible = false;
   vrstapucanja = _root.pucanjvrsta[0];
};
movieclip.prototype.move = function(player)
{
   mojtrenutak = getTimer();
   if(_root.somazgoon)
   {
      if(_root["player" + player + "move"] == "tastatura")
      {
         if(Key.isDown(_root["keyleft" + player]) and _root.ljevix < _X and 100 < mojtrenutak - _root.cvrsto["shot" + player].trenutakpucnja)
         {
            motion = "ljevim";
            _X = _X - _root.rate * _root.brzinaigraca;
         }
         if(Key.isDown(_root["keyright" + player]) and _X < _root.desnix and 100 < mojtrenutak - _root.cvrsto["shot" + player].trenutakpucnja)
         {
            motion = "desnim";
            _X = _X + _root.rate * _root.brzinaigraca;
         }
         if(Key.isDown(_root["keyfire" + player]))
         {
            initshot(player);
         }
         if(!Key.isDown(_root["keyleft" + player]) and !Key.isDown(_root["keyright" + player]) or Key.isDown(_root["keyleft" + player]) and Key.isDown(_root["keyright" + player]))
         {
            motion = "stojim";
         }
         if(motion == "ljevim")
         {
            if(motionW != "ljevim")
            {
               _root["player" + player].attachMovie("ljevim","motion",1);
               motionW = "ljevim";
            }
         }
         if(motion == "desnim")
         {
            if(motionW != "desnim")
            {
               _root["player" + player].attachMovie("desnim","motion",1);
               motionW = "desnim";
            }
         }
         if(motion == "stojim")
         {
            if(motionW != "stojim")
            {
               _root["player" + player].attachMovie("stojim","motion",1);
               motionW = "stojim";
            }
         }
      }
      if(_root["player" + player + "move"] == "mis")
      {
         if(_X >= _root._xmouse or _root._xmouse >= _X)
         {
            motion = "stojim";
         }
         if(_root._xmouse + 2 < _X and _root.ljevix < _X and 100 < mojtrenutak - _root.cvrsto["shot" + player].trenutakpucnja)
         {
            motion = "ljevim";
            _X = _X - _root.rate * _root.brzinaigraca;
         }
         if(_X < _root._xmouse - 2 and _X < _root.desnix and 100 < mojtrenutak - _root.cvrsto["shot" + player].trenutakpucnja)
         {
            motion = "desnim";
            _X = _X + _root.rate * _root.brzinaigraca;
         }
         if(_root.mouseisdown)
         {
            initshot(player);
         }
         if(Key.isDown(Key.SHIFT))
         {
            vrstapucanja = _root.pucanjvrsta[3];
         }
         if(motion == "ljevim")
         {
            if(motionW != "ljevim")
            {
               _root["player" + player].attachMovie("ljevim","motion",1);
               motionW = "ljevim";
            }
         }
         if(motion == "desnim")
         {
            if(motionW != "desnim")
            {
               _root["player" + player].attachMovie("desnim","motion",1);
               motionW = "desnim";
            }
         }
         if(motion == "stojim")
         {
            if(motionW != "stojim")
            {
               _root["player" + player].attachMovie("stojim","motion",1);
               motionW = "stojim";
            }
         }
      }
   }
};
movieclip.prototype.initshot = function(koji)
{
   if(!_root.cvrsto["shot" + koji])
   {
      if(vrstapucanja == _root.pucanjvrsta[0] or vrstapucanja == _root.pucanjvrsta[1] or vrstapucanja == _root.pucanjvrsta[3])
      {
         if(_root.cvrsto2["mina" + koji] and 65 >= _root.cvrsto2["mina" + koji].majn._currentframe)
         {
            _root.mina1spremna = "naj";
            _root.cvrsto2["mina" + koji].majn.gotoAndPlay("nestani");
         }
         motion = "stojim";
         _root.cvrsto.attachMovie(vrstapucanja,"shot" + koji,koji);
         _root.cvrsto["shot" + koji]._x = _X;
         _root.cvrsto["shot" + koji]._y = _Y;
      }
      if(vrstapucanja == _root.pucanjvrsta[2] and !_root.cvrsto2["mina" + koji])
      {
         if(_root["mina" + koji + "spreman"] == "da")
         {
            motion = "stojim";
            _root.cvrsto2.attachMovie("minastvar","mina" + koji,koji + 2);
            _root["mina" + koji + "spremna"] = "visene";
            _root.cvrsto2["mina" + koji]._x = _X;
            _root.cvrsto2["mina" + koji]._y = _Y;
         }
      }
      if(_root.cvrsto2["mina" + koji].majn._currentframe == 65)
      {
         _root.cvrsto.attachMovie(vrstapucanja,"shot" + koji,koji);
         _root.cvrsto["shot" + koji]._x = _root.cvrsto2["mina" + koji]._x;
         _root.cvrsto["shot" + koji]._y = _root.cvrsto2["mina" + koji]._y;
      }
   }
};

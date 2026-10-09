movieclip.prototype.initplyr = function(plyr)
{
   _root.gedredi._visible = false;
   vrstapucanja = _root.pucanjvrsta[0];
   // MOD: tuşla seçilen özel atış bölümler/ölümler arasında kalır
   if(_root.secilisilah != undefined)
   {
      vrstapucanja = _root.pucanjvrsta[_root.secilisilah];
      if(_root.secilisilah == 2)
      {
         _root["mina" + plyr + "spreman"] = "da";
      }
   }
};
movieclip.prototype.move = function(player)
{
   // MOD: sınırsız atış - atış sonrası 100 ms donma kaldırıldı (basılı ateşte oyuncu sürünüyordu)
   mojtrenutak = getTimer();
   if(_root.somazgoon)
   {
      if(_root["player" + player + "move"] == "tastatura")
      {
         if(Key.isDown(_root["keyleft" + player]) and _root.ljevix < _X)
         {
            motion = "ljevim";
            _X = _X - _root.rate * _root.brzinaigraca;
         }
         if(Key.isDown(_root["keyright" + player]) and _X < _root.desnix)
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
         if(_root._xmouse + 2 < _X and _root.ljevix < _X)
         {
            motion = "ljevim";
            _X = _X - _root.rate * _root.brzinaigraca;
         }
         if(_X < _root._xmouse - 2 and _X < _root.desnix)
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
   // MOD: sınırsız atış - ekranda aynı anda istediğin kadar atış olabilir,
   // ateş tuşu basılı tutulunca _root.atisaralik ms'de bir atış yapılır
   // (eskiden: oyuncunun ekranda tek atışı olabilirdi, "shot1"/"shot2")
   if(getTimer() - _root["sonatis" + koji] < _root.atisaralik)
   {
      return undefined;
   }
   if(vrstapucanja == _root.pucanjvrsta[0] or vrstapucanja == _root.pucanjvrsta[1] or vrstapucanja == _root.pucanjvrsta[3] or vrstapucanja == _root.pucanjvrsta[4])
   {
      if(_root.cvrsto2["mina" + koji] and 65 >= _root.cvrsto2["mina" + koji].majn._currentframe)
      {
         _root.mina1spremna = "naj";
         _root.cvrsto2["mina" + koji].majn.gotoAndPlay("nestani");
      }
      motion = "stojim";
      if(vrstapucanja == _root.pucanjvrsta[4])
      {
         // MOD: çift atış - iki normal zıpkın, oyuncunun iki yanından
         yeniatis(koji,_root.pucanjvrsta[0],_X - 12,_Y);
         yeniatis(koji,_root.pucanjvrsta[0],_X + 12,_Y);
      }
      else
      {
         yeniatis(koji,vrstapucanja,_X,_Y);
      }
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
         _root["sonatis" + koji] = getTimer();
      }
   }
   if(_root.cvrsto2["mina" + koji].majn._currentframe == 65)
   {
      yeniatis(koji,vrstapucanja,_root.cvrsto2["mina" + koji]._x,_root.cvrsto2["mina" + koji]._y);
   }
};
movieclip.prototype.yeniatis = function(koji, vrsta, x, y)
{
   _root.atissayac = (_root.atissayac + 1) % 5000;
   var ad = "shot" + koji + "_" + _root.atissayac;
   _root.cvrsto.attachMovie(vrsta,ad,10 + _root.atissayac);
   _root.cvrsto[ad]._x = x;
   _root.cvrsto[ad]._y = y;
   _root.cvrsto[ad].sahip = koji;
   _root["sonatis" + koji] = getTimer();
};

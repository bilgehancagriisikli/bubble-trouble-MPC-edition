movieclip.prototype.smrtodstropa = function(acija)
{
   _root["lives" + acija]--;
   maknisveloptice();
   _root.brojloptica[0] = 1;
   _root.somazgoon = 0;
   _root.attachMovie("nista","ubojica",0);
   _root.ubojica.attachMovie("countdown","cant",0);
};
movieclip.prototype.spustistrop = function(strop, ubrzanje)
{
   if(_root.somazgoon and _root["strop" + strop]._y < _root.pod + 250)
   {
      if(_root["strop" + strop]._y >= _root.pod - 120)
      {
         ubrzanje = 35;
      }
      if(_root.player1.hitTest(this) == true)
      {
         smrtodstropa(1);
      }
      if(_root.player1.hitTest(this) == true)
      {
         smrtodstropa(2);
      }
      if(_root.brigraca == 1 or _root.brigraca == 3)
      {
         padstropa = _root.rate * 5 * ubrzanje;
      }
      else if(_root.brigraca == 2)
      {
         padstropa = _root.rate * 7.5 * ubrzanje;
      }
      _root["strop" + strop]._y += padstropa;
   }
};
movieclip.prototype.otislovrijeme = function()
{
   _root.somazgoon = 0;
   _root.lives1--;
   _root.lives2--;
   _root.cvrsto2.attachMovie("countdowntime","canttime",15);
};
movieclip.prototype.inicijaliziraj_stazu = function()
{
   _root.pocetakstaze = getTimer();
};
movieclip.prototype.staza_tece = function()
{
   if(_root.mis.kontura and _root._ymouse >= 380)
   {
      Mouse.show();
   }
   else if(_root.mis.kontura and _root._ymouse < 380 and _root.quit.gointo._currentframe == 2)
   {
      Mouse.hide();
   }
   if(_root.somazgoon)
   {
      _root.proslovrijeme = getTimer();
      if(_root.proslovrijeme - _root.pocetakstaze >= _root.vrijemestaze)
      {
         otislovrijeme();
      }
      if(_xscale >= 687)
      {
         _root.pocetakstaze = getTimer();
      }
      jedinica = _root.proslovrijeme - _root.pocetakstaze;
      _xscale = (_root.vrijemestaze - jedinica) / _root.vrijemestaze * 686.8;
   }
   if(0 >= _xscale)
   {
      _visible = false;
   }
};
movieclip.prototype.upalizivote = function()
{
   i = 1;
   while(2 >= i)
   {
      if(i == 1 and (_root.brigraca == 1 or _root.brigraca == 2) or i == 2 and (_root.brigraca == 2 or _root.brigraca == 3))
      {
         upali = 1;
         while(_root["lives" + i] >= upali)
         {
            _root["pl" + i + "ziv" + upali].gotoAndStop("ima");
            upali++;
         }
         if(9 >= upali)
         {
            _root["pl" + i + "ziv" + upali].gotoAndStop("nema");
         }
      }
      i++;
   }
};
movieclip.prototype.normalnastaza = function()
{
   otvori_vrata();
   if(_root.levela == 1)
   {
      if(!_root.brojloptica[0])
      {
         iducastaza();
      }
   }
   else if(_root.levela == 2)
   {
      if(!_root.brojloptica[0] and !_root.brojloptica[1])
      {
         iducastaza();
      }
   }
   else if(_root.levela == 3)
   {
      if(!_root.brojloptica[0] and !_root.brojloptica[1] and !_root.brojloptica[2])
      {
         iducastaza();
      }
   }
   else if(_root.levela == 4)
   {
      if(!_root.brojloptica[0] and !_root.brojloptica[1] and !_root.brojloptica[2] and !_root.brojloptica[3])
      {
         iducastaza();
      }
   }
   else if(_root.levela == 5)
   {
      if(!_root.brojloptica[0] and !_root.brojloptica[1] and !_root.brojloptica[2] and !_root.brojloptica[3] and !_root.brojloptica[4])
      {
         iducastaza();
      }
   }
   else if(_root.levela == 6)
   {
      if(!_root.brojloptica[0] and !_root.brojloptica[1] and !_root.brojloptica[2] and !_root.brojloptica[3] and !_root.brojloptica[4] and !_root.brojloptica[5])
      {
         iducastaza();
      }
   }
};
movieclip.prototype.iducastaza = function()
{
   if(_root.somazgoon)
   {
      _root.somazgoon = 0;
      _root.attachMovie("gotov","gotova_staza",99);
   }
};
movieclip.prototype.otvori_vrata = function()
{
   if(!_root.brojloptica[0] and _root.vrat == 0)
   {
      dajmiprostor(1);
   }
   else if(!_root.brojloptica[1] and _root.vrat == 1)
   {
      dajmiprostor(2);
   }
   else if(!_root.brojloptica[2] and _root.vrat == 2)
   {
      dajmiprostor(3);
   }
   else if(!_root.brojloptica[3] and _root.vrat == 3)
   {
      dajmiprostor(4);
   }
   else if(!_root.brojloptica[4] and _root.vrat == 4)
   {
      dajmiprostor(5);
   }
};
movieclip.prototype.dajmiprostor = function(vrata)
{
   _root.vrat = _root.vrat + 1;
   _root["vrata" + vrata].play();
   if(Number(_root.ljevirub[vrata]) < Number(_root.ljevirub[vrata - 1]))
   {
      _root.ljevix = Number(_root.ljevirub[vrata]) + _root.sirinaigraca / 2;
   }
   if(Number(_root.desnirub[vrata - 1]) < Number(_root.desnirub[vrata]))
   {
      _root.desnix = Number(_root.desnirub[vrata]) - _root.sirinaigraca / 2;
   }
};
movieclip.prototype.barijeranje = function()
{
   if(!_root.brojloptica[0] and _root.bar == 0)
   {
      srusi_barijeru(1);
   }
   if(!_root.brojloptica[1] and _root.bar == 1)
   {
      srusi_barijeru(2);
   }
   if(!_root.brojloptica[2] and _root.bar == 2)
   {
      srusi_barijeru(3);
   }
   if(!_root.brojloptica[3] and _root.bar == 3)
   {
      srusi_barijeru(4);
   }
   if(!_root.brojloptica[4] and _root.bar == 4)
   {
      srusi_barijeru(5);
   }
};
movieclip.prototype.srusi_barijeru = function(barijera)
{
   _root.bar = _root.bar + 1;
   _root["barijera" + barijera].play();
   if(Number(_root.ljevirub[barijera - 1]) < Number(_root.ljevirub[barijera]))
   {
      _root.ljevirub[barijera] = _root.ljevirub[barijera - 1];
   }
   if(Number(_root.desnirub[barijera]) < Number(_root.desnirub[barijera - 1]))
   {
      _root.desnirub[barijera] = _root.desnirub[barijera - 1];
   }
};
movieclip.prototype.pocistisve = function()
{
   _root.cvrsto.shot1.removeMovieClip();
   _root.cvrsto.shot2.removeMovieClip();
   _root.somazgoon = 1;
   _root.ubojica.removeMovieClip();
   _root.smrtdolazi.removeMovieClip();
   _root.cvrsto2.mina1.removeMovieClip();
   _root.cvrsto2.mina2.removeMovieClip();
   i = 0;
   while(10 >= i)
   {
      _root.brojloptica[i] = 0;
      i++;
   }
   _root.attached = 1;
};
movieclip.prototype.mojevrijemeje = function(time1, time2)
{
   if(_root.brigraca == 1 or _root.brigraca == 3)
   {
      _root.vrijemestaze = time1 * 1000;
   }
   else if(_root.brigraca == 2)
   {
      _root.vrijemestaze = time2 * 1000;
   }
};
movieclip.prototype.defaultstaza = function()
{
   _root.gedredi._visible = true;
   if(_root.player1move == "mis" and _root.lives1 < 1)
   {
      removeMovieClip(_root.mis.kontura);
      Mouse.show();
   }
   else if(_root.player2move == "mis" and _root.lives2 < 1)
   {
      removeMovieClip(_root.mis.kontura);
      Mouse.show();
   }
   i = 1;
   while(5 >= i)
   {
      _root["vrata" + i].gotoAndStop("dolje");
      _root["barijera" + i].gotoAndStop("zatvori");
      i++;
   }
   _root.stit1 = "nema";
   _root.stit2 = "nema";
   _root.stavistit1 = "nema";
   _root.stavistit2 = "nema";
   removeMovieClip(_root.stit1);
   removeMovieClip(_root.stit2);
   removeMovieClip(_root.maknistit1);
   removeMovieClip(_root.maknistit2);
   _root.cvrsto2.mina1.removeMovieClip();
   _root.cvrsto2.mina2.removeMovieClip();
   _root.mina1spremna = "not";
   _root.mina2spremna = "not";
   if(_root.lives1 < 1)
   {
      _root.player1._visible = false;
   }
   if(_root.lives2 < 1 or _root.brigraca == 1)
   {
      _root.player2._visible = false;
   }
   _root.pod = 369;
   _root.ljevirub = new Array("7.3");
   _root.desnirub = new Array("694.1");
   _root.ljevix = Number(_root.ljevirub[0]) + _root.sirinaigraca / 2;
   _root.desnix = Number(_root.desnirub[0]) - _root.sirinaigraca / 2;
   _root.scales = new Array("100","80","60","40","20","10","10");
   _root.maxvisine = new Array("65","110","150","190","230","300","10");
   _root.maxbrziney = new Array();
   i = 0;
   while(6 >= i)
   {
      _root.maxbrziney[i] = Math.sqrt(2 * _root.gravitacija * (_root.pod - _root.maxvisine[i] - _root.scales[i] / 2),2);
      i++;
   }
   _root.levela = 1;
   _root.itemz = new Array("x","x","x","x","x","x","x","x","x","x","x");
};

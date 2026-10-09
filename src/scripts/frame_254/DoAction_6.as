movieclip.prototype.maknisveloptice = function()
{
   1;
   while(_root.attached >= 0)
   {
      _root["a" + _root.attached].removeMovieClip();
      _root.attached--;
   }
};
movieclip.prototype.smrt = function(moja)
{
   stopAllSounds();
   ozvuci("death");
   _root.somazgoon = 0;
   // MOD: sonsuz can - _root["lives" + moja]--;
   if(_root["lives" + moja] < 1)
   {
      _root.dorazina[moja] = _root.razina;
   }
   _root.attachMovie("nista","ubojica",0);
   _root.ubojica.attachMovie("countdown","cant",990);
   _root.attachMovie("smrtdolazi","smrtdolazi",9999);
   _root.smrtdolazi._x = _root["player" + moja]._x;
   _root.smrtdolazi._y = _root["player" + moja]._y;
};
movieclip.prototype.raspolovi = function(cestmoi, opt)
{
   _root.poptime = getTimer();
   if(500 < _root.tajmaut)
   {
      level = 0;
   }
   tkosam++;
   _root.cvrsto["shot" + cestmoi].pop.stop();
   _root.cvrsto["shot" + cestmoi].gotoAndPlay("kreni");
   if(88 < _xscale and opt != "roof")
   {
      _xscale = 80;
      _yscale = 80;
      oruzje();
   }
   else if(68 < _xscale and opt != "roof")
   {
      _xscale = 60;
      _yscale = 60;
      oruzje();
   }
   else if(48 < _xscale and opt != "roof")
   {
      _xscale = 40;
      _yscale = 40;
      oruzje();
   }
   else if(28 < _xscale and opt != "roof")
   {
      _xscale = 20;
      _yscale = 20;
      oruzje();
   }
   else
   {
      if(!(18 < _xscale and opt != "roof"))
      {
         _root.brojloptica[level]--;
         _root.attachMovie("ballpop","balls",_root.attached);
         _root.attached = _root.attached + 1;
         _root.balls._x = _X;
         _root.balls._y = _Y;
         if(opt == "roof")
         {
            _root.attachMovie("bonus","bonus",50);
            _root.bonus._x = _X;
            _root.bonus._y = _Y;
            if(25 < _root.poptime - _root.nowpoptime)
            {
               ozvuci("pop_roof");
               _root.nowpoptime = getTimer();
            }
         }
         else
         {
            ozvuci("pop1");
         }
         removeMovieClip("../");
         return 0;
      }
      _xscale = 10;
      _yscale = 10;
      oruzje();
   }
   if(opt != "roof")
   {
      ozvuci("pop2");
   }
   niy = - (1 - _xscale / 180);
   _root.attachMovie("radilica","a" + _root.attached,_root.attached + 500);
   _root["a" + _root.attached].akcije._x = _X + _xscale / 5;
   _root["a" + _root.attached].akcije._y = _Y;
   _root["a" + _root.attached].akcije.initball(-1,niy,tkosam,level,mojaboja);
   _root.attached = _root.attached + 1;
   _root.attachMovie("rascvjet" + mojaboja,"rascvjet" + _root.attached,_root.attached + 505);
   _root["rascvjet" + _root.attached]._x = _X;
   _root["rascvjet" + _root.attached]._y = _Y;
   _root["rascvjet" + _root.attached]._xscale = 100 / tkosam;
   _root["rascvjet" + _root.attached]._yscale = 100 / tkosam;
   _root["rascvjet" + _root.attached]._rotation = random(360);
   _root.attachMovie("radilica","a" + _root.attached,_root.attached + 500);
   _root["a" + _root.attached].akcije._x = _X - _xscale / 5;
   _root["a" + _root.attached].akcije._y = _Y;
   _root["a" + _root.attached].akcije.initball(1,niy,tkosam,level,mojaboja);
   _root.attached = _root.attached + 1;
   _root.brojloptica[level]--;
   removeMovieClip("../");
   return 0;
};
movieclip.prototype.initball = function(xing, ying, index, gdje, boja)
{
   _root.brojloptica[gdje]++;
   attachMovie("kegl" + boja,"ball1",0);
   tkosam = index;
   level = gdje;
   mojaboja = boja;
   _xscale = _root.scales[index];
   _yscale = _xscale;
   maxbrzinay = _root.maxbrziney[index];
   maxvis = _root.maxvisine[index];
   brzinax = xing;
   starty = _Y - ying;
   mojy = Math.abs(maxvis - starty);
   brzinay = ying * Math.sqrt(2 * _root.gravitacija * mojy,2);
   if(500 < _root.tajmaut)
   {
      attachMovie("ljrb","kaj",22);
   }
};
movieclip.prototype.bauns = function()
{
   // MOD: toplar oyuncuya zarar vermez, içinden geçip yoluna devam eder
   // (eskiden: oyuncuya değince smrt(1) / smrt(2), kalkan varsa kalkan gider)
   if(_root.cvrsto.shot1)
   {
      if(this.hitTest(_root.cvrsto.shot1))
      {
         _root.bodovi1 += Math.round(1000 / _xscale);
         raspolovi(1);
      }
   }
   if(_root.cvrsto.shot2)
   {
      if(this.hitTest(_root.cvrsto.shot2))
      {
         _root.bodovi2 += Math.round(1000 / _xscale);
         raspolovi(2);
      }
   }
   if(this.hitTest(_root.strop1))
   {
      if(_root.brigraca == 1 or _root.brigraca == 2)
      {
         _root.bodovi1 += Math.round(1000 / _xscale);
      }
      if(_root.brigraca == 2 or _root.brigraca == 3)
      {
         _root.bodovi2 += Math.round(1000 / _xscale);
      }
      raspolovi(0,"roof");
   }
   else
   {
      novix = _root.rate * brzinax * 70;
      if(_root.desnirub[level] - _xscale / 2 < _X - novix)
      {
         brzinax *= -1;
         novix -= _X + novix + _xscale / 2 - _root.desnirub[level];
      }
      if(_X - novix - _xscale / 2 < _root.ljevirub[level])
      {
         brzinax *= -1;
         novix += novix - _X + _xscale / 2 + _root.ljevirub[level];
      }
      _X = _X - novix;
      brzinay += _root.gravitacija * _root.rate * 85;
      noviy += brzinay * _root.rate * 85;
      if(_root.pod < _Y + _xscale / 2)
      {
         noviy = _root.pod - starty - _xscale / 2;
         brzinay = maxbrzinay;
         brzinay *= -1;
      }
      _Y = noviy + starty;
   }
};

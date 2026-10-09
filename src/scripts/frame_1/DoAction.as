_root.tajmaut = 0;
_root.kaos = 0;
_root.player1move = "tastatura";
_root.player2move = "tastatura";
_root.keyleft1 = 37;
_root.keyright1 = 39;
_root.keyfire1 = 32;
_root.keyleft2 = 88;
_root.keyright2 = 67;
_root.keyfire2 = 87;
_root.volumenje = 100;
_root.zvuk = "jest";
movieclip.prototype.kill = function()
{
   for(a in "this")
   {
      this[a].removeMovieClip();
      if(a != "volumenje" and a != "player1move" and a != "player2move" and a != "keyleft1" and a != "keyleft2" and a != "keyright1" and a != "keyright2" and a != "keyfire1" and a != "keyfire2" and a != "zvuk")
      {
         delete this[a];
      }
   }
   if(a != "volumenje")
   {
      delete a;
   }
};
movieclip.prototype.primitivnibauns = function()
{
   brzinay += 0.0425;
   noviy += brzinay * 0.01 * 85;
   if(400 < _Y + _xscale / 2)
   {
      noviy = 400 - _xscale / 2;
      brzinay = 5;
      brzinay *= -1;
   }
   _Y = noviy;
};
movieclip.prototype.ozvuci = function(zound)
{
   if(_root.zvuk == "jest" and _root.volumenje >= 10)
   {
      pop = new Sound(this);
      pop.setVolume(_root.volumenje);
      pop.attachSound(zound);
      pop.start();
   }
};
// MOD: seviye seçme ekranı
// Ekranın kendisi (butonlar, yazılar) tools/inject_ui.py ile SWF'e
// "izbornik" adlı sprite olarak eklenir; butonlar izbor(N) çağırır, geri butonu izbor(0).
movieclip.prototype.izborrazine = function()
{
   _root.attachMovie("izbornik","izbornik",60000);
};
movieclip.prototype.izbor = function(n)
{
   _root.ozvuci("option");
   if(n > 0)
   {
      _root.secilenrazina = n;
      _root.gotoAndPlay("igra");
   }
   else
   {
      _root.meniji1 = "ok";
   }
   // en sonda: buton bu klibin içinde, silindikten sonra kod çalışmaya devam etmeyebilir
   _root.izbornik.removeMovieClip();
};

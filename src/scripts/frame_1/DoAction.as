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
   if(_root.oyunda)
   {
      // bölüm sonunda açılan ekran
      _root.oyunda = 0;
      if(n > 0)
      {
         _root.somazgoon = 1;
         _root.razina = n;
         _root.gotoAndStop("razina" + n);
         if(_root.mis.kontura)
         {
            Mouse.hide();
         }
      }
      else
      {
         // GERİ: ana menüye dön (oyundaki "quit?" butonu gibi)
         stopAllSounds();
         _root.gotoAndPlay("welcome");
         _root.kill();
      }
   }
   else if(n > 0)
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
// MOD: her bölüm bitince seviye seçme ekranı açılır (DefineSprite_71_gotov)
movieclip.prototype.izborrazine_oyunda = function()
{
   _root.oyunda = 1;
   // bonus animasyonu (gotov_ani) normalde kare değişince kendini siler; burada kare değişmediği için elle sil
   _root.animani.removeMovieClip();
   Mouse.show();
   _root.attachMovie("izbornik","izbornik",60000);
};
// MOD: özel atış penceresi
// 1-4 tuşları (üst sıra veya numpad) özel atışı seçer; seçince yarı saydam bir pencere
// açılır ve birkaç saniye sonra kaybolur. Pencere: tools/inject_ui.py ("ozellikler").
_root.ozelliktuslari = new Array(49,50,51,52);
// tuş sırası -> _root.pucanjvrsta indeksi: 1 normal(0), 2 dikenli(1), 3 lazer(3), 4 mayın(2)
_root.ozelliksilah = new Array(0,1,3,2);
_root.atisaralik = 120;
movieclip.prototype.ozellik_tuslari = function()
{
   var basili = 0;
   var k = 0;
   while(k < 4)
   {
      if(Key.isDown(_root.ozelliktuslari[k]) or Key.isDown(97 + k))
      {
         basili = k + 1;
      }
      k++;
   }
   if(basili and basili != _root.ozelliktus and _root.somazgoon)
   {
      ozellik_sec(basili - 1);
   }
   _root.ozelliktus = basili;
   if(_root.ozellikpencere)
   {
      if(getTimer() - _root.ozelliksure > 2500)
      {
         _root.ozellikpencere._alpha -= 2;
         if(_root.ozellikpencere._alpha <= 0)
         {
            _root.ozellikpencere.removeMovieClip();
         }
      }
   }
};
movieclip.prototype.ozellik_sec = function(k)
{
   _root.secilisilah = _root.ozelliksilah[k];
   var p = 1;
   while(p <= 2)
   {
      _root["player" + p].vrstapucanja = _root.pucanjvrsta[_root.secilisilah];
      if(_root.secilisilah == 2)
      {
         _root["mina" + p + "spreman"] = "da";
      }
      p++;
   }
   if(!_root.ozellikpencere)
   {
      _root.attachMovie("ozellikler","ozellikpencere",61000);
      _root.ozellikpencere._x = 225;
      _root.ozellikpencere._y = 40;
   }
   _root.ozellikpencere._alpha = 90;
   // satırlar 44. pikselden başlar, 30 piksel aralıklı (tools/inject_ui.py build_window)
   _root.ozellikpencere.secim._y = 44 + k * 30;
   _root.ozelliksure = getTimer();
   _root.ozvuci("option");
};

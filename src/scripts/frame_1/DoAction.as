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
         razinaya_git(n);
         if(_root.mis.kontura)
         {
            Mouse.hide();
         }
      }
      else
      {
         // GERİ: ana menüye dön (oyundaki "quit?" butonu gibi)
         stopAllSounds();
         _root.oyunu_temizle();
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
// 1-5 tuşları (üst sıra veya numpad) özel atışı seçer; seçince yarı saydam bir pencere
// açılır ve birkaç saniye sonra kaybolur. Pencere: tools/inject_ui.py ("ozellikler").
_root.ozelliktuslari = new Array(49,50,51,52,53);
// tuş sırası -> _root.pucanjvrsta indeksi: 1 normal(0), 2 dikenli(1), 3 lazer(3), 4 mayın(2), 5 çift(4)
_root.ozelliksilah = new Array(0,1,3,2,4);
_root.atisaralik = 120;
movieclip.prototype.ozellik_tuslari = function()
{
   var basili = 0;
   var k = 0;
   while(k < _root.ozelliktuslari.length)
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
// MOD: bölüm yarıda bırakılınca (quit?, BACK) ekranda kalan her şeyi temizle.
// _root.kill() topları silmiyor; özellikle bitmeyen 17. bölümden çıkınca toplar menüde kalıyordu.
movieclip.prototype.oyunu_temizle = function()
{
   var ad;
   for(ad in _root)
   {
      if(typeof(_root[ad]) == "movieclip")
      {
         if(ad.substr(0,1) == "a" and !isNaN(ad.substr(1)) or ad.substr(0,8) == "rascvjet" or ad == "balls" or ad == "bonus")
         {
            _root[ad].removeMovieClip();
         }
      }
   }
   for(ad in _root.cvrsto)
   {
      if(_root.cvrsto[ad].sahip)
      {
         _root.cvrsto[ad].removeMovieClip();
      }
   }
   for(ad in _root.mis)
   {
      if(ad.substr(0,6) == "oruzje")
      {
         _root.mis[ad].removeMovieClip();
      }
   }
   _root.cvrsto2.mina1.removeMovieClip();
   _root.cvrsto2.mina2.removeMovieClip();
   _root.ozellikpencere.removeMovieClip();
   _root.gotova_staza.removeMovieClip();
   _root.animani.removeMovieClip();
   _root.ubojica.removeMovieClip();
   _root.smrtdolazi.removeMovieClip();
   _root.mpcetiketi.removeMovieClip();
   _root.mpclevel = 0;
   _root.somazgoon = 0;
};
// MOD: MPC bölümü (seviye seçme ekranında 18. buton, "MPC")
// 17. bölümün sahnesini kullanır ama oradaki top üretimi yerine her saniye sırayla bir sağdan
// bir soldan oyunun en büyük topunu (boyut 0) sonsuza dek gönderir. _root.mpclevel ile açılır.
_root.MPC_RAZINA = 18;
movieclip.prototype.razinaya_git = function(n)
{
   _root.razina = n;
   if(n == _root.MPC_RAZINA)
   {
      _root.mpclevel = 1;
      _root.gotoAndStop("razina17");
   }
   else
   {
      _root.mpclevel = 0;
      _root.gotoAndStop("razina" + n);
   }
};
movieclip.prototype.mpc_dongu = function()
{
   if(!_root.mpcetiketi)
   {
      // HUD'daki seviye numarasının (18) üstüne "MPC" yazısı
      _root.attachMovie("mpcetiket","mpcetiketi",59000);
      _root.mpcetiketi._x = 331;
      _root.mpcetiketi._y = 420;
   }
   if(!_root.somazgoon)
   {
      return undefined;
   }
   if(getTimer() - _root.mpcson >= 1000)
   {
      _root.mpcson = getTimer();
      if(_root.mpcyon == 1)
      {
         _root.mpcyon = -1;
      }
      else
      {
         _root.mpcyon = 1;
      }
      mpc_top(_root.mpcyon);
   }
};
movieclip.prototype.mpc_top = function(yon)
{
   // yon 1: sağdan sola, -1: soldan sağa (initball'da brzinax > 0 sola gider)
   // 3. bölme ekran dışına kadar uzanır; ljrb 1,5 sn sonra topu normal (0.) bölmeye alır (17. bölümdeki gibi)
   _root.ljevirub[3] = -200;
   _root.desnirub[3] = 900;
   var ad = "a" + _root.attached;
   _root.attachMovie("radilica",ad,20000 + _root.attached % 10000);
   if(yon == 1)
   {
      _root[ad].akcije._x = 730;
   }
   else
   {
      _root[ad].akcije._x = -36;
   }
   _root[ad].akcije._y = 180;
   _root.prizma = _root[ad].akcije;
   _root[ad].akcije.attachMovie("ljrb","gres",22);
   _root[ad].akcije.initball(yon,-1,0,3,random(6) + 1);
   _root.attached = _root.attached + 1;
};

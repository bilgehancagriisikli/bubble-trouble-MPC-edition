on(release){
   if(_root.meniji1 == "ok")
   {
      ozvuci("option");
      _root.meniji1 = "1pl";
      _root.brigraca = 1;
      izborrazine(); // MOD: seviye seçme ekranı (eskiden: _root.gotoAndPlay("igra");)
   }
}

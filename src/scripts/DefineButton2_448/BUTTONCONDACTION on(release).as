on(release){
   if(_root.meniji1 == "ok")
   {
      ozvuci("option");
      _root.meniji1 = "2pl";
      _root.brigraca = 2;
      izborrazine(); // MOD: seviye seçme ekranı (eskiden: _root.gotoAndPlay("igra");)
   }
}

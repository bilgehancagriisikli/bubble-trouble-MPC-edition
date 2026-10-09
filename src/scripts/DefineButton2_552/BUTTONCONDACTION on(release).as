on(release){
   if(_root.meniji2 == "ok")
   {
      ozvuci("option");
      _root.meniji2 = "back_from_contr_meni";
      _root.getback = 1;
      if(_root.volumenje < 10)
      {
         stopAllSounds();
      }
   }
}

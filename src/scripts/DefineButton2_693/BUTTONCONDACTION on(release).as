on(release){
   ozvuci("option");
   _root.scoretable.filename = "demo.sco";
   _root.scoretable.scoresize = 15;
   _root.scoretable.action = "INSERT";
   _root.scoretable.viewtype = "FLASH";
   _root.scoretable.winname = _root.winname;
   _root.scoretable.winlevel = _root.dorazina[_root.igralec];
   _root.scoretable.loadVariables("http://public.srce.hr/~kcvitan1/scoring.php","GET");
   if(_root.igralec == 1)
   {
      _root.provjera1 = "ok";
   }
   else if(_root.igralec == 2)
   {
      _root.provjera2 = "ok";
   }
   _root.nau = getTimer();
   prevFrame();
}

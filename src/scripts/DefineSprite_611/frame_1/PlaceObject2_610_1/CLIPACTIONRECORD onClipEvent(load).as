onClipEvent(load){
   pocetakpauze = getTimer();
   if((_root.player1move == "mis" and (_root.brigraca == 1 or _root.brigraca == 2) or _root.player2move == "mis" and (_root.brigraca == 2 or _root.brigraca == 3)) and 4 >= _root.razina)
   {
      _root.cvrsto2.attachMovie("pomaknimisafilm","sss",9999);
      _root.cvrsto2.sss._y = _root.pod - 150;
      _root.cvrsto2.sss._x = 350;
   }
}

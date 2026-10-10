onClipEvent(enterFrame){
   // MOD: MPC bölümü: kendi top üretimi (mpc_dongu), 17. bölümünki çalışmaz
   if(_root.mpclevel)
   {
      mpc_dongu();
   }
   else
   {
      if(3500 >= _root.tajmaut)
      {
         if(_root.kaos < 3)
         {
            _root.kaos = _root.kaos + 1;
            _root.tajmaut += 7000;
         }
         else
         {
            _root.tajmaut += 15000;
         }
      }
      sadkazem = getTimer();
      if(sadkazem - kadkazem1 >= _root.tajmaut)
      {
         _root.tajmaut -= 50;
         stancanje(-1,3);
         kadkazem1 = getTimer();
      }
      if(sadkazem - kadkazem2 >= _root.tajmaut + 2500)
      {
         _root.tajmaut -= 50;
         _root.loptica2.stancanje(1,4);
         kadkazem2 = getTimer();
      }
      if(sadkazem - kadkazem3 >= _root.tajmaut + 4850)
      {
         _root.tajmaut -= 50;
         _root.loptica3.stancanje(1,5);
         kadkazem3 = getTimer();
      }
      if(sadkazem - kadkazem4 >= _root.tajmaut + 13300)
      {
         _root.tajmaut -= 50;
         _root.loptica4.stancanje(-1,5);
         kadkazem4 = getTimer();
      }
   }
}
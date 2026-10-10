onClipEvent(load){
   kadkazem1 = getTimer();
   kadkazem2 = getTimer();
   kadkazem3 = getTimer();
   kadkazem4 = getTimer();
   // MOD: MPC bölümünde 17. bölümün topları üretilmez
   _root.mpcson = getTimer() - 1000;
   if(!_root.mpclevel)
   {
      stancanje(-1,3);
   }
}

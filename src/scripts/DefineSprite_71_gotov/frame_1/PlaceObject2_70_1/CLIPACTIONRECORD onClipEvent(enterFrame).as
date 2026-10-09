onClipEvent(enterFrame){
   krajpauze = getTimer();
   if(0 >= _root.timeleft._xscale and 1500 < krajpauze - pocetakpauze)
   {
      // MOD: sonraki bölüme geçmek yerine seviye seçme ekranını aç
      // (eskiden: somazgoon = 1; razina++; gotoAndStop("razina" + razina))
      _root.izborrazine_oyunda();
      removeMovieClip("../");
   }
}

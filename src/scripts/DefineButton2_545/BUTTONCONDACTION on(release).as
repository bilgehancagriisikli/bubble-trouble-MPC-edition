on(release){
   if(_root.meniji2 == "ok")
   {
      ozvuci("option");
      _root.setcontrols.plast.prevFrame();
      karakteristika = new Object();
      karakteristika.ra = 100;
      karakteristika.rb = 0;
      karakteristika.gb = 0;
      karakteristika.bb = 0;
      pboja = new Color(_root.setcontrols.ljev);
      pboja.setTransform(karakteristika);
      pboja = new Color(_root.setcontrols.desn);
      pboja.setTransform(karakteristika);
      pboja = new Color(_root.setcontrols.sred);
      pboja.setTransform(karakteristika);
   }
}

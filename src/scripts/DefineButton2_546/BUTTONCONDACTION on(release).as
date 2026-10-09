on(release){
   if(_root.meniji2 == "ok")
   {
      ozvuci("option");
      _root.setcontrols.plast.nextFrame();
      karakteristika = new Object();
      karakteristika.ra = 12;
      karakteristika.rb = 55;
      karakteristika.gb = 51;
      karakteristika.bb = 115;
      pboja = new Color(_root.setcontrols.ljev);
      pboja.setTransform(karakteristika);
      pboja = new Color(_root.setcontrols.desn);
      pboja.setTransform(karakteristika);
      pboja = new Color(_root.setcontrols.sred);
      pboja.setTransform(karakteristika);
   }
}

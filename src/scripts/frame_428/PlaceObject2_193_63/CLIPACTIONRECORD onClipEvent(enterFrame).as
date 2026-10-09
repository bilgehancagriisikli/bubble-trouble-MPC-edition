onClipEvent(enterFrame){
   if(_root.provjera1 != "ok")
   {
      provjera(1);
   }
   if(_root.provjera2 != "ok" and _root.provjera1 == "ok")
   {
      provjera(2);
   }
}

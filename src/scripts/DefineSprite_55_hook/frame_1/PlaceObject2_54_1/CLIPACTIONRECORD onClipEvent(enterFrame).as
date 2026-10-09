onClipEvent(enterFrame){
   if(!testirajuvjet and _root.somazgoon)
   {
      _Y = _Y - _root.rate * 265;
   }
   nowtime1 = getTimer();
   if(!testirajuvjet and this.hitTest(_root.strop1))
   {
      nextFrame();
      starttime1 = getTimer();
      testirajuvjet = 1;
   }
   if(_root.pucanjpauza[1] < nowtime1 - starttime1 and testirajuvjet and _root.somazgoon)
   {
      // MOD: "../:kreni" yolu yeni atış adlarıyla (shot1_5 gibi) çalışmıyordu
      _parent.gotoAndPlay("kreni");
   }
}

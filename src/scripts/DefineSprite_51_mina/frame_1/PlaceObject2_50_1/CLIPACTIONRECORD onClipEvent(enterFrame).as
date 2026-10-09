onClipEvent(enterFrame){
   if(_root.somazgoon)
   {
      _Y = _Y - _root.rate * 750;
   }
   if(this.hitTest(_root.strop1))
   {
      // MOD: "../:kreni" yolu yeni atış adlarıyla (shot1_5 gibi) çalışmıyordu
      _parent.gotoAndPlay("kreni");
   }
}

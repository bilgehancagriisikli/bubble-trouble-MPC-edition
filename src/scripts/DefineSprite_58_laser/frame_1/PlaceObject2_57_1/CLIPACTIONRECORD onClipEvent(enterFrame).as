onClipEvent(enterFrame){
   akcel += 0.1;
   if(_root.somazgoon)
   {
      _Y = _Y - _root.rate * 350 * akcel;
      _yscale = _yscale + 3 * _root.rate * 100;
   }
   if(this.hitTest(_root.strop1))
   {
      // MOD: "../:kreni" yolu yeni atış adlarıyla (shot1_5 gibi) çalışmıyordu
      _parent.gotoAndPlay("kreni");
   }
}

onClipEvent(enterFrame){
   if(_root.somazgoon)
   {
      _Y = _Y - _root.rate * 750;
   }
   if(this.hitTest(_root.strop1))
   {
      gotoAndPlay("../:kreni");
   }
}

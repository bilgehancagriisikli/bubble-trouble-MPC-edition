onClipEvent(mouseUp){
   if(_root.voljum == "ok")
   {
      this.stopDrag();
      _root.voljum = "notok";
      ozvuci("pop1");
   }
}

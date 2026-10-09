onClipEvent(enterFrame){
   if(_root.mis.kontura and _root._ymouse >= 380)
   {
      Mouse.show();
   }
   else if(_root.mis.kontura and _root._ymouse < 380 and _root.quit.gointo._currentframe == 2)
   {
      Mouse.hide();
   }
   _root.proslovrijeme = getTimer();
}

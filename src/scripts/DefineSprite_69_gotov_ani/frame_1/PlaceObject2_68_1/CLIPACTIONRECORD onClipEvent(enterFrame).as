onClipEvent(enterFrame){
   _root.timeleft._xscale -= _root.rate * 200;
   if((_root.brigraca == 1 or _root.brigraca == 2) and _root.timeleft._xscale >= 1)
   {
      _root.bodovi1 += Math.round(_root.timeleft._xscale / (_root.rate * 2000));
   }
   if((_root.brigraca == 2 or _root.brigraca == 3) and _root.timeleft._xscale >= 1)
   {
      _root.bodovi2 += Math.round(_root.timeleft._xscale / (_root.rate * 2000));
   }
   if(sadsamovdje != _root._currentframe)
   {
      _root.timeleft._xscale = 686.7;
      removeMovieClip("../");
   }
}

movieclip.prototype.introducing = function()
{
   majnetajme = getTimer();
   if(majnetajme - kolkodas >= 50)
   {
      _root.nextFrame();
      kolkodas = getTimer();
   }
};
movieclip.prototype.introducingslova = function()
{
   majnetajme = getTimer();
   if(majnetajme - kolkodas >= 50)
   {
      this.nextFrame();
      kolkodas = getTimer();
   }
};

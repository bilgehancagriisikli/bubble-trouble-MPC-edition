// MOD: seviye seçme ekranında seçilen seviyeye atla
if(_root.secilenrazina > 1)
{
   _root.razina = _root.secilenrazina;
   _root.secilenrazina = 0;
   gotoAndStop("razina" + _root.razina);
}
else
{
   mojevrijemeje(40,25);
   pocistisve();
   defaultstaza();
   _root.itemz = new Array("x","x","x","o","x","o","o","o","o","o","o");
   stop();
}

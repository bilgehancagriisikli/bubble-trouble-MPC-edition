// MOD: seviye seçme ekranında seçilen seviyeye atla
if(_root.secilenrazina > 1)
{
   var n = _root.secilenrazina;
   _root.secilenrazina = 0;
   razinaya_git(n);
}
else
{
   _root.mpclevel = 0;
   mojevrijemeje(40,25);
   pocistisve();
   defaultstaza();
   _root.itemz = new Array("x","x","x","o","x","o","o","o","o","o","o");
   stop();
}

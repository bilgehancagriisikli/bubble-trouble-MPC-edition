mojevrijemeje(25,18);
pocistisve();
defaultstaza();
_root.pod = 285;
_root.maxvisine = new Array("65","110","150","190","230","216","10");
_root.maxbrziney = new Array();
i = 0;
while(6 >= i)
{
   _root.maxbrziney[i] = Math.sqrt(2 * _root.gravitacija * (_root.pod - _root.maxvisine[i] - _root.scales[i] / 2),2);
   i++;
}
stop();

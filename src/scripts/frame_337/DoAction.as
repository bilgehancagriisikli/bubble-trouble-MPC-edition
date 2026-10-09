mojevrijemeje(45,30);
pocistisve();
defaultstaza();
_root.scales = new Array("100","80","60","40","20","10","10");
_root.maxvisine = new Array("65","110","150","190","80","80","10");
_root.maxbrziney = new Array();
i = 0;
while(6 >= i)
{
   _root.maxbrziney[i] = Math.sqrt(2 * _root.gravitacija * (_root.pod - _root.maxvisine[i] - _root.scales[i] / 2),2);
   i++;
}
_root.itemz = new Array("x","x","x","x","x","x","x","x","o","o","o");
_root.attached = 1;
stop();

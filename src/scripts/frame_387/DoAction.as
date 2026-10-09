mojevrijemeje(50,30);
pocistisve();
defaultstaza();
_root.pod = 304;
_root.scales = new Array("100","80","60","40","20","10","10");
_root.maxvisine = new Array("65","50","50","50","150",_root.pod,"10");
_root.maxbrziney = new Array();
i = 0;
while(6 >= i)
{
   _root.maxbrziney[i] = Math.sqrt(2 * _root.gravitacija * (_root.pod - _root.maxvisine[i] - _root.scales[i] / 2),2);
   i++;
}
_root.itemz = new Array("x","o","x","o","o","x","x","x","o","x","x");
stop();

mojevrijemeje(130,75);
pocistisve();
defaultstaza();
_root.ljevirub = new Array("7.3","126.5","247.9","369.4","490.8","612.3");
_root.desnirub = new Array("86.5","207.9","329.4","450.8","572.3","694.1");
_root.ljevix = Number(_root.ljevirub[0]) + _root.sirinaigraca / 2;
_root.desnix = Number(_root.desnirub[0]) - _root.sirinaigraca / 2;
_root.scales = new Array("100","80","60","40","20","10","10");
_root.maxvisine = new Array("65","110","110","150","190","230","10");
_root.maxbrziney = new Array();
i = 0;
while(6 >= i)
{
   _root.maxbrziney[i] = Math.sqrt(2 * _root.gravitacija * (_root.pod - _root.maxvisine[i] - _root.scales[i] / 2),2);
   i++;
}
_root.levela = 6;
_root.vrat = 0;
_root.attached = 1;
stop();

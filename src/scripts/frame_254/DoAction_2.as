if(_root.player1move == "mis" and (_root.brigraca == 1 or _root.brigraca == 2))
{
   Mouse.hide();
   _root.mis.attachMovie("kontura","kontura",1);
}
else if(_root.player2move == "mis" and _root.brigraca == 2)
{
   Mouse.hide();
   _root.mis.attachMovie("kontura","kontura",1);
}
_root.pod = 369;
_root.ljevirub = new Array("7.3");
_root.desnirub = new Array("694.1");
_root.gravitacija = 0.05;
_root.vjerojatnost = 2;
_root.sirinaigraca = 30;
_root.visinaigraca = 42;
_root.brzinaigraca = 120;
_root.lives1 = 5;
_root.lives2 = 5;
_root.bodovi1 = 0;
_root.bodovi2 = 0;
_root.ljevix = Number(_root.ljevirub[0]) + _root.sirinaigraca / 2;
_root.desnix = Number(_root.desnirub[0]) - _root.sirinaigraca / 2;
_root.dorazina = new Array();
_root.pucanjvrsta = new Array("single","hook","mina","laser");
_root.pucanjpauza = new Array(70,3000,500,0);
_root.brojloptica = new Array();
_root.attached = 1;
_root.levela = 1;
_root.razina = 1;
_root.scales = new Array("100","80","60","40","20","10","10");
_root.maxvisine = new Array("65","110","150","190","230","300","10");
_root.maxbrziney = new Array();
i = 0;
while(6 >= i)
{
   _root.maxbrziney[i] = Math.sqrt(2 * _root.gravitacija * (_root.pod - _root.maxvisine[i] - _root.scales[i] / 2),2);
   i++;
}

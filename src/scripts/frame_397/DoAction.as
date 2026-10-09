pocistisve();
defaultstaza();
_root.itemz = new Array("x","x","x","x","o","x","x","x","x","x","o");
stop();
_root.tajmaut = 12000;
movieclip.prototype.stancanje = function(x, level)
{
   _root.ljevirub[level] = -200;
   _root.desnirub[level] = 900;
   _root.attachMovie("radilica","a" + _root.attached,_root.attached);
   _root["a" + _root.attached].akcije._x = _X;
   _root["a" + _root.attached].akcije._y = _Y;
   _root.prizma = _root["a" + _root.attached].akcije;
   _root["a" + _root.attached].akcije.attachMovie("ljrb","gres",22);
   _root["a" + _root.attached].akcije.initball(x,-1,random(3) + 3 - _root.kaos,level,random(6) + 1);
   _root.attached = _root.attached + 1;
};

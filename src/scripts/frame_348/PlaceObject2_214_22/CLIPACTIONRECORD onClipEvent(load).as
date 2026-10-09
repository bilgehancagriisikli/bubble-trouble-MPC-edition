onClipEvent(load){
   _root.attachMovie("radilica","a" + _root.attached,_root.attached);
   _root["a" + _root.attached].akcije._x = _X;
   _root["a" + _root.attached].akcije._y = _Y;
   _root["a" + _root.attached].akcije.initball(0,1,3,0,6);
   _root.attached = _root.attached + 1;
}

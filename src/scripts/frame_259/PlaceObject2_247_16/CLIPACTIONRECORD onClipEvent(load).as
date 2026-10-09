onClipEvent(load){
   _root.attachMovie("radilica","a" + _root.attached,_root.attached + 500);
   _root["a" + _root.attached].akcije._x = _X;
   _root["a" + _root.attached].akcije._y = _Y;
   _root["a" + _root.attached].akcije.initball(-1,1,4,0,3);
   _root.attached = _root.attached + 1;
}

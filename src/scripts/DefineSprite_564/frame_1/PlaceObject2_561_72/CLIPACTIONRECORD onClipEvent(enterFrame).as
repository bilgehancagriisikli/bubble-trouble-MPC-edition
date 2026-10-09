onClipEvent(enterFrame){
   _root.volumenje = _X / maksimalno * 100;
   razlika = _root.setcontrols.volme.boja._x - _X;
   _root.setcontrols.volme.boja._x -= razlika;
}

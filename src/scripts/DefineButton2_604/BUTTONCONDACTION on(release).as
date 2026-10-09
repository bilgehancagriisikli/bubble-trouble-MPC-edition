on(release){
   _root.oyunu_temizle(); // MOD: topları vb. temizle
   _root.kill();
   stopAllSounds();
   _root.gotoAndPlay("welcome");
}

_root.ID = 1;
movieclip.prototype.oruzje = function()
{
   sansa = random(_root.vjerojatnost);
   if(sansa == 0)
   {
      odlucikojiitem();
      _root.ID = _root.ID + 1;
      _root.mis.attachMovie("oruzje" + _root.colect,"oruzje" + _root.ID,_root.ID + 100);
      _root.mis["oruzje" + _root.ID]._y = _Y;
      _root.mis["oruzje" + _root.ID]._x = _X;
   }
};
movieclip.prototype.odlucikojiitem = function()
{
   do
   {
      if(25 >= guess() and _root.itemz[0] == "x")
      {
         _root.colect = 0;
         gotov = "da";
      }
      else if(25 >= guess() and _root.itemz[1] == "x")
      {
         _root.colect = 1;
         gotov = "da";
      }
      else if(25 >= guess() and _root.itemz[2] == "x")
      {
         _root.colect = 2;
         gotov = "da";
      }
      else if(25 >= guess() and _root.itemz[3] == "x")
      {
         _root.colect = 3;
         gotov = "da";
      }
      else if(25 >= guess() and _root.itemz[4] == "x")
      {
         _root.colect = 4;
         gotov = "da";
      }
      else if(30 >= guess() and _root.itemz[5] == "x")
      {
         _root.colect = 5;
         gotov = "da";
      }
      else if(30 >= guess() and _root.itemz[6] == "x")
      {
         _root.colect = 6;
         gotov = "da";
      }
      else if(30 >= guess() and _root.itemz[7] == "x")
      {
         _root.colect = 7;
         gotov = "da";
      }
      else if(35 >= guess() and _root.itemz[8] == "x")
      {
         _root.colect = 8;
         gotov = "da";
      }
      else if(35 >= guess() and _root.itemz[9] == "x")
      {
         _root.colect = 9;
         gotov = "da";
      }
      else if(40 >= guess() and _root.itemz[10] == "x")
      {
         _root.colect = 10;
         gotov = "da";
      }
   }
   while(gotov != "da");
   
};
movieclip.prototype.guess = function()
{
   return random(100);
};

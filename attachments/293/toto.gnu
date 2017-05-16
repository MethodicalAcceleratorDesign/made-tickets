
  ++++++++++++++++++++++++++++++++++++++++++++
  +     MAD-X 5.02.02  (64 bit, Darwin)      +
  + Support: mad@cern.ch, http://cern.ch/mad +
  + Release   date: 2014.07.04               +
  + Execution date: 2014.08.25 17:29:34      +
  ++++++++++++++++++++++++++++++++++++++++++++


create, table=test, column=a,b;

value, table(test,tablelength);

table( test tablelength ) =                  0 ;


// testing fill



a=9;    b=9;        fill, table=test; // row=0 is default and adds a row to the table

value, table(test,tablelength);

table( test tablelength ) =                  1 ;
a=9;    b=9;        fill, table=test, row=0; 

++++++ info: a redefined
++++++ info: b redefined
value, table(test,tablelength);

table( test tablelength ) =                  2 ;
a=5.32; b=-3.2;     fill, table=test, row=0;

++++++ info: a redefined
++++++ info: b redefined
value, table(test,tablelength);

table( test tablelength ) =                  3 ;


a=2;    b=4;        fill, table=test, row=2; // filling again an already existing row

++++++ info: a redefined
++++++ info: b redefined
value, table(test,tablelength);

table( test tablelength ) =                  3 ;
a=1;    b=2;        fill, table=test, row=-3; // negative row number

++++++ info: a redefined
++++++ info: b redefined
value, table(test,tablelength);

table( test tablelength ) =                  3 ;


exit;


  Number of warnings: 0

  ++++++++++++++++++++++++++++++++++++++++++++
  + MAD-X 5.02.02 (64 bit) finished normally +
  ++++++++++++++++++++++++++++++++++++++++++++

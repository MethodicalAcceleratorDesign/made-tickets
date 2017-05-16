# script showing the problem with MKTHIN:
# 
# By aritificially reducing the strength of solenoid by the nunber of slices (i.e. $i), 
# the twiss plot is correct regardless of the number of slices used in mkthin
#

for i in 10 20 30 40 50 ; do 

../madx64 <<EOF
! define sequence with two solenoid elements and one dipole:
beam, sequence=seq;
seq: sequence, l=3, refer=centre;
sol1: solenoid, l=1, at=0.5, ks=10/$i;
bend: sbend,    l=1, at=1.5, angle=PI/2;
sol2: solenoid, l=1, at=2.5, ks=10./$i;
endsequence;

! for demonstrational purposes: slice the sequence
use, sequence=seq;
select, flag=makethin, slice=$i, class=solenoid;
select, flag=makethin, slice=$i, class=sbend;
makethin, sequence=seq;

use, sequence=seq;
save,sequence=seq,file=s${i}.save;

! simulate and output seq:
use, sequence=seq;
select, flag=twiss, column=name, s, betx, bety, alfx, alfy, mux, muy, dx, dy, dpx, dpy;

twiss, sequence=seq,
    betx=1, bety=1,
    alfx=1, alfy=1,
    file="t${i}.twiss";
EOF

done

gnuplot -p <<EOF
plot for [i=10:50:10] 't'.i.'.twiss' u 2:3 w lp
EOF
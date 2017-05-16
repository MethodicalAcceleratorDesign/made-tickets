madx=madx_dev

# dual solenoids:
$madx <<EOF
    beam, sequence=dual, mass=12.0, energy=12.08, charge=4.0, ey=3e-4, ex=3e-4;

    dual: sequence, refer=centre, L:=3.0;
    sol1: solenoid,   l=1, ks=10, at:=0.5;
    quad: quadrupole, l=1, k1:=10, at:=1.5;
    sol2: solenoid,   l=1, ks:=5, at:=2.5;
    endsequence;

    use, sequence="dual";
    select, flag=twiss, column=name, s, betx, bety, alfx, alfy, mux, muy, dx, dy, dpx, dpy;
    twiss, sequence=dual, file="dual.twiss", bety=0.1, betx=0.1;
EOF

# extract starting values for the comparison case
# (is there a builtin command in madx for this?)
perl extract.pl sol1 <dual.twiss >mono.init
source ./mono.init

# only one solenoid:
$madx <<EOF
    beam, sequence=mono, mass=12.0, energy=12.08, charge=4.0, ey=3e-4, ex=3e-4;

    mono: sequence, refer=centre, L:=3.0-$S;
    quad: quadrupole, l=1, k1:=10, at:=1.5-$S;
    sol2: solenoid,   l=1, ks:=5, at:=2.5-$S;
    endsequence;

    use, sequence=mono;
    select, flag=twiss, column=name, s, betx, bety, alfx, alfy, mux, muy, dx, dy, dpx, dpy;
    twiss, sequence=mono, file="mono.twiss",
            betx=$BETX, bety=$BETY,
            alfx=$ALFX, alfy=$ALFY,
            mux=$MUX, muy=$MUY,
            dx=$DX, dy=$DY,
            dpx=$DPX, dpy=$DPY;
EOF

# plot
gnuplot -p <<EOF
    plot "dual.twiss" u 2:3 w lp title 'dual', \
         "mono.twiss" u (\$2+$S):3 w lp title 'mono'
EOF


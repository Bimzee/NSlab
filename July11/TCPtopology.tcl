
set ns [new Simulator]

set f0 [open tcp0.tr w]
set f1 [open tcp1.tr w]
set f2 [open tcp2.tr w]

set nf [open  varitcp.tr


proc record{} {
global ns tcp0,tcp1,tcp2,f0,f1,f2

set time0.01

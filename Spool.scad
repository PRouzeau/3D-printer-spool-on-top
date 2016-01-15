// spool holder vertical axis
// for holes 31-38 and 51-54 - option untested for hole 19mm
// Material licence CERN OHL V1.2  documentation  CC BY-SA
// Copyright Pierre ROUZEAU (PRZ) 2015-2016
// This replace the former spool on top support which was built with ball bearings. As using bearings then adding a brake to improve unwinding was not really wise, I redesigned the system without ball bearings. The braking depends of the spool weight, which is coherent with the fact that an empty spool do have a lower winding diameter, but for 0.5kg spool, the braking effect is fairly light. It is low but acceptable for a spool of 1kg, if printed in PETG. PLA may give a bit more braking effect (less slippery than PETG). 
include <PRZutility.scad>

// see http://rouzeau.net/Print3D/SpoolOnTop
/*BOM list :
*1 wood screw 4x25

Printed parts:
*Spool fixed foot
*Spool rotating support for hole 31-38 mm
*Ring for 50mm spool

*/

cylplay = 0.35; // play between foot and spool support 

part=1;

if (part==1) { // ensemble
  color ("blue") rotz (25) spool();
  color ("yellow") {
    tsl (0,0,6) ring();
    foot();  
  }  
}  
else if (part==2) foot();  // Fixed foot
else if (part==3) {$ears=true; spool();}  //Rotating spool support  
else if (part==4) ring();  // 50mm centering ring
else if (part==5) spool19();  //Spool support int diam 19  - untested 
else if (part==6) { // Plate with the components. 
  $ears=true;
  spool();
  tsl (55,0,2) foot();  // foot
  tsl (22,45,0) rotz(46)ring();
  //color ("red")cylz (140,-1, 3.5,4,0,50); //Check inscribed circle (diameter 140)
}
else if (part==99) projection(cut=true) rot(90) { // test thicknesses
  spoola(); // spool support
 * spool19(); // spool support
  foot();
}  

module rot5(astart=0) {
  for (i=[0:4])  
    rotz(i*72+astart) children();
}

module ring(di=50) {
  difference() {
    union() {  
      rot5() {
        hull() {
          cubez (4,di/2,9.5, 0,di/4);
          cubez (4,di/2-1.6,11, 0,di/4-0.8);
        } 
      }
      cylz (34,11, 0,0,0, 64);
      rotz(18)
        cylz (di,2, 0,0,0, 5);
    }
    cylz (-30.1,66, 0,0,0, 64);
  }
}

module spool() {
ht=6;
rotz(10)
  difference() {
    union() {  
      cconez (27,18,  12,8, 0,0,0, 50); 
      cylz (18,8, 0,0,19.9, 50);
      rot5() {
        hull() {
          cubez (6,4,ht, 0,10);
          cylz(6.5,ht, 0,32);
          cylz(4,ht, 0,62);
        }  
        hull() {
          cubez (4,15,11.5+ht, 0,7.5);
          cubez (3.2,0.5,26, 0,7);
        }
        if ($ears)
          rotz(18) cylz (12, 0.8, 59);
      }
      rot5(36) 
        cubez (40,4.5,ht, 0,26);
    } // then whats removed
    cconez (23,14, 12,8, 0,0,-0.5, 50); 
    cylz (14,50, 0,0,0, 50);
  }
}

module spool19() {
  difference() {
    union() {  
      hull () {
        cylz (24,1,  0,0,12, 50); 
        cylz (27,0.5,  0,0,18, 50); 
      }  
      cylz (18.5,55, 0,0,0, 50);
      
    } // then whats removed
    cconez (23,14, 12,6.5, 0,0,-0.5, 50); 
    cylz (14,60, 0,0,0, 50);
  }

}

module foot() {
  difference() {
    union() {
      cconez (23-cylplay, 14-cylplay,12,8, 0,0,-2, 50); 
      cylz (14-cylplay,28, 0,0,0, 50);
      cylz (28,2, 0,0,-2, 50);
    }
    cconez (17,8.5, 12,3,  0,0,-2.5+5, 50); 
    cylz (8.5,13, 0,0,16, 50);
    cconez (17,8.5, -1.5,-3,  0,0,-2.5+5, 50); 
    cconez (4,9, 2,-4, 0,0,-0.5);
  }
} 

// spool holder vertical axis
// for holes 31-38 and 50-54 - not ok for hole 20mm
// Material licence CERN OHL V1.2  documentation  CC BY-SA
// Copyright Pierre ROUZEAU (PRZ) sept 2015
include <PRZutility.scad>
include <X_utils.scad>
// see http://rouzeau.net/Print3D/SpoolOnTop
/*BOM list :
*2 608ZZ (or 608RS) bearings
*1 M8x40 screw hex head, fully threaded
*2 M8 hex nuts  
*1 M8 butterfly nut (could use an hex nut instead)
*4or 5 M8 small washers
*1 wood screw 3x10 or bolt M3x15 (for the brake)

Printed parts:
*Spool support
*Ring for 50mm spool
*Brake

Bearings are separated by an M8 nut + 2 washers.
Depending your washer thickness, you may have to set one or two washers below the bottom nut to give space for the spool brake.
*/

part=1;

if (part==1) { // ensemble
  color ("gray") {
    cubez (160,160,-5, 0,0,-5);
    cylz (8,40, 0,0,-16);
    duplz (22+5)
      cylz (15,6.4, 0,0,-5, 6);
    cylz (15,6.4, 0,0,-15, 6);
    duplz (10)
      tsl (0,0,6.5)
        BB("608");
  }  
  color ("blue") rotz (25) spoola();
  color ("yellow") {
    tsl (0,0,6) ringa();
    
    tsl (-35,32,-1) 
      mirrorz() rot(0,-2,180) brake();
  }  
}  
else if (part==2) spoola(); // spool support
else if (part==3) ringa();  // 50mm centering ring
else if (part==4) brake();  // brake

module rot5(astart=0) {
  for (i=[0:4])  
    rotz(i*72+astart) children();
}

module ringa(di=48) {
  difference() {
    union() {  
      rot5() {
        hull() {
          cubez (5,di/2,8, 0,di/4);
          cubez (5,di/2-1.6,10, 0,di/4-0.8);
        } 
      }
      cylz (35,10, 0,0,0, 64);
      rotz(18)
        cylz (di,2, 0,0,0, 5);
    }
    cylz (-30.4,66, 0,0,0, 64);
  }
}

module spoola() {
ht=6;
rotz(10)
  difference() {
    union() {  
      cylz (27,25, 0,0,0, 50);
      rot5() {
        hull() {
          cubez (5,4,ht, 0,10);
          cylz(7,ht, 0,34);
          cylz(4,ht, 0,62);
        }  
        hull() {
          cubez (4,15,23, 0,7.5);
          cubez (4,14,25, 0,7);
        }
      }
      rot5(36) 
        cubez (40,4.5,ht, 0,30);
    }
    hull() {
      cylz (22.12, 24, 0,0,-1, 50);
      cylz (22.2, 1, 0,0,22, 50);
    }  
    cconez (22.2, 20.5, 1.2,-1,  0,0,23.9, 50);
  }
}

module brake() {
  difference() {
    union() {
      hull() {
        cubez (72,12,1);
        cubez (1,12,4.8, 10);
      } 
      dmirrory() cylz (3.8,7.5, 10,6);
      //cylz (6,2.5, 34);
    }
    cylz (-3,66, 32);
  }
} 

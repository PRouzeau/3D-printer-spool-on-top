include <PRZutility.scad>
// Miscellaneous utility functions, not in Library

module build_fan(size=40, thk=6) { //~ok for 25,30,40,60,80,120. Not ok for 92
  holesp = size==120?52.5:size==80?35.75:size==60?25:0.4*size;
  color ("black") {
    difference() {
      hull() 
        dmirrorx() dmirrory() cylz (2,thk,size/2-1,size/2-1);
      cylz (-size *0.95,55);
      dmirrorx() dmirrory() cylz (-(size*0.03+2),55,holesp,holesp);
    }
    cylz (12+size/8, thk-1,0,0,0.5);
  }  
} 

//-- Ball bearings ------------------------------------------------

module BBx (type="623", orient=1, x,y,z) {
  tsl (x,y,z)
    rot (0,90)
      BB(type, orient);
}

module BB (type="623", orient=1) {
  module B(De,di,thk,Flthk=0,DFl=0, orient) {
    mz = (orient==0)?-thk/2:0; 
    mirr = (orient==-1)?true:false;
    DF = (DFl) ? DFl: De+1.5*Flthk;
    tsl (0,0,mz)
    mirrorz(mirr)
      color ("silver")
        tsl (0,0,-Flthk) 
          difference() {
            union() {
              cylz (De, thk);  
              if (Flthk)
                cylz (DF, Flthk);
            }  
            cylz (di, thk+0.2, 0,0,-0.1);  
          }
  } 
  if (type=="623")       B(10,3,4,0,0,   orient);
  else if (type=="F623") B(10,3,4,1,11.5,orient);  
  else if (type=="624")  B(13,4,5,0,0,  orient);
  else if (type=="F624") B(13,4,5,1,15, orient);  
  else if (type=="625")  B(16,5,5,0,0,  orient);
  else if (type=="F625") B(16,5,5,1,18, orient);
  else if (type=="603")  B(9 ,3,5,0,0,  orient);    
  else if (type=="604")  B(12,4,4,0,0,  orient);    
  else if (type=="605")  B(14,5,5,0,0,  orient);  
  else if (type=="606")  B(17,6,6,0,0,  orient); 
  else if (type=="607")  B(19,7,6,0,0,  orient);   
  else if (type=="608")  B(22,8,7,0,0,  orient);
  else if (type=="634")  B(16,4,5,0,0,  orient);  
  else if (type=="MR63")  B(6,3,2,0,0,  orient);        
  else if (type=="MR73")  B(7,3,3,0,0,  orient);      
  else if (type=="MR83")  B(8,3,2.5,0,0,orient);
  else if (type=="MR83b") B(8,3,3,0,0,  orient);    
  else if (type=="MR93")  B(9,3,4,0,0,  orient); 
  else if (type=="MR103") B(10,3,4,0,0,orient); // same as 623 
}



module segz (d,depth, x1,y1,x2,y2) { // extruded rounded segment
  linear_extrude(height=depth, center=false)  
    hull () {
      tsl(x1,y1) circle (d=d); 
      tsl(x2,y2) circle (d=d);
  }
}

module wrnb (nb, size=10, depth=1, pos=0) { // write a digit
diam = 10/7;
dmoy = (10-diam)/2;
dint = dmoy-diam;
dext = dmoy+diam;
rdext = dext/2;  
dpp =abs(depth);
  tsl (pos) 
    scale ([size/10, size/10, dpp]) {
      if (nb==3 ||nb==8 ) {
        difference () {
          union() {
            cylz(dext,1,0,rdext);
            cylz(dext,1,0,10-rdext);
          }
          cylz (-dint,3,0,rdext);
          cylz (-dint,3,0,10-rdext);
          if (nb==3) 
            cylz (-10, 3,-10/1.8, 5);
        }  
      } 
      else if (nb==0)   {
        difference () {
          hull() {
            cylz(dext,1,0,rdext);
            cylz(dext,1,0,10-rdext);
          }
          hull() {
            cylz (-dint,3,0,rdext);
            cylz (-dint,3,0,10-rdext);
          }  
        }  
      }
      else if (nb==1)   {
        cubez(diam,10,1,1,5);
        tsl(1)
        rotz(35) 
          cubez(3,diam,1,4,7.65);
      }
      if (nb==2) {
        difference () {
          cylz(dext,1,0,10-rdext);
          cylz (-dint,3,0,10-rdext);
          tsl (0,10-dmoy)
            rotz(-38)
              mcube(10,4,4,true,0,-1);
        }  
        mcube (dext-0.2,diam,1, false,-rdext+0.21);
        tsl (-0.12,3.5,0.5)
          rotz(52)
            mcube(6.3,diam,1,true);
      }
      if (nb==4) {
        mcube (dext-0.2,diam,1, false,-rdext+0.21,1.8);
        tsl (-0.18,6.2,0.5)
          rotz(61)
            mcube(7.6,diam,1,true);
        mcube (diam,4,1,false);
      }
      else if (nb==5) {
        difference () {
          cylz (dmoy+diam,1,0,rdext);
          cylz (-dint,3,0,rdext);
          cylz (-10, 3, -10/1.8, 5);
          mcube (dint,dint/2,3,true,-dint/2, rdext+dint/4);
        }
        difference () {
          mcube (dext,dext,1,true,diam*0.65,10-dext*0.55, 0.5);
          mcube (dint,dint*2,3,true,diam*0.65,10-dext*0.55-dint/2);
          mcube (dint,dint,3,true,diam*0.65,10-rdext-diam*1.1);
          rotz(-10) mcube (10,10,3,true,5.7,6);
          mcube (dint,dint/2,3,true,-dint/2, rdext+dint/4);
        }  
      } 
      else if (nb==6 || nb==9) {
        mirr9=(nb==9)?1:0;
        tsl(0,10/2)
          mirror([mirr9,0,0])
            mirror([0,mirr9,0])
              tsl (0,-10/2) {
                difference () {
                  cylz(dext,1,0,rdext);
                  cylz (-dint,3*1,0,rdext);
                }
                difference () {
                  cylz(14+diam,1,7-dmoy/2,rdext,0,60); 
                  cylz(14-diam,3,7-dmoy/2,rdext,-1,60);
                  mcube (30, 10, 3, true, 0,-10/2+rdext);
                  rotz(18) mcube (40,20, 3,true,7-dmoy/2+20,rdext); 
                }  
              }  
      }
      else if (nb==7) tsl (-10/20) {
        difference () {
          rotz(-25) mcube (diam,20,1,true,-diam,5,0.5);
          cubez (20, 10, 3,0,-10/2.1,-1);
          cubez (20, 10, 3,0,14.7,-1);
        }
        cubez(3*diam,diam,1,0,10-diam*0.7);
      }
    }
}

module writenum (num, size=10, depth=1) {
  tsl (size*0.3,0,-depth/2)
    for (i=[0:len(num)-1]) 
      wrnb (num[i],size,depth,0.68*size*i);
}

//writenum ([0,1,2,3,4,5,6,7,8,9],6); 

module writeCC (size,depth=1,nc=true) { // Graphism is non standard for CC 
dx = (nc)?67:38;   
dpp =abs(depth);
diam = 10/5.5; 
 tsl (0,0,-dpp/2)
  scale ([size/10, size/10, dpp]) {
    duplx (10) 
      difference () {
        cylz(10,1,0,5);
        cylz (-10+2*diam,3,0,5);
        cylz (-8,3,5,5);
      } 
    byz (10, 1, 20);
    if (nc) {   
      tsl (38) segz (diam,1,0,3,5,3); // "-"
      tsl (48) { // "n"
        segz (diam,1,0,0,0,6);
        segz (diam,1,5.5,0,5.5,6);
        segz (diam,1,0,5,5.5,1);
      }  
      tsl (60) { // "c"
        difference () {
          cylz (6+diam, 1,0,3);
          cylz (-6+diam, 3,0,3);
          cylz (-6, 3,3.5,3);
        }
        tsl (0,3)
          dmirrory()
            cylz(diam*1.05, 1,1.95,2.2);
      }
    }
    tsl (dx) segz (diam,1,0,3,5,3); // "-"
    
    tsl (dx+11) { //"s"
      segz (diam,1,-2,0,2,0);
      segz (diam,1,0,6,3,6);
      segz (diam,1,0,3,2,3);
      tsl (2) difference () {
        cylz(3+diam, 1,0,1.5);
        hull() {
          cylz(-3+diam, 3,0,1.5);
          cylz(-3+diam, 3,-10,1.5);
        }
        mcube (10,10,10, true, -5); 
      }
      difference () {
        cylz(3+diam,1,0,4.5);
        hull() {
          cylz(-3+diam, 3,0,4.5);
          cylz(-3+diam, 3,10,4.5);
        }
        mcube (10,10,10, true,5); 
      }
    }
    tsl (dx+21) { //"a"
      segz (diam,1,3.2,0,3.2,6);
      difference () {
         cylz (6+diam, 1, 0, 3);
         cylz (-6+diam, 3, 0, 3);
         mcube (10,20,3, true, 5);
      } 
      cylz (diam,1);
      cylz (diam,1,0,6);
    }
  }
}

module DNx_signature (size, depth, x=0,y=0,z=0, nb) { // write Printer name
  mz=(size<0)?-depth/2:0;
  sz = abs(size);
  diam = sz/5;
  i = sz/7;
  small = sz*0.8;
  tn = sz*0.667;
  posn = 6.5*diam;
  posx = posn+5.7*diam;
  mid = 2*diam-0.5*i;
  tsl (x,y,z+mz) {  
    segz (diam,depth,0,0,0,sz);
    segz (diam,depth,diam+i,0,diam+4*i,mid);
    segz (diam,depth,diam+i,sz,diam+4*i,sz-mid);
    tsl (posn) {
      segz (diam,depth,0,0,0,small);
      segz (diam,depth,0,small-0.8*i,tn,0.8*i);
      segz (diam,depth,tn,0,tn,small);
    }
    tsl (posx) {
      segz (diam,depth,0,0,tn,tn);
      segz (diam,depth,0,tn,tn,0);
    }
  } 
}

module byz (size, depth, x=0,y=0,z=0) { // write 'by' - for signature - 
  mz=(size<0)?-depth/2:0;
  sz = abs(size);  
  diam=sz/5.5;
  tsl (x-sz/10,y,z+mz) {
    segz (diam,depth,0.3*diam,0,0.3*diam,sz);
    difference () {
      cylz (4*diam, depth, 2*diam, diam*1.5);
      cylz (-2*diam, 3*depth, 2*diam, diam*1.5);
      tsl (diam,2*diam) mcube (2*diam,6*diam,3*depth, true);
    } 
    cylz (diam,depth,2*diam,3*diam);
    cylz (diam,depth,2*diam,0);
    segz (diam,depth,5*diam,3*diam,7*diam,0.5*diam);
    segz (diam,depth,8.5*diam,3*diam,5.5*diam,-2*diam);
  }
}  

//DNx_signature (-10, 2);
//byz(-6,2,38,-0.5);

module framexy (x,y,edgewidth=2.5, height=10) { //build a frame.Prefer just drafting corners ?? for cut plates delimitations
  difference () { // peripheral frame
    mcube (x,y,height);
    mcube (x-2*edgewidth, y-2*edgewidth,55,false,edgewidth,edgewidth,-5);
  }
}

module attachx (x,y, length=10) { //Laser cut create a small link 1.5 mm width 'attach' between parts - in x
  cubez (length,2.5,10,x,y);
}

module attachy (x,y, length=10) { //Attach oriented in y axis
  cubez (2.5,length,10,x,y);
}


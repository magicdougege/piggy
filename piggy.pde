// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// Box2DProcessing example

// Basic example of controlling an object with our own motion (by attaching a MouseJoint)
// Also demonstrates how to know which object was hit

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import KinectPV2.KJoint;
import KinectPV2.*;
//import processing.sound.*;
KinectPV2 kinect;


// A reference to our box2d world
Box2DProcessing box2d;

// Just a single box this time
Box chicken;

// An ArrayList of particles that will fall on the surface
//ArrayList<Rock> rocks;

//ArrayList<Egg> eggs;
color[] colbox = new color[10];
// The Spring that will attach to the box from the mouse
Spring spring;

//game functiom
//int score=0;
//int scoretemp=0;
int achive=0;
int count=0;

//Boundary wall;

PShape egg_shape;
PShape rock_shape;
timer wingT;
timer startT;

//for wing listener to recored the angle variation 
float new_Leftangle;
float org_Leftangle;
float new_Rightangle;
float org_Rightangle;
int wing_count = 0 ;
int start = 1; 
//to smooth the pass
boolean[] pass = new boolean[3];

//soundeffect 
//SoundFile BGM;
//SoundFile bluh;
void setup() {
  size(1440,810,P3D);
  smooth();

  // Initialize box2d physics and create the world
  box_init();
  // Initialize the envireoment of kinect
  kinet_init();
  //the timer for the wing routine
  wingT = new timer(1000*second()+millis(),100);
   //the timer for the drop  routine
  startT = new timer(1000*second()+millis(),1000);;
  //import the shape 
  //egg_shape = loadShape("egg.svg");
  //rock_shape = loadShape("rock.svg");
  //import the sound effect 
  //BGM = new SoundFile(this, "BGM.mp3");
  //bluh = new SoundFile(this, "bluh.mp3");
  //BGM.loop();
  
}

void draw() {
 
 if (start == 0){
   startgame();
 }
 else{
     background(255);
     image(kinect.getColorImage(), 0, 0, width/5, height/5);
    
    ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
    
    //individual JOINTS
    for (int i = 0; i < skeletonArray.size(); i++) {
      KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
      if (skeleton.isTracked()) {
        KJoint[] joints = skeleton.getJoints();
        /* // drw the skelotin 
        color col  = skeleton.getIndexColor();
        fill(col);
        stroke(col);
        drawBody(joints);
    
        //draw different color for each hand state
        drawHandState(joints[KinectPV2.JointType_HandRight]);
        drawHandState(joints[KinectPV2.JointType_HandLeft]);*/
        //the hand shake listener  
        if(wingT.cycle_timer(1000*second()+millis())){
          org_Leftangle = new_Leftangle;
          org_Rightangle = new_Leftangle;
          new_Leftangle = angle(joints[KinectPV2.JointType_WristLeft], joints[KinectPV2.JointType_ShoulderLeft]);
          new_Rightangle = angle(joints[KinectPV2.JointType_WristRight], joints[KinectPV2.JointType_ShoulderRight]);
        }
        pass[0]=pass[1];
        pass[1]=pass[2];
        pass[2]=wing_listener(new_Leftangle, org_Leftangle, new_Rightangle, org_Rightangle);
        chicken.shake(pass[0]||pass[1]||pass[2]);
        if(pass[0]||pass[1]||pass[2]){
          spring.update(joints[KinectPV2.JointType_SpineMid].getX(),height/2);
        }
        //handle the drop and detect the gesture 
        if(gesture_listener(joints)){
            if (random(1) < 0.05*(1+0.0001*count)) {
              float sz = random(20,25);
              //pills.add(new Pill(random(width),-20,sz));
          }
        }  
      }
    }
   // spring.update(mouseX,height/2);
    //to speed up the drop 
    count+=10;
    if (random(1) < 0.002*(1+0.0001*count)) {
      float sz = random(20,25);
      //pills.add(new Pill(random(width),-20,sz));
    }
    
 
    // step through time
    box2d.step();
    
    // update the draw 
    box_update();
    // Draw the spring
    // spring.display();
 }
}

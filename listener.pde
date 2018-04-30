boolean gesture_listener(KJoint[] joints){
  
   float scale_ref=diff(joints[KinectPV2.JointType_SpineShoulder],joints[KinectPV2.JointType_SpineBase]);
   float left_ratio=diff(joints[KinectPV2.JointType_WristLeft],joints[KinectPV2.JointType_ShoulderLeft])/scale_ref;
   float right_ratio=diff(joints[KinectPV2.JointType_WristRight],joints[KinectPV2.JointType_ShoulderRight])/scale_ref;
   if(left_ratio<=0.7 && right_ratio<=0.7)
     return true;   
   else 
     return false;
}
boolean wing_listener(float new_Leftangle, float org_Leftangle, float new_Rightangle, float org_Rightangle){
  if(abs(new_Leftangle-org_Leftangle)>0.25&&abs(new_Rightangle-org_Rightangle)>0.25)
    return true;
  else
    return false;
}
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  //handle the event while rock hit the box
  if (o1.getClass() == Box.class&&o2.getClass() == Rock.class) {;
    Rock r = (Rock) o2;
    r.delete(); 
    //score++; 
  } 
  else if (o2.getClass() == Box.class&&o1.getClass() == Rock.class) {
    Rock r = (Rock) o2;
    r.delete();
    //score++;
  }

}

void endContact(Contact cp) {
}

void startgame(){
  image(kinect.getColorImage(), 0, 0, width/5, height/5);
   background(255);
   //startT.multi_timer(1000*second()+millis(),5);
   //fill(0);
   //textSize(32);
   //if(startT.count<4&&startT.count>0)
   //text(4-startT.count,width/2,height/2);
   //if(startT.count==4){
   //  text("GO!!",width/2-30,height/2);
     
     //chicken.target_col();
   //}
   //if(startT.count==5)
   //  start =1;
   //return; 
}


float diff(KJoint joint1, KJoint joint2) {
  float distance = sqrt(pow(joint1.getX()- joint2.getX(),2)+pow(joint1.getY()- joint2.getY(),2));
   return distance;
}
class timer{
  int now_time;
  int hold_time;
  int start_time;
  int count;
  timer(int now_time_temp,int hold_time_temp){
    now_time=now_time_temp;
    hold_time=hold_time_temp;
    start_time = now_time; 
    count = 0 ;
  }
  boolean one_timer(int now_time_temp){
    now_time=now_time_temp; 
    if(now_time > hold_time+start_time)
      return true;
    else return false;
  }
  boolean multi_timer(int now_time_temp, int count_temp){
    now_time=now_time_temp;
    if(now_time > hold_time+start_time && count_temp > count )
    {
      start_time = now_time; 
      count++;
      return true;
    }
    else return false;
  }
  boolean cycle_timer(int now_time_temp){
    now_time=now_time_temp;
    if(now_time > hold_time+start_time)
    {
      count++;
      start_time = now_time; 
      return true;
    }
    else return false;
  }
}
class colorRGB{
  int R=0;
  int G=0;
  int B=0;
  colorRGB(int R_temp,int G_temp,int B_temp){
    R=int(random(255));
    G=int(random(255));
    B=int(random(255));
  }
}
float angle(KJoint joint1, KJoint joint2) {
   return atan((joint1.getY()-joint2.getY())/(joint1.getX()-joint2.getX()));
}

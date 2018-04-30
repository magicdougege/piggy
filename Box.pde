

class Box {

  // We need to keep track of a Body and a width and height
  Body body;
  float w;
  float h;
 
  float angle;
  boolean shake;
  int direction;
  // Constructor
  Box(float x_, float y_) {
    float x = x_;
    float y = y_;
    w = 120;
    h = 120;
    // Add the box to the box2d world
    makeBody(new Vec2(x, y));
    body.setUserData(this);
    angle = 0;
    direction = 1;
    
  }

  // This function removes the particle from the box2d world


  
 //shake listener 
  void shake(boolean shake_){
    shake = shake_;
  }


  // Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
   
    
    ellipseMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(0);
    strokeWeight(0);
   

    //ellipse(0,0,w,h); 

    wing_display(shake);
    
    //body
    PImage img;
    img = loadImage("1.png");
    //fill(color(255,175,0));
    //imageMode(CENTER);
    rotate(0);
    beginShape();
     image(img,-88,-90);
    endShape();

    //leg
    fill(color(255,70,0));
    ellipse(-40,60,24,24);
    ellipse(40,60,24,24);
    fill(color(255,100,0));
    ellipse(-40,60,12,12);
    ellipse(40,60,12,12);
  
    popMatrix();
    //hint_dispay();
       
  }

  void wing_display(boolean  shake){
    //smooth the motion of the wings 
    if(shake==true){
        if(direction == 1){
          angle+=0.05;
          if(angle > 0.4 )
            direction = -1;
        }
        else if(direction == -1){
          angle-=0.05;
          if(angle < -0.25 )
            direction = 1;
        }
        
    }
    //Leftwing
    pushMatrix();
    fill(color(255,70,0));
    rotate(angle);
    beginShape();
      vertex(-120, 30);
      vertex(-75, -10);
      vertex(-20, -10);  
      vertex(-30, 30);  
    endShape(CLOSE);
    fill(color(250,130,0));
    beginShape();
      vertex(-120, 30);
      vertex(-75, -00);
      vertex(0, -00);  
      vertex(-10, 30);  
    endShape(CLOSE);
    popMatrix();

    //Rightwing
    pushMatrix();
    fill(color(255,70,0));
    rotate(-1*angle);
    beginShape();
      vertex(120, 30);
      vertex(75, -10);
      vertex(20, -10);  
      vertex(30, 30);  
    endShape(CLOSE);
    fill(color(250,130,0));
    beginShape();
      vertex(120, 30);
      vertex(75, -00);
      vertex(0, -00);  
      vertex(10, 30);  
    endShape(CLOSE);
    popMatrix();
  }
  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center) {
    // Define and create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);
    // Define a polygon (this is what we use for a rectangle)
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(w/2);
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    //fd.rotation =true;
    body.createFixture(fd);

  }
}

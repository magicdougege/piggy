class Rock {

  Body body;
  float w;
  float h;
  float x;
  float y;
  boolean delete = false;
  color col;
  timer T;


  Rock(float x_, float y_) {
    // puts the particle in the Box2d world
    w = 25;
    h = 25;
    x=x_;
    y=y_;
    makeBody(x, y);
    body.setUserData(this);
    col = color(175);
   
  }
  void delete() {
    delete = true;
  }
  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Change color when hit
  void change() {
    col = color(255, 0, 0);
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+w*2 || delete) {
      killBody();
      return true;
    }
    return false;
  }


  // 
  void display() {
    //body's screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    stroke(0);
    //shape(s, 10, 10, width/6, height/6);
    fill(140,140,50);
    beginShape();
      vertex(0, -30);
      vertex(20, -20);
      vertex(26, -10); 
      vertex(27, -5); 
      vertex(0, 0);
      vertex(-27, -5);
      vertex(-26, -20);
      vertex(-20, -30);
    endShape(CLOSE);
    popMatrix();
        
  }

  // Here's our function that adds the particle to the Box2D world
  void makeBody(float x, float y) {
    // Define a body
    // Define a polygon (this is what we use for a rectangle)
    FixtureDef fd = new FixtureDef();
    PolygonShape sd = new PolygonShape();
    Vec2[] vertices = new Vec2[8];

    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(0, -30));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(20, -20));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(26, -10));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(27, -5));
    vertices[4] = box2d.vectorPixelsToWorld(new Vec2(0, -0));
    vertices[5] = box2d.vectorPixelsToWorld(new Vec2(-27, -5));
    vertices[6] = box2d.vectorPixelsToWorld(new Vec2(-26, -10));    
    vertices[7] = box2d.vectorPixelsToWorld(new Vec2(-20, -20));


    sd.set(vertices, vertices.length);

    // Define a fixture

    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));

    body = box2d.createBody(bd);
    body.createFixture(fd);
    body.setAngularVelocity(random(-5, 5));
  }
}
void box_init(){
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // Turn on collision listening!
  box2d.listenForCollisions();

  // Make the box
  chicken = new Box(width/2,height/2);

  // Make the spring (it doesn't really get initialized until the mouse is clicked)
  spring = new Spring();
  spring.bind(width/2,height/2,chicken);

  // Create the empty list
  //rocks = new ArrayList<Rock>();
 
  for(int i=0;i<3;i++)
    pass[i] = false;
}
void box_update(){

  chicken.display();

  
}

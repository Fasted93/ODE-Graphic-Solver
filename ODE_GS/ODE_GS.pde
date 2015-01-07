////
//Search [UPDATE] to find things that need to be changed
////

///Packages//

//Package used to handle mathematical functions as input strings
import net.sourceforge.jeval.*;

//Lists stuff
import java.util.Iterator;
import java.util.LinkedList;


///Globals///

//Integration parameters
float H; //integration precision
float time; //global time


//Graphical help
float CENTERX, CENTERY;
float zoom; //camera zoom

//ODE System
MathFunc F1;
MathFunc F2;

//List of all orbits
LinkedList<Orbit> OrbitList;

//Jeval evaluator
Evaluator evaluator;


///Classes///

//Mathematical function. Used for parsing input equations and evaluate them.
class MathFunc {
  String math_expression_parsed; //math expression parsed on jeval format

  //Constructor
  MathFunc(String math_expression) { //raw math expression given by the user
    math_expression_parsed = math_expression.replace("x", "#{x}").replace("t", "#{t}").replace("y", "#{y}"); //input parsing into jeval format
  }

  //Evaluator
  //Returns the evaluation of the function at a given time and point
  float result(float tvar, float xvar, float yvar) {
    
    float result = 0; //result needs to be initialized in order to be returned
    
    //Jeval storing input time and point
    //'xvar + ""' is needed in order to transform xvar into a string so Jeval can work with it
    evaluator.putVariable("x", xvar + "");
    evaluator.putVariable("y", yvar + "");
    evaluator.putVariable("t", tvar + "");
    
    //try-catch used to handle numerical EvaluationException
    try {
      result = Float.parseFloat(evaluator.evaluate(math_expression_parsed)); //Jeval at work evaluating
    }
    catch(Exception e) {
      println(e);
    }
    
    return result;
  }
}

//Orbit with a starting point
class Orbit {
  float t0, x0, y0; //starting time and point
  
  float lastX, lastY; //used with the Euler method. Needs to be re-written using pointers. [UPDATE] [EULER]
  float lastlastX, lastlastY; //same [UPDATE] [EULER]

  FloatList xhistory, yhistory; //list that contains all the points. Needs to be changed to a new point class [UPDATE] [POINTS]
  
  color orbitColor; //orbit display color
  
  float previousX, previousY; //used with display. Needs to be re-written using pointers. [UPDATE] [DISPLAY]
  
  //Constructor
  Orbit(float t0, float x0, float y0) {
    this.t0 = t0;
    this.x0 = x0;
    this.y0 = y0;
    
    xhistory = new FloatList();
    yhistory = new FloatList();
    xhistory.append(this.x0);
    yhistory.append(this.y0);
    
    lastX = this.x0;
    lastY = this.y0;
    previousX = this.x0;
    previousY = this.y0;
    
    orbitColor = color(random(255),random(255),random(255));
  } 
  
  //Display
  void display(){
    if (time - t0 < H){
    }

    previousX = x0;
    previousY = y0;
    Iterator<Float> xiter = xhistory.iterator();
    Iterator<Float> yiter = yhistory.iterator();
    while (xiter.hasNext() && yiter.hasNext()) {
      
      float newX = xiter.next();
      float newY = yiter.next();
      stroke(orbitColor);
      line(previousX + CENTERX, -previousY + CENTERY, newX + CENTERX, -newY + CENTERY);
      previousX = newX;
      previousY = newY;
    }
  }
  
  //Update (Euler)
  void next_point_euler(){
    lastlastX = lastX;
    lastlastY = lastY;
    lastX = lastX + H*F1.result(time, lastX, lastY);
    lastY = lastY + H*F2.result(time, lastX, lastY);
    xhistory.append(lastX);
    yhistory.append(lastY);
  }
  
  //Add a change_color function [UPDATE]
}


void setup() {
  zoom = 1;
  evaluator = new Evaluator();
  F1 = new MathFunc("-x + y");
  F2 = new MathFunc("-y - x");
  OrbitList = new LinkedList<Orbit>();
  H = 0.01;
  frameRate(60);
  size(500,500);
  background(255);
  time = 0;
  CENTERX = width/2;
  CENTERY = height/2;
}

void draw() {
    strokeWeight(1/zoom);
    translate(+CENTERX, +CENTERY);
    scale(zoom); 
    translate(-CENTERX, -CENTERY);
    background(255);
    Iterator<Orbit> iter = OrbitList.iterator();
    while (iter.hasNext()) {
      Orbit updateOrbit = iter.next();
      updateOrbit.next_point_euler();
      updateOrbit.display();
    }
    
    time += H;
   
}

void keyPressed() {
  if (key == 'w') {
    zoom = zoom*1.1;
    println(zoom);
  } 
  else if (key == 's') {
    zoom = zoom*0.9;
    println(zoom);
  }
}

void mouseClicked() {
  Orbit newOrbit = new Orbit(time, (mouseX - CENTERX)/zoom, (CENTERY - mouseY)/zoom);
  OrbitList.add(newOrbit);
}


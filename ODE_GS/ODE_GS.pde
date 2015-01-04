import net.sourceforge.jeval.*;
import java.util.Iterator;
import java.util.LinkedList;

//GLOBALES
float H = 0.01; //paso de integracion
float time = 0;
float CENTERX;
float CENTERY;
//Hardcoded para probar
MathFunc F1 = new MathFunc("-x + y", 'x');
MathFunc F2 = new MathFunc("-y - x", 'y');

//Orbit orbi0;
LinkedList<Orbit> OrbitList = new LinkedList<Orbit>();

Evaluator evaluator = new Evaluator();

float zoom = 1;

class MathFunc {
  String math_expression_parsed;
  char label;

  //Constructor
  //math_expresion is the explicit expression of the formula
  //label is the name of the solution (x, y)
  MathFunc(String math_expression, char label_par) {
    math_expression_parsed = math_expression.replace("x", "#{x}").replace("t", "#{t}").replace("y", "#{y}");
    label = label_par;
  }

  //Evaluator
  float result(float tvar, float xvar, float yvar) {
      
    float result = 0;
    
    evaluator.putVariable("x", xvar + "");
    evaluator.putVariable("y", yvar + "");
    evaluator.putVariable("t", tvar + "");
      
    try {
      result = Float.parseFloat(evaluator.evaluate(math_expression_parsed));
    }
    catch(Exception e) {
        println(e);
    }
      
      return result;
  }
}

class Orbit {
  int HISTORY = 10;
  float x0;
  float y0;
  float lastX;
  float lastY;
  float lastlastX;
  float lastlastY;
  float t0;
  int posHistory = 0;
  FloatList xhistory;
  FloatList yhistory;
  
  color orbitColor;
  
  float previousX, previousY;
  
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

      //line(lastlastX + CENTERX, -lastlastY + CENTERY, lastX + CENTERX, -lastY + CENTERY);
      //println("lastlastX = " + lastlastX + " lastlastY = " + lastlastY + " lastX = " + lastX + " lastY = " + lastY);
  }
  
  //Update (Euler)
  void next_point_euler(){
    //println("----");
    //println(time);
    //println(lastX);
    //println(lastY);
    lastlastX = lastX;
    lastlastY = lastY;
    lastX = lastX + H*F1.result(time, lastX, lastY);
    lastY = lastY + H*F2.result(time, lastX, lastY);
    xhistory.append(lastX);
    yhistory.append(lastY);
  }
}


void setup() {
  frameRate(60);
  size(500,500);
  background(255);
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
    zoom += 0.01;
    println(zoom);
  } 
  else if (key == 's') {
    zoom -= 0.01;
    println(zoom);
  }
}

void mouseClicked() {
  Orbit newOrbit = new Orbit(time, (mouseX - CENTERX)/zoom, (CENTERY - mouseY)/zoom);
  OrbitList.add(newOrbit);
}


import java.awt.*;
int gMouseX = 0, gMouseY = 0;
color blue = color(0, 139, 204);
void settings () {
  size(320, 140);
}
void setup() {
}
void draw() {
  background(#FC8403);
  fill(255);
  rectMode(CENTER);
  textAlign (CENTER, CENTER);
  textSize(15);
  text("Press + to add new windows\nPress ESC on the windows to hide them", width/2, height/2, width, height);
}
void keyReleased () {
  if (key == '+')
    new PWindow ("3rd window", 20, 300, 380, 140);
}
void globally () {  
  Point location = MouseInfo.getPointerInfo().getLocation();
  gMouseX = (int) location.getX();  // global mouse position along X
  gMouseY = (int) location.getY();  // global mouse position along Y
}

class PWindow extends PApplet {
  int xPos, yPos, factorX, factorY, w, h;
  String title, selected = "";
  boolean resizability = true, visibility = true;
  PWindow (String title, int w, int h) {
    super();
    setConstructorValues (title, w, h);
  }
  PWindow(String title, int x, int y, int w, int h) {
    super();
    setConstructorValues (title, x, y);
    this.w = w;
    this.h = h;
  }
  void setConstructorValues (String title, int x, int y) {
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
    xPos = x;
    yPos = y;
    this.title = title;
  }
  void setLocation (int x, int y) {
    surface.setLocation(x, y);
  }

  void settings() {
    fullScreen();
  }

  void setup() {
    surface.setSize(w, h);
    surface.setLocation (xPos, yPos);
    surface.setTitle(title);
    surface.setResizable(resizability);
    surface.setVisible(visibility);
    surface.setAlwaysOnTop(true);
  }
  void draw() {
    background(blue);
    fill(255);
    rectMode(CENTER);
    textAlign (CENTER, CENTER);
    textSize(16);
    if (selected != "")
      text(selected + "\nThen move your mouse wheel to +/-", width/2, height/2, width, height);
    else {
      textSize(14);
    }
  }
  void mousePressed() {
    factorX = mouseX;
    factorY = mouseY;
  }
  void mouseReleased () {
    if (mouseButton == LEFT)
      selected = "Press W or H to choose which to resize";
    else
      selected = "";
  }
  void mouseDragged() {
    xPos = MouseInfo.getPointerInfo().getLocation().x - factorX;
    yPos = MouseInfo.getPointerInfo().getLocation().y - factorY;
    surface.setLocation(xPos, yPos);
  }
  void mouseWheel(MouseEvent event) {
    if (selected == "")
      return;
    float wheelDirection = event.getCount();
    if (w + wheelDirection >= 140 && selected == "width") {
      w += wheelDirection*10;
    } else if (h + wheelDirection >= 140 && selected == "height") {
      h += wheelDirection*10;
    }
    surface.setSize(w, h);
  }
  void keyPressed () {
    if (key == 'w' || key == 'W')
      selected = "width";
    else if (key == 'h' || key == 'H')
      selected = "height";
    else if (keyCode == ESC) {
      key = 0;
      visibility = false;
      surface.setVisible(visibility);
    }
  }
}

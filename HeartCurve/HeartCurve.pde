// Processing Community Day Ethiopia #2019 - Debre Zeit
// February 23 - Foka STEM Center

float x, y, x2, y2, scale, t;
boolean update;
void setup() {
  fullScreen();
  scale = 20;

  background(20);
  delay(1000);

  textAlign(RIGHT, BOTTOM);
  fill(#FF0561);
  textSize(15);
  text("Processing | Math | Love.", width - 4, height - 4);
}

void draw() {
  stroke(#FF0342);
  strokeWeight(1);

  update = frameCount % 7 == 0;

  x = width*0.5 + 16*pow(sin(t), 3)*scale;
  y = height*0.5 - (13*cos(t) - 5*cos(2*t) - 2*cos(3*t)-cos(4*t))*scale;
  t -= 7;  // Mess with this decrement number 
  x2 = width*0.5 + 16*pow(sin(t), 3)*scale;
  y2 = height*0.5 - (13*cos(t) - 5*cos(2*t) - 2*cos(3*t)-cos(4*t))*scale;
  // Visit this link for more of this algorithm: http://mathworld.wolfram.com/HeartCurve.html

  strokeWeight(random(3));
  stroke(frameCount % 5 != 0? color(random(255), random(100), random(100), 200) : 20);
  line(x, y, x2, y2);

  stroke(random(255), random(100), random(10));
  strokeWeight(10);
  if (ceil(x) % 5 == 0)
    point(x, y);

  if (update)
    t += 0.005;
}
                                                                                                                                                                                                                                                                                                                                   
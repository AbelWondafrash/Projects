class VectorIcons extends Colors {
  void showBackspaceNotAllowed (float fadeFactor) {
    arrow.x = width/2;
    strokeCap(ROUND);
    noFill();  
    stroke(arrowColor, fadeFactor);
    strokeWeight(arrow.thickness);
    line(arrow.x - arrow.d*0.25, arrow.y, arrow.x + arrow.d*2.5, arrow.y);
    strokeJoin(ROUND);
    
    beginShape();
      vertex(arrow.x + cos(arrow.theta)*arrow.d, arrow.y - sin(arrow.theta)*arrow.d);
      vertex(arrow.x - arrow.d*0.25, arrow.y);
      vertex(arrow.x + cos(arrow.theta)*arrow.d, arrow.y + sin(arrow.theta)*arrow.d);
    endShape();
    
    stroke(crossColor, fadeFactor);
    strokeWeight(arrow.crossThickness);
    float x = arrow.x + (arrow.x + arrow.d*2.5 - arrow.x - arrow.d*0.25)*0.6;
    line(x - arrow.d/2, arrow.y - arrow.d/2, x + arrow.d/2, arrow.y + arrow.d/2);
    line(x - arrow.d/2, arrow.y + arrow.d/2, x + arrow.d/2, arrow.y - arrow.d/2);
    noStroke();
  }
  void showCheckMark (float X, float Y, float fadeFactor) {
    strokeCap(ROUND);
    X -= (checkMark.d*2.5 - checkMark.d*0.25)/2;
    Y += checkMark.d*sin(checkMark.theta) + checkMark.thickness*0.25;
    noFill();
    stroke(checkColor, fadeFactor);
    strokeWeight(checkMark.thickness);
    strokeJoin(ROUND);
    
    float x = X + (cos(checkMark.theta)*checkMark.d*3)/2;
  beginShape();
    vertex(x - cos(checkMark.theta)*checkMark.d,
           Y - sin(checkMark.theta)*checkMark.d);
    vertex(x - checkMark.d*0.25, Y);
    vertex(x + cos(checkMark.theta)*checkMark.d,
           Y - sin(checkMark.theta)*checkMark.d*2);
  endShape();
  
    noStroke();
  }
  void showErrLetter (float x, float y, float fontSize) {
    textSize(fontSize);
    textAlign(CENTER, CENTER);
    fill(colors.errTint, fade.errLetter);
      text(lastErrLetter, x, y);
  }
  void showErrLetter (float x, float y, float fontSize, color fontColor) {
    textSize(fontSize);
    textAlign(CENTER, CENTER);
    fill(fontColor, fade.errLetter);
      text(lastErrLetter, x, y);
  }
  void drawKey (String key, float x, float y, float d) {
    rectMode(CENTER);
    fill(240);
    stroke(colors.toBeTyped);
    strokeWeight(1);
      rect(x, y, d, d, 4);
    fill(colors.toBeTyped);
    textFont(montserrat.bold);
    textAlign(CENTER, CENTER);
    textSize(d*0.8);
      text(key, x, y - textDescent()/2);
  }
  
}
class Arrow {
  float theta = radians(60), d = 200*0.1, thickness = 10,
        crossThickness = thickness*0.5,
        x = width/2 - (width/2 + d*2.5 - width/2 - d*0.25)/2,
        y = d*sin(theta) + thickness*(0.5 + 2);
}
class CheckMark {
  float theta = radians(45), d = 200*0.06, thickness = 5,
        height = d*sin(theta) + thickness*0.25;
}
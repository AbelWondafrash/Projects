PFont raleway, ralewayMedium, museo, museo500;
float sunRad, sunX, sunY, 
  buildingMinW, buildingMinH, buildingMaxW, buildingMaxH;
color sunCol = color(254, 165, 0), backgroundCol = 233, 
  buildingCol = 20, windowCol = sunCol;
float buildingX [] = {0, 200, 280, 360, 470, 570, 610, 710, 765, 795, 890, 915, 1015, 
  1035, 1105, 1130, 1205, 1225, 1235, 1260, 1285, 1335, 1415, 1460, 1565, 1920}, 
  buildingY [] = {835, 875, 750, 975, 850, 975, 835, 950, 985, 880, 915, 790, 955, 
  890, 1000, 890, 975, 936, 920, 910, 890, 960, 890, 815, 960}, 
  buildingW [], buildingH [], windowD, gap;
int lastSecond = second();
FloatList windowsX, windowsY, fromAlphaVal, toAlphaVal;
void setup () {
  fullScreen();

  buildingW = new float [buildingX.length - 1];
  buildingH = new float [buildingY.length];

  for (int a = 0; a < buildingW.length; a ++)
    buildingW [a] = buildingX [a + 1] - buildingX [a];
  for (int a = 0; a < buildingH.length; a ++)
    buildingH [a] = buildingY [a];

  sunRad = width*0.5;
  sunX = width/2;
  sunY = height*0.92;

  windowD = rescale(7);
  gap = rescale(3);

  windowsX = new FloatList();
  windowsY = new FloatList();
  fromAlphaVal = new FloatList();
  toAlphaVal = new FloatList();

  createWindows();
  raleway = createFont("Raleway-ExtraLight.ttf", 11);
  ralewayMedium = createFont("Raleway-Medium.ttf", 11);
  museo = createFont("Museo300-Regular.otf", 11);
  museo500 = createFont("Museo500-Regular.otf", 11);
}
void draw () {
  background (backgroundCol);
  theSun();
  theBuildings();
  turnTheLightsOff();
  theCenterText();
  
}
float rescale (float val) {
  return map(val, 0, 1920, 0, width);
}
void theSun() {
  noStroke();
  fill(sunCol);
  ellipse(sunX, sunY, sunRad, sunRad);
}
void theBuildings () {
  float buildW, buildH;
  fill(buildingCol);
  for (int a = 0; a < buildingX.length - 1; a ++)
  {
    buildW = rescale(buildingW [a] + 1);
    buildH = rescale(buildingH [a]);
    rect(rescale(buildingX [a] - 1), rescale(buildingY [a]), buildW, buildH);
  }

  roofTops();
  theWindows();
}
void createWindows() {
  float startX, startY, buildW, buildH;
  int nWindowsH, nWindowsV;
  for (int a = 0; a < buildingX.length - 1; a ++)
  {
    buildW = rescale(buildingW [a] + 1);
    buildH = rescale(buildingH [a]);
    nWindowsH = int(buildW/(windowD + gap));
    nWindowsV = int(buildH/(windowD + gap));
    startX = rescale(buildingX [a] - 1) + (buildW - nWindowsH*windowD - (nWindowsH - 1)*gap)/2;
    startY = rescale(buildingY [a]) + (buildH - nWindowsV*windowD - (nWindowsV - 1)*gap)/2;
    for (int b = 0; b < nWindowsH; b ++)
      for (int c = 0; c < nWindowsV; c ++)
        if (int(random(20))%7 == 0) {
          windowsX.append(startX + b*windowD + b*gap);
          windowsY.append(startY + c*windowD + c*gap);
          fromAlphaVal.append(0);
          toAlphaVal.append(255);
        }
  }
}
void roofTops () {

  float triD = rescale(buildingW [3] + 1)*0.7, 
    triX = rescale(buildingX [3] - 1) + rescale(buildingW [3] + 1)*0.3, 
    triY = rescale(buildingY [3]);
  triangle(triX, triY + 1, 
    triX + triD/2, triY - triD, 
    triX + triD, triY + 1);

  triD = rescale(buildingW [9] + 1);
  triX = rescale(buildingX [9] - 1);
  triY = rescale(buildingY [9]);
  triangle(triX, triY + 1, 
    triX, triY - triD*0.6, 
    triX + triD, triY + 1);

  triD = rescale(buildingW [13] + 1);
  triX = rescale(buildingX [13] - 1) + triD*0.6;
  triY = rescale(buildingY [13]);
  triangle(triX - triD*0.04, triY + 1, 
    triX, triY - triD*1.5, 
    triX + triD*0.04, triY + 1);

  triD = rescale(buildingW [22] + 1)*1.2;
  triX = rescale(buildingX [22] - 1) + triD*0.5;
  triY = rescale(buildingY [22]);
  ellipse(triX, triY, triD, triD);
  triY -= triD*0.5;
  triangle(triX - triD*0.04, triY + 1, 
    triX, triY - triD*1.5, 
    triX + triD*0.04, triY + 1);

  triD = rescale(buildingW [6] + 1)*0.8;
  triX = rescale(buildingX [6] - 1) + rescale(buildingW [6] + 1)/2;
  triY = rescale(buildingY [6]);
  ellipse(triX, triY + triD*0.1, triD, triD*0.9);
  triY -= triD*0.3;
  triangle(triX - triD*0.04, triY + 1, 
    triX, triY - triD*1.5, 
    triX + triD*0.04, triY + 1);
}
void theWindows () {
  for (int a = 0; a < windowsX.size(); a ++)
  {
    fill(windowCol, fromAlphaVal.get(a));
    rect(windowsX.get(a), windowsY.get(a), windowD, windowD);
  }
}
void turnTheLightsOff () {
  if (lastSecond != second())
  {
    for (int a = 0; a < 20; a ++)
    {
      if (windowsX.size() > 0)
      {
        int index = int(random(windowsX.size() - 1));
        toAlphaVal.set(index, 0);
        toAlphaVal.set(index, 0);
      }
    }
    if (windowsX.size() == 0)
      createWindows();  
    lastSecond = second();
  }
  for (int a = 0; a < fromAlphaVal.size(); a ++)
    fromAlphaVal.set(a, gradualChange(fromAlphaVal.get(a), toAlphaVal.get(a), 16));
}
void theCenterText() {
  float nowYPos = height*0.08;
  fill(0);
  textFont(raleway);
  textSize(width*0.045);
  textAlign(CENTER, CENTER);
  text("We're enrolling", width/2, nowYPos);
  nowYPos += textAscent() + textDescent();
  textFont(ralewayMedium);
  textSize(width*0.042);
  text("SUPERHEROES", width/2, nowYPos);
  nowYPos += textAscent()*0.8;
  float nextW = textWidth("SUPERHEROES")*0.95;
  textAlign(CENTER, TOP);
  String textToDisplay = "for membership";
  float gap = nextW/(textToDisplay.length() - 1);
  textSize(width*0.014);
  for (int a = 0; a < textToDisplay.length(); a ++)
    text(textToDisplay.charAt(a), width/2 - nextW/2 + a*gap, nowYPos);
  nowYPos += textAscent() + textDescent() + rescale(25);
  nextW /= 0.95;
  strokeWeight(1);
  stroke(195);
  line(width/2 - nextW/2, nowYPos, width/2 + nextW/2, nowYPos);
  textFont(museo);
  textSize(width*0.016);
  fill(150);
  nowYPos += textAscent()*0.8;
  text("As ---- programmers, graphics artists and UI/UX designers, soft/hard-ware analysts, hardware geeks, typists and many more.", 
    width/2 - nextW/2, nowYPos, nextW, 3*3*(textAscent() + textDescent())/2);
  nowYPos += 3*3*(textAscent() + textDescent())/2;

  textAlign(CENTER, CENTER);
  textFont(museo500);
  textSize(width*0.016);
  fill(175);
  textToDisplay = "Claim your membership today!";
  text(textToDisplay, width/2, nowYPos - textDescent()/2);
  line(width/2 - nextW/2, nowYPos, 
    width/2 - textWidth(textToDisplay)*1.05/2, nowYPos);
  line(width/2 + nextW/2, nowYPos, 
    width/2 + textWidth(textToDisplay)*1.05/2, nowYPos);
}
float gradualChange(float from, float to, float factor)
{
  if (from < to)  // Check to see if the value of "from" is less than "to"'s
    from += dist(from, 0, to, 0)/factor;  // Increase the value of "from"
  // by a factor of dist(....)/factor
  else if (from > to)  // Check to see if the value of "from" is greater than "to"'s
    from -= dist(from, 0, to, 0)/factor;  // Decrease the value of "from"
  // by a factor of dist(....)/factor
  return from;  // Finally, return the value of from so it can be used by where it's
  // called.
}
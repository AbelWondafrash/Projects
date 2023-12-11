float totalNumber = 1, number = 0, gap, h, w, tempNumber = 0, 
  stX [], 
  stY, stRemain, vert, tempTotalNumber, 
  hori [], stCounter, 
  posX_ [], posY_ [], startWidth, startHeight;
;
int horMax = 4, pages = 0, currentPage = 1, now = -50,
    perPage = 12;
boolean fade = true, disperse = true, dispersing = true,
        LeftLimitReached = true,
        RightLimitReached = false,
        LeftAtLeftLimitReach = false,
        RightAtRightLimitReach = false;
String direction = "None";

color colorList [] = {#F7D7D7, #FFFFFF, #FF0044};
int divisionFactor [] = {12, 60, 60}, time [];
float lineThickness [] = {1.8, 1.2, 1}, stickLength [], brighten = 255, bLimit = 0,
clockFade = 15, toClockFade = 0, toXDegree [] [], toYDegree [] [], fromXD [] [], fromYD [] [];
StringList clocks;
void setup()
{
  surface.setResizable(false);
  surface.setSize(int(displayWidth*0.8), int(displayHeight*0.8));
  surface.setLocation (int (displayWidth - width)/2, int (displayHeight - height)/2);
  
  clocks = new StringList();
  clocks.append(0 + ":" + 0 + ":" + 0);
  
  totalNumber = clocks.size();
  setThings();
}
void setDimensions()
{
  stickLength = new float [3];
  stickLength [0] = displayWidth*0.2*0.35/2;
  stickLength [1] = displayWidth*0.2*0.55/2;
  stickLength [2] = displayWidth*0.2*0.75/2;
}
void showTime(int tm [], int posX, int posY, int which)
{
  tm [0] += hour();  tm [1] += minute();  tm [2] += second();
  noStroke();
  fill(255, clockFade);
  ellipseMode(CENTER);
  ellipse(posX, posY, stickLength [2]*1.2*2, stickLength [2]*1.2*2);
  strokeCap(PROJECT);
  stroke(#CECECE);
  int a = 0, b = 0;
  for(a = 0; a <= 360 || b <= bLimit; a += 30, b += 6)
  {
    strokeWeight((a % 90 == 0)? 2.5 : 1.4);
      point(posX + stickLength [2]*1.2*cos(radians(a)), posY + stickLength [2]*1.2*sin(radians(a)));
    strokeWeight((b % 90 == 0)? 2 : 0.75);
      point(posX + stickLength [2]*1.2*cos(radians(b)), posY + stickLength [2]*1.2*sin(radians(b)));
  }
  for(int c = 0; c < 3; c ++)
  {
    float degree = 360*tm [c]/divisionFactor [c] - 90;
    toXDegree [c] [which] = stickLength [c]*cos(radians(degree));
    toYDegree [c] [which] = stickLength [c]*sin(radians(degree));
    strokeWeight(lineThickness [c]);
    stroke(colorList [c]);
    line(posX, posY, posX + fromXD [c] [which], posY + fromYD [c] [which]);
    if(fromXD [c] [which] < toXDegree [c] [which])
      fromXD [c] [which] += dist(fromXD [c] [which] , 0, toXDegree  [c] [which], 0)/25;
    if(fromXD [c] [which]  > toXDegree [c] [which])
      fromXD [c] [which]  -= dist(fromXD [c] [which], 0, toXDegree  [c] [which], 0)/25;
    if(fromYD [c] [which] < toYDegree [c] [which])
      fromYD [c] [which] += dist(fromYD [c] [which], 0, toYDegree  [c] [which], 0)/64;
    if(fromYD [c] [which] > toYDegree [c] [which])
      fromYD [c] [which] -= dist(fromYD [c] [which], 0, toYDegree  [c] [which], 0)/64;
  }
  if(brighten > 0.01)
  {
    brighten -= dist(brighten, 0, 0, 0)/25;
    noStroke();
    fill(0, brighten);
    rect(0, 0, width, height);
  }
  if(bLimit < 360)
    bLimit += 4;
  if(clockFade < toClockFade)
    clockFade += dist(clockFade, 0, toClockFade, 0)/8;
  if(clockFade > toClockFade)
    clockFade -= dist(clockFade, 0, toClockFade, 0)/25;
}
void setThings()
{
  setDimensions();
  
  toXDegree = new float [3] [int(totalNumber)];
  toYDegree = new float [3] [int(totalNumber)];
  
  fromXD = new float [3] [int(totalNumber)];
  fromYD = new float [3] [int(totalNumber)];
  
  for(int  a = 0; a < totalNumber; a ++)
  {
    fromXD [0] [a] = stickLength [0]*cos(radians(30));
    fromYD [0] [a] = stickLength [0]*sin(radians(30));
      fromXD [1] [a] = stickLength [0]*cos(radians(270));
      fromYD [1] [a] = stickLength [0]*sin(radians(270));
    fromXD [2] [a] = stickLength [0]*cos(radians(270));
    fromYD [2] [a] = stickLength [0]*sin(radians(270));
      toXDegree [0] [a] = 0;  toYDegree [0] [a] = 0;
      toXDegree [1] [a] = 0;  toYDegree [1] [a] = 0;
      toXDegree [2] [a] = 0;  toYDegree [2] [a] = 0;
  }
  
  tempTotalNumber = totalNumber;
  fade = true; disperse = true; dispersing = true;
        LeftLimitReached = true;
        RightLimitReached = false;
        LeftAtLeftLimitReach = false;
        RightAtRightLimitReach = false;
  horMax = 3; pages = 0; now = -50;
  perPage = 6;
  number = 0;
  tempNumber = 0;
  stX = new float [int(totalNumber)];
  hori = new float [int(totalNumber)];
  posX_ = new float [int(totalNumber)];
  posY_ = new float [int(totalNumber)];
  if (totalNumber <= perPage)
  {
    pages ++;
    number = totalNumber;
    RightLimitReached = false;
  } else
  {
    while (tempTotalNumber - perPage > 0)
    {
      pages ++;
      tempTotalNumber -= perPage;
    }
    if (totalNumber%number != 0)
    {
      pages ++;
    }
    number = perPage;
  }
  tempNumber = number;
  h = displayWidth*0.2*0.7/2;
  w = h;
  gap = h*1.8;
  startWidth = width/2;
  startHeight = height/2;
  stCounter = 0;
  initialize();
  organize();
}
void initialize()
{
  for (int a = 0; a < totalNumber; a ++)
  {
    posX_ [a] = startWidth;
    posY_ [a] = startHeight;
  }
}
void organize()
{
  if (number <= horMax)
  {
    hori [int(stCounter)] = number;
    stCounter ++;
  } else
  {
    while (tempNumber - horMax >= 0)
    {
      hori [int(stCounter)] = horMax;
      stCounter ++;
      tempNumber -= horMax;
    }
    if (tempNumber != 0)
    {
      hori [int(stCounter)] = number%horMax;
      stCounter ++;
    }
  }
  vert = stCounter;
  for (int a = 0; a < vert && number != 1; a ++)
  {
    stX [a] = (width - w*hori [a] - (hori [a] - 1)*gap)/2;
  }
  for (int a = 0; a < vert && number == 1; a ++)
  {
    stX [a] = (width - w*hori [a] - (hori [a] - 1)*gap)/2;
  }
  stY = (height - vert*h - (vert - 1)*gap)/2;
}
void draw()
{
  background(0);
  int countWhich = 0;
  int count = 0;
  for (int b = 0; b < vert; b ++)
  {
    for (int a = 0; a < hori [b]; a ++)
    {
      float x_ = stX [b] + a*gap + a*w, 
        y_ = stY + b*gap + b*h, 
        realX = x_, realY = y_;
  if(countWhich + perPage*(currentPage - 1) < totalNumber)
  {
          
      if (disperse == true)
      {
        if (posX_ [countWhich + perPage*(currentPage - 1)] < realX - 1)
        {
          posX_ [countWhich + perPage*(currentPage - 1)] += dist(realX, 0, posX_ [countWhich + perPage*(currentPage - 1)], 0)/15 + 1;
        } else if (posX_ [countWhich + perPage*(currentPage - 1)] > realX + 1)
        {
          posX_ [countWhich + perPage*(currentPage - 1)] -= dist(realX, 0, posX_ [countWhich + perPage*(currentPage - 1)], 0)/15 + 1;
        }
        if (posY_ [countWhich + perPage*(currentPage - 1)] < realY - 1)
        {
          posY_ [countWhich + perPage*(currentPage - 1)] += dist(realY, 0, posY_ [countWhich + perPage*(currentPage - 1)], 0)/15 + 1;
        } else if (posY_ [countWhich + perPage*(currentPage - 1)] > realY + 1)
        {
          posY_ [countWhich + perPage*(currentPage - 1)] -= dist(realY, 0, posY_ [countWhich + perPage*(currentPage - 1)], 0)/15 + 1;
        }
        dispersing = true;
      } else
      {
        if (posX_ [countWhich + perPage*(currentPage - 1)] < startWidth)
        {
          posX_ [countWhich + perPage*(currentPage - 1)] += dist(posX_ [countWhich + perPage*(currentPage - 1)], 0, startWidth, 0)/15 + 1;
        } else if (posX_ [countWhich + perPage*(currentPage - 1)] > startWidth)
        {
          posX_ [countWhich + perPage*(currentPage - 1)] -= dist(posX_ [countWhich + perPage*(currentPage - 1)], 0, startWidth, 0)/15 + 1;
        }
        if (posY_ [countWhich + perPage*(currentPage - 1)] < startHeight)
        {
          posY_ [countWhich + perPage*(currentPage - 1)] += dist(posY_ [countWhich + perPage*(currentPage - 1)], 0, startHeight, 0)/15 + 1;
        } else if (posY_ [countWhich + perPage*(currentPage - 1)] > startHeight)
        {
          posY_ [countWhich + perPage*(currentPage - 1)] -= dist(posY_ [countWhich + perPage*(currentPage - 1)], 0, startHeight, 0)/15 + 1;
        }
        dispersing = false;
      }
      x_ = posX_ [countWhich + perPage*(currentPage - 1)];
      y_ = posY_ [countWhich + perPage*(currentPage - 1)];
      countWhich ++;
      setDimensions();
      String Stime [] = new String [3], t = clocks.get(count);
      time = new int [3];
      Stime = split (t, ":");
      for(int g = 0; g < 3; g ++)
        time [g] = int(Stime [g]);
      showTime(time, int(x_ + w/2), int(y_ + h/2), count);
      count ++;
      }    
    }
  }
  if (now == frameCount - 30)
  {
    disperse = true;
    if(direction == "Left")
    {
      currentPage --;
      goLeft();
    }
    else if(direction == "Right" && currentPage < pages)
    {
      currentPage ++;
      goRight();
    }
      direction = "None";
  }
  if(pages == 1)
  {
    LeftLimitReached = true;
    RightLimitReached = true;
  }
  else
  {
    if(currentPage + 1 > pages)
    {
      RightLimitReached = true;
    }
    else if(currentPage - 1 < 0)
    {
      LeftLimitReached = true;
    }
  }
}
void keyPressed()
{
  if (keyCode == LEFT)
  {
    if (currentPage > 1 && dispersing == true)
    {
      goLeft();
      disperse = false;
      now = frameCount;
      direction = "Left";
      brighten = 255;
    }
    else
    {
      LeftAtLeftLimitReach = true;
    }
  } else if (keyCode == RIGHT)
  {
    if (currentPage < pages && dispersing == true)
    {
      goRight();
      disperse = false;
      now = frameCount;
      direction = "Right";
      brighten = 255;
    }
    else
    {
      RightAtRightLimitReach = true;
    }
  }
  else if(key == '+')
  {
    clocks.append(random(0, 24) + ":" + random(0, 60) + ":" + random(0, 60));
    totalNumber = clocks.size();
    setThings();
    brighten = 255;
  }
  else if(key == '-' && clocks.size() > 1)
  {
    brighten = 255;
    clocks.remove(clocks.size() - 1);
    totalNumber = clocks.size();
    setThings();
  }
}
void goRight()
{
  stCounter = 0;
  if (currentPage != pages)
  {
    number = perPage;
  } else
  {
    number = totalNumber - perPage*(pages - 1);
  }
  tempNumber = number;
  organize();
}
void goLeft()
{
  stCounter = 0;
  number = perPage;
  tempNumber = number;
  organize();
}

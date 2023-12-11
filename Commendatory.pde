class Commendatory {
  String title = "Introducing a new key",
         commendation = "Great Job!",
         beforeKeys = "Next, we'll practice typing",
         underKeys = "Take your time to make sure you grasped these keys.",
         callToAction = "Press [space bar] when ready.",
         key1 = "j", key2 = "k";

  void commend (float fontSize) {
    textSize(fontSize*0.9);
  float oneCharWidth = textWidth("  "), posY = height*0.4,
        eachHeight = (textAscent() + textDescent())*1.3,
        eachWidth = oneCharWidth*2.6;
    cursor.thickness = eachHeight*0.05;  cursor.width = eachWidth;

    float leftMost = width*0.25;
    textAlign(LEFT, CENTER);
    fill(colors.gray);
      text(commendatory.commendation, leftMost, posY);

    textAlign(LEFT, BOTTOM);
    textSize(fontSize*0.25);
      text(commendatory.title, leftMost, posY - eachHeight/2);

    textAlign(LEFT, CENTER);
    textSize(fontSize*0.4);
    text(commendatory.beforeKeys, leftMost, posY + eachHeight/2 + cursor.thickness*2);
    float leftMostOriginal = leftMost;
    leftMost += textWidth(commendatory.beforeKeys) + cursor.thickness*2;
    float smallKeyDimension = eachWidth*0.4, meanX = leftMost;
    alert.drawKey(commendatory.key1, leftMost + smallKeyDimension/2,
                       posY + eachHeight/2 + cursor.thickness*2, smallKeyDimension);
    leftMost += (smallKeyDimension/2)*2 + smallKeyDimension;
    alert.drawKey(commendatory.key2, leftMost + smallKeyDimension/2,
                       posY + eachHeight/2 + cursor.thickness*2, smallKeyDimension);
    meanX = (meanX + leftMost + smallKeyDimension)/2;
    leftMost = meanX + (smallKeyDimension/2)*2 + smallKeyDimension/2 + cursor.thickness;
    
    textFont(sansPro.light);
    textAlign(CENTER, CENTER);
    textSize(fontSize*0.4);
    fill(colors.gray);
      text("&", meanX, posY + eachHeight/2 + cursor.thickness*2);
    textAlign(LEFT, CENTER);
      text(".", leftMost, posY + eachHeight/2 + cursor.thickness*2);
    
    textAlign(LEFT, TOP);
    rectMode(CORNER);
    textSize(fontSize*0.4);
    text(commendatory.underKeys,
          leftMostOriginal ,
          posY + eachHeight/2 + cursor.thickness*2 + smallKeyDimension*0.7,
          width - leftMostOriginal - smallKeyDimension*2, smallKeyDimension*4);
    
    textFont(sansPro.regular);
    textSize(fontSize*0.4);
    fill(colors.gray);
    text(commendatory.callToAction,
         leftMostOriginal ,
         posY + eachHeight/2 + cursor.thickness*2 + smallKeyDimension*4);
  }
}
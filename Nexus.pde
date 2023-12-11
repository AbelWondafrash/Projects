void setup () {
  size(380, 140);
  surface.setResizable(true);
  surface.setLocation(0, 0);

  wordsToType = new WordsToType ();
  convert = new StringConversion ();
  colors = new Colors ();
  str = new Str ();
  permissionTo = new Permission ();
  similarity = new Similarity ();
  cursor = new Cursor ();
  path = new Path ();
  consola = new Consola ();
  sansPro = new SansPro ();
  montserrat = new Montserrat ();
  window = new Window ();
  tool = new Tools ();
  right = new Rightness ();
  fade = new Fade ();
  error = new Errors ();
  errorMessage = new ErrorMessages ();
  stage = new Stage ();
  stage.loadGuideline();
  exerciseWords = new StringList();
  introduction = new Introduction ();
  percentage = new Percentage();
  assessment = new Assessment ();
  
  surface.setSize(int(window.originalWidth), int(window.originalHeight));
  home = new HomeAnimation ();
  commendatory = new Commendatory();
  exercise = new Exercise ();
  training = new Training ();
  arrow = new Arrow ();
  checkMark = new CheckMark ();
  alert = new VectorIcons ();
  
  stage.loadStageFile ();
  stage.loadLevel ();
  
  str.updateWordsToType ();
  
  cursor.thickness = 2;
  window.putOnCenter();
  percentage.y1 = height*0.8;
  percentage.y2 = height*0.8;
  introduction.posY = height*0.8;
  introduction.toPosY = height*0.4;

  textFont(consola.regular);
}
void draw () {
  background(colors.background);
  if(stage.isHome()) {
    homeUI();
  }
  if(stage.isIntroduction()) {
    introductionUI();
  }
  else if(stage.isTraining()) {
    trainingUI();
  }
  else if(stage.isExercise()) {
    exerciseUI();
  }
  if(keyToHold != "")
    fade.mustHoldKey();
  fade.entireScreen();
}
void homeUI () {
  home.animate();
  if(home.buttonClicked) {
    if(dist(fade.background, 0, fade.toBackground, 0) < 100) {
      stage.nextLevel();
      str.updateWordsToType ();
    }
  }
}
void introductionUI () {
  textFont(montserrat.bold);
  float fontSize = height*0.12, borderThickness = 1, edgeCurve = 4;
    textSize(fontSize);
  float oneCharWidth = textWidth("  "), posX = width*0.5,
        eachHeight = (textAscent() + textDescent())*1.3,
        eachWidth = oneCharWidth*2.6, newXPos = 0,
        displayW = eachWidth*str.toBeTyped.length();
    cursor.thickness = eachHeight*0.05;  cursor.width = eachWidth;
  introduction.adjustPosition();
    if(!stage.endOfIntroduction()) {
      rectMode(CORNER);
      textAlign(CENTER, CENTER);
      
      noStroke();
      fade.animateTemporaryErr();
      if(dist(fade.temporaryErr, 0, fade.toTemporaryErr, 0) < fade.tolerateFactor)
        newXPos = tool.gradualChange(posX, posX + fade.temporaryErrShiftSign*(
                  map(fade.temporaryErr, 0, fade.temporaryErrBrightest, 0, cursor.thickness)), 2);
      else
        newXPos = posX + fade.temporaryErrShiftSign*(- cursor.thickness +
          map(fade.temporaryErr, 0, fade.temporaryErrBrightest, 0, cursor.thickness));
  
      for(int a = 0; a < rightness.size(); a ++) {
        if(fade.temporaryErr < fade.tolerateFactor)
          if(fade.temporaryErrCounter < fade.temporaryNumberOfShakes) {
            fade.temporaryErrCounter ++;
            fade.temporaryErrShiftSign *= -1;
            fade.temporaryErr = fade.temporaryErrBrightest;
          }
          else
            rightness.set(a, right.UNKNOWN);
            
        if(rightness.get(a).equals(right.WRONG)) {
          fill(colors.wrongTint, 255 - map(fade.temporaryErrCounter, 0, fade.temporaryNumberOfShakes,
                                                        0, 50));
        }
        else if(rightness.get(a).equals(right.UNKNOWN))
          fill(colors.unknownTint, 0);
        else
          noFill();
        rect(newXPos, introduction.posY - eachHeight/2, eachWidth, eachHeight, edgeCurve);
      }
     
      strokeWeight(borderThickness);
      stroke(colors.border, 140);
          
      noFill();
      rect(newXPos, introduction.posY - eachHeight/2, eachWidth, eachHeight, edgeCurve);
      fill(colors.keyToPress);
        text(str.toBeTyped.charAt(0), newXPos + eachWidth/2, introduction.posY - textDescent());
      textFont(sansPro.light);
      textSize(fontSize*0.9);
      textAlign(RIGHT, CENTER);
      fill(colors.gray);
        text("Type the", posX - cursor.thickness*2, introduction.posY);
      float leftMost = posX - cursor.thickness*2 - textWidth("Type the");
      textAlign(LEFT, CENTER);
        text("key", posX + eachWidth + cursor.thickness*2, introduction.posY);
      textAlign(LEFT, BOTTOM);
      textSize(fontSize*0.3);
        text("Introducing a new key", leftMost, introduction.posY - eachHeight/2);
      if(stage.sideNote.length() > 0) {
        textAlign(LEFT, TOP);
        textSize(fontSize*0.4);
        text(stage.sideNote, leftMost, introduction.posY + eachHeight/2 + cursor.thickness*2);
      }
    }
    else {
      textFont(sansPro.light);
      
        commendatory.title = "Introducing a new key";
        commendatory.commendation = "Great Job!";
        commendatory.beforeKeys = "Next, we'll practice typing";
        commendatory.underKeys = "Take your time to make sure you grasped these keys.";
        commendatory.callToAction = "Press [space bar] when ready.";
        commendatory.key1 = "j"; commendatory.key2 = "k";
        
        commendatory.commend(fontSize);
    }
    
    if(typingCompleted ()) {
      stage.nextLevel();
      str.updateWordsToType ();
    }
    else
      fade.animateArrow();
}
void trainingUI () {
  textFont(consola.regular);
  float fontSize = height*0.12, borderThickness = 1, edgeCurve = 4, posX;
    textSize(fontSize);
    float oneCharWidth = textWidth(" "), eachWidth = oneCharWidth*2.2,
          eachHeight = (textAscent() + textDescent())*1.2, gap = eachHeight/4.5,
          displayW = eachWidth*str.toBeTyped.length() + gap*(str.toBeTyped.length() - 1);
    posX = (width - gap*(str.toBeTyped.length() - 1) - 
                    eachWidth*str.toBeTyped.length())/2;
    cursor.thickness = eachHeight*0.05;  cursor.width = eachWidth;
    cursor.toX = posX + eachWidth*str.beingTyped.length() + cursor.width/2 +
               gap*str.beingTyped.length();
    cursor.y = training.posY + eachHeight + cursor.thickness;

    training.scrollWhenNecessary();
    rectMode(CORNER);
    textAlign(CENTER, CENTER);
    noStroke();
    for(int a = 0; a < rightness.size(); a ++) {
      if(right.correctness(a) == colors.correctTint)
        alert.showCheckMark(posX + eachWidth*a + gap*a + eachWidth/2,
                            training.posY - cursor.thickness*2 - checkMark.height, 255);
      fill(right.correctness(a), alpha(right.correctness(a)));
      rect(posX + eachWidth*a + gap*a, training.posY, eachWidth, eachHeight, edgeCurve);
    }
    strokeWeight(borderThickness);
    stroke(colors.border, 140);
    for(int a = 0; a < str.toBeTyped.length(); a ++) {
      noFill();
        rect(posX + eachWidth*a + gap*a, training.posY, eachWidth, eachHeight, edgeCurve);
      fill(colors.toBeTyped);
        text(str.toBeTyped.charAt(a), posX + eachWidth*a + gap*a + eachWidth/2,
             training.posY + eachHeight/2 - textDescent());
    }
    if(typingCompleted ()) {
        training.toPosY = - eachHeight;
        if(dist(training.toPosY, 0, training.posY, 0) < window.toleratePixelChange) {
          stage.nextLevel();
          str.updateWordsToType ();
          training.posY = height*0.6;
        }
    }
    
   
  noStroke();
  rectMode(CORNER);
  fill(colors.background);
    rect(0, training.toPosY + eachHeight*2.5, width, height - training.toPosY);
    rect(0, 0, width, eachHeight*0.4);

  stroke(colors.cursor);
  strokeWeight(1);
  rectMode(CENTER);
    int stages = stage.stage.length;
    float rad = eachHeight*0.2, startX,
          startY = height*0.5 + eachHeight*0.5, radGap = rad*0.5;
    startX = (width - rad*stages - radGap*(stages - 1))/2;
    for(int a = 0; a < stages; a ++) {
      if(a < stage.levelCounter)
        fill(colors.cursor);
      else if(a == stage.levelCounter)
        fill(colors.cursor, percentage.completion()*255/100);
      else
        noFill();
      rect(startX + rad*a + radGap*a + rad/2, startY + rad/2, rad, rad,
           stage.levelCounter == a? -edgeCurve : edgeCurve);
    }
  if(!typingCompleted()) {
    training.toPosY = height*0.2;
    cursor.show();
    fade.animateArrow();
    fade.animateErrLetter(cursor.x, training.posY + eachHeight*1.5, fontSize);
  }
}
void exerciseUI () {
  textFont(consola.regular);
  float fontSize = height*0.065, edgeCurve = 4, borderThickness = 1;
    textSize(fontSize);

  float oneCharWidth = textWidth(" "), eachWidth = oneCharWidth,
          posX = height*0.12, toPosY = height*0.2,
          eachHeight = (textAscent() + textDescent())*1.2,
          allowedWidth = width - posX*2,
          allowedHeight = eachHeight*exercise.displayableVerticalLines,
          gapY = allowedHeight*0.05, actualWidthFactor = 0.9,
          gapX = 0, originalPosY = toPosY;
  String eachLineStrings;
  allowedHeight = allowedHeight + (exerciseWords.size() - 1)*gapY;
  exerciseWords = convert.stringToOrganizedList(join(stage.stage, " "),
                  allowedWidth, consola.regular, fontSize);
  cursor.thickness = eachHeight*0.05;  cursor.width = eachWidth*actualWidthFactor;
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  fill(colors.gray);
  noStroke();
  int index = 0;
  exercise.scrollWhenNecessary();
  if(exerciseWords.size() > exercise.displayableVerticalLines - 1)
    exercise.toPosY = originalPosY - eachHeight*exercise.pullFactor;
  else
    exercise.toPosY = originalPosY;

  for(int a = 0; a < exerciseWords.size(); a ++) {
    eachLineStrings = exerciseWords.get(a);
    for(int b = 0; b < eachLineStrings.length(); b ++) {
      fill(right.correctness(index), alpha(right.correctness(index)));
      if(index == str.beingTyped.length()) {
        cursor.toX = posX + eachWidth*b + gapX*b + eachWidth/2;
        cursor.y = exercise.posY + eachHeight*a + gapY*a + eachHeight;
        exercise.pullFactor = exerciseWords.size() - ceil((originalPosY - eachHeight*a + gapY*a)/eachHeight);
      }

      rect(posX + eachWidth*b + gapX*b + eachWidth/2,
           exercise.posY + eachHeight*a + gapY*a + eachHeight/2,
           eachWidth*actualWidthFactor, eachHeight,
           edgeCurve);
      fill(colors.toBeTyped);
      text(eachLineStrings.charAt(b),
        posX + eachWidth*b + gapX*b + eachWidth*0.5,
        exercise.posY + eachHeight*a + gapY*a + eachHeight/2 - textDescent());
      index ++;
    }
  }

  fill(colors.wrongText, fade.errLetter);
  rect(cursor.toX - eachWidth, cursor.y - eachHeight/2,
       eachWidth*actualWidthFactor, eachHeight, edgeCurve);
  fade.animateErrLetter(cursor.toX - eachWidth, cursor.y - eachHeight/2 - textDescent(), fontSize, 255);

  rectMode(CORNER);

  noStroke();
  fill(colors.background);
    rect(0, 0, width, originalPosY + 1);
    rect(0, originalPosY + allowedHeight, 
         width, height - originalPosY - allowedHeight);
    rect(0, originalPosY - 1, (width - allowedWidth)/2, allowedHeight + 2);
    rect(width - (width - allowedWidth)/2, originalPosY - 1,
        (width - allowedWidth)/2, allowedHeight + 2);
         
  strokeCap(ROUND);
  if(!typingCompleted ()) {
    percentage.toX1 = (width - allowedWidth)/2;
    percentage.toY1 = originalPosY + allowedHeight + percentage.thickness*2;
    percentage.toX2 = width - percentage.toX1;
    percentage.toY2 = percentage.toY1;
    
    percentage.toWidth = allowedWidth;
  }
  
  if(assessment.ticking) {
    percentage.showAccuracy();
    percentage.showWPM();
  }
  if(typingCompleted ()) {
    assessment.endClock();
    if(proceedToNextLevel) {
      percentage.toY1 = height + percentage.thickness;
      percentage.toY2 = height + height*0.7;
      if(dist(percentage.y1, 0, height + percentage.thickness, 0) < 4) { 
        stage.nextLevel();
        str.updateWordsToType ();
        proceedToNextLevel = false;
        fade.background = fade.backgroundBrightest;
        fade.toBackground = 0;
      }
      else
      {
        introduction.adjustTransitionFactor = percentage.transitionFactor;
        introduction.posY = 0;
        introduction.toPosY = height*0.4;
      }
    }
    else
    {
      percentage.toX1 = width/2;
      percentage.toY1 = -percentage.thickness;
      percentage.toX2 = width/2;
      percentage.toY2 = height*0.7;
      percentage.transitionFactor = 8;
      
      percentage.toWidth = 0;
    }
    rectMode(CORNER);
    noStroke();
    float mappedAlpha = map(dist(percentage.toX1, 0, percentage.x2,0),
                                0, allowedWidth, 0, 255);
    fill(colors.background, 255 - mappedAlpha);
    rect(0, 0, width, height);
    
    
    mappedAlpha = map(dist(percentage.toX1, 0, percentage.x2,0),
                                0, allowedWidth, 0, colors.grayAlpha);
    rectMode(CENTER);
    fill(colors.gray, colors.grayAlpha - mappedAlpha);
    textFont(montserrat.bold);
    textSize(allowedWidth*0.16);
    textAlign(CENTER, CENTER);
      text(str(assessment.grossWPM()), percentage.x1 - width/4, percentage.y2 - height*0.3,
                 width/2, height*0.6);
      text(str(assessment.realAccuracy()), percentage.x2 + width/4, percentage.y2 - height*0.3,
                 width/2, height*0.6);
    float tWidthLeft = textWidth(str(assessment.grossWPM())) + percentage.thickness*4,
          leftMost = percentage.x1 - width/4, tWidthRight,
          tPrev = textDescent() + textAscent() + percentage.thickness*2;
     
    fill(colors.gray, 120);
    rectMode(CORNER);
    textAlign(RIGHT, BOTTOM);
    textSize(allowedHeight*0.1);
      text("WPM",  width/4 + tWidthLeft/2, percentage.y2 - height*0.3 + tPrev/2);
    leftMost = percentage.x2 + width/4;
    stroke(colors.gray, 100);
    strokeWeight(1);
      line(width/4 - tWidthLeft/2, percentage.y2 - height*0.3 + tPrev/2,
           width/4 + tWidthLeft/2, percentage.y2 - height*0.3 + tPrev/2);
    
    textSize(allowedWidth*0.16);
    tWidthRight = textWidth(str(assessment.realAccuracy())) + percentage.thickness*4;
    textAlign(RIGHT, BOTTOM);
    textSize(allowedHeight*0.1);
    text("PERCENT",  percentage.x2 + width/4 + tWidthRight/2, percentage.y2 - height*0.3 + tPrev/2);
      line(width*3/4 - tWidthRight/2, percentage.y2 - height*0.3 + tPrev/2,
           width*3/4 + tWidthRight/2, percentage.y2 - height*0.3 + tPrev/2);
    tPrev += percentage.thickness;
    textFont(sansPro.light);
    textAlign(LEFT, TOP);
    fill(colors.cursor);
    textSize(allowedHeight*0.2);
      text("Accuracy", width*3/4 - tWidthRight/2, percentage.y2 - height*0.3 + tPrev/2);

    textSize(allowedHeight*0.2);
      text("Speed", width/4 - tWidthLeft/2, percentage.y2 - height*0.3 + tPrev/2);
    
    textFont(sansPro.regular);
    textAlign(CENTER, CENTER);
    fill(colors.gray);
    rectMode(CORNER);
    if(millis() - assessment.timeEnded < commendationDelay*1000)
      textSize(fontSize);
    else
      textSize(fontSize*0.8);
    String bottomText = "Press [space bar] when ready.";
    if(millis() - assessment.timeEnded < commendationDelay*1000)
      bottomText = commendation;
    text(bottomText, 
         percentage.x1 + percentage.width_, percentage.y2 + percentage.rad/2 + 
                              (height - percentage.y2)/2);
  }
  else {
    cursor.show();
    fade.animateArrow();
  }
    percentage.rad = percentage.thickness*4;
    percentage.animateCompletion();
}
boolean typingCompleted () {
  boolean typingCompleted = false;
  if(str.toBeTyped.length() <= str.beingTyped.length()) {
    if(permissionTo.useBackspace)
      typingCompleted = str.toBeTyped.length() <= str.beingTyped.length();
    else
      typingCompleted = str.toBeTyped.length() == str.beingTyped.length();
  }
  return typingCompleted;
}
void keyPressed(KeyEvent k) {
  if(keyCode == ESC) {
    key = ENTER;
    return;
  }
  if(!typingCompleted ()) {
    if(!assessment.ticking) {
      assessment.startClock();
    }
    if(key >= permissionTo.min && key <= permissionTo.max) {
      if(stringBeingTyped.size() < stringToType.size()) {
        if(permissionTo.letErrsSlide) {
          if(str(key).contains(keyToHold)) {
            keyIsHeld = true;
            fade.toHold = 0;
          }
          if(keyToHold == "" || (keyIsHeld && keyToHold != "" && !str(key).contains(keyToHold))) {
            stringBeingTyped.append(str(key));
            if(key != str.toBeTyped.charAt(str.beingTyped.length())) {
              lastErrLetter = str(key);
              fade.errLetter = fade.errBrightest;
            }
            else
              fade.errLetter = 0;
          }
        }
        else {
          if(str(key) == keyToHold) {
            keyIsHeld = true;
            fade.toHold = 0;
          }
          if(keyToHold == "" || (keyIsHeld && keyToHold != "" && !str(key).contains(keyToHold))) {
            if(key == str.toBeTyped.charAt(str.beingTyped.length())) {
              stringBeingTyped.append(str(key));
              fade.errLetter = 0;
            }
            else {
              fade.errLetter = fade.errBrightest;
              lastErrLetter = str(key);
              if(stage.isIntroduction()) {
                fade.temporaryErr = fade.temporaryErrBrightest;
                fade.temporaryErrCounter = 0;
              }
               rightness.set(str.beingTyped.length(), right.WRONG);
            }
          }
        }
      }
      str.updateBeingTyped();
      right.updateRightness();
    }
    else if(keyCode == BACKSPACE && permissionTo.useBackspace) {
      if(stringBeingTyped.size() > 0) {
        if(stringBeingTyped.size() > 1) {
          if(k.isControlDown())
          {
            if(!stringBeingTyped.get(stringBeingTyped.size() - 1).equals(" ") ||
               permissionTo.eraseBeyondSpace &&
                 stringBeingTyped.get(stringBeingTyped.size() - 1).equals(" ")) {
              String oneWordLess = "", splitted [] = split(str.beingTyped.trim(), " ");
              for(int a = 0; a < splitted.length - 1; a ++)
                oneWordLess += splitted [a] + " ";
              oneWordLess = oneWordLess.trim();
              if(splitted.length != 1)
                oneWordLess += " ";
              stringBeingTyped = convert.charArrayToList(oneWordLess.toCharArray());
            }
          }
          else {
            if(!(stringBeingTyped.get(stringBeingTyped.size() - 1).equals(" ")) ||
              permissionTo.eraseBeyondSpace &&
                  (stringBeingTyped.get(stringBeingTyped.size() - 1).equals(" ")))
               stringBeingTyped.remove(stringBeingTyped.size() - 1);
            else if(stringBeingTyped.get(stringBeingTyped.size() - 1).equals(" ")
              && stringBeingTyped.get(stringBeingTyped.size() - 2).equals(" "))
                 stringBeingTyped.remove(stringBeingTyped.size() - 1);
          }
        }
        else
          stringBeingTyped.remove(stringBeingTyped.size() - 1);
      }
      if(permissionTo.useBackspace) {
        fade.errLetter = 0;
      }
        str.updateBeingTyped();
        right.updateRightness();
    }
    if(keyCode == BACKSPACE && !permissionTo.useBackspace) {
      fade.arrow = fade.arrowBrightest;
      fade.temporaryErr = fade.temporaryErrBrightest;
      fade.temporaryErrCounter = 0;
      rightness.set(str.beingTyped.length(), right.WRONG);
    }
  }
  if(key == ' ') {
    if(stage.isExercise () && typingCompleted()) {
      proceedToNextLevel = true;
    }
  }
}
void keyReleased () {
  if(!typingCompleted ()) {
      if(str(key).contains(keyToHold) && keyToHold != "") {
        keyIsHeld = false;
        fade.toHold = fade.maxToHold;
      }
      else if(keyToHold == "")
        fade.toHold = 0;
    }
}
boolean circleHovered (float x, float y, float rad, int mode) {
  return mode == CORNER && dist(mouseX, mouseY, x + rad/2, y + rad/2) <= rad/2 ||
         mode == CENTER && dist(mouseX, mouseY, x, y) <= rad/2 ? true : false;
}
void mouseReleased () {
  if(stage.isHome())
    if(circleHovered(home.sunX, home.sunY, home.sunRad, CENTER)) {
      home.buttonClicked = true;
      home.callToAction = "Setting things up ....";
      fade.background = fade.backgroundBrightest;
      fade.toBackground = 0;
    }
}
WordsToType wordsToType;
StringConversion convert;
Colors colors;
Str str;
Permission permissionTo;
Similarity similarity;
Cursor cursor;
Path path;
Consola consola;
SansPro sansPro;
Montserrat montserrat;
Window window;
Tools tool;
Rightness right;
VectorIcons alert;
Fade fade;
Arrow arrow;
CheckMark checkMark;
Errors error;
ErrorMessages errorMessage;
Stage stage;
Exercise exercise;
Training training;
Introduction introduction;
Commendatory commendatory;
Percentage percentage;
Assessment assessment;
HomeAnimation home;

String INTRODUCTION = "INTRODUCTION", TRAINING = "TRAINING", EXERCISE = "EXERCISE", 
  typeThis = "", typingMode = INTRODUCTION, lastErrLetter = "", 
  commendation = "Great Job!", keyToHold = "", actualStage [];
StringList stringToType, stringBeingTyped, rightness, exerciseWords;
int commending = 0, commendationDelay = 3;
boolean proceedToNextLevel = false, keyIsHeld = false;

class Colors {
  color background = #FFFFFF, toBeTyped = 60, cursor = 40, border = #838383, 
    correctTint = color(#0AF717, 100), wrongTint = color(#FC1235, 100), 
    unknownTint = color(0, 0), arrowColor = 150, crossColor = #F75A79, 
    checkColor = #A9D000, errTint = #FF0839, gray = 60, 
    correctText = #0AF717, wrongText = #FC1235, percentage = #4299FA, 
    grayAlpha = 180, keyToPress = #4299FA;
}

class Permission {
  char min = ' ', max = '~';
  boolean useBackspace = false, letErrsSlide = false, eraseBeyondSpace = false;
  void goHome () {
    useBackspace = true;
    letErrsSlide = true;
    eraseBeyondSpace = true;
  }
  void onIntroductionMode () {
    colors.toBeTyped = #4299FA; 
    colors.border = #4299FA;
    useBackspace = false;
    letErrsSlide = false;
    cursor.giveOrTake = 0;
    eraseBeyondSpace = false;
  }
  void onTrainingMode () {
    colors.toBeTyped = 60; 
    colors.border = #838383; 
    colors.cursor = #4299FA;
    useBackspace = false;
    letErrsSlide = false;
    cursor.giveOrTake = 0;
    eraseBeyondSpace = false;
  }
  void onExerciseMode () {
    colors.toBeTyped = 100; 
    colors.cursor = #0545FF;
    useBackspace = true;
    letErrsSlide = true;
    cursor.giveOrTake = 2;
    eraseBeyondSpace = true;
  }
}

class Stage {
  int stageCounter = 0, levelCounter = 0, HOME = 0, 
    INTRODUCTION = 1, TRAINING = 2, EXERCISE = 3;
  String guideline [], stages [] =
    {"Home", "Introduction", "Training", "Exercise"}, 
    codes [] = {"<HOME>", "<INTRODUCTION>", "<TRAINING>", "<EXERCISE>"}, stage [], 
    codename = codes [0], sideNote = "", sideNoteDelimiter = "<SIDE_NOTE>", 
    commendatoryWords [] = {
      "That's okay! Try harder next time.", 
      "Cool! Give it all you got next time.", 
      "Success!", "Great job!", "Splendid!", "Trimph!", "Marvelous Work!", 
    "Sumptuous!", "Remarkable!"};
  StringList newKeys; 
  String generateFilePath (String codeName) {
    String filePath = path.data;
    for (int a = 0; a < stages.length; a ++)
      if (match(codeName, codes [a]) != null) {
        this.codename = stages [a];
        if (isHome()) {
          permissionTo.goHome();
        } else if (isIntroduction()) {
          permissionTo.onIntroductionMode();
        } else if (isTraining()) {
          permissionTo.onTrainingMode();
        } else if (isExercise()) {
          permissionTo.onExerciseMode();
        }
        filePath += path.stage + stages [a] + "/" +
          split(codeName, codes [a]) [1] + ".txt";
        return filePath;
      }
    return null;
  }
  boolean isHome () {
    return tool.neutralize(codename).equalsIgnoreCase(
      tool.neutralize(codes [HOME]));
  }
  boolean isIntroduction () {
    return tool.neutralize(codename).equalsIgnoreCase(
      tool.neutralize(codes [INTRODUCTION]));
  }
  boolean isTraining () {
    return tool.neutralize(codename).equalsIgnoreCase(
      tool.neutralize(codes [TRAINING]));
  }
  boolean isExercise () {
    return tool.neutralize(codename).equalsIgnoreCase(
      tool.neutralize(codes [EXERCISE]));
  }
  boolean endOfIntroduction () {
    return levelCounter == stage.length - 1 && str.toBeTyped.charAt(0) == ' ';
  }

  void loadGuideline () {
    String store [] = null;
    try {
      store = loadStrings(path.data + path.guideline);
      if (store == null) {
        error.guidelineMissing = true;
        println(errorMessage.guidelineMissing);
        exit();
      }
    }
    catch (Exception e) {
      error.guidelineMissing = true;
      println(errorMessage.guidelineMissing);
      exit();
    }
    if (store != null) {
      error.guidelineMissing = false;
      guideline = store;
    }
  }
  void loadStageFile () {
    if (!error.guidelineMissing) {
      path.generated = null;
      try {
        path.generated = generateFilePath(guideline [stageCounter]);
      }
      catch (Exception e) {
        println(errorMessage.invalidCodeName);
        error.invalidCodeName = true;
        exit();
      }
      if (path.generated != null) {
        error.invalidCodeName = false;
        if (guideline.length > 0 && stageCounter <= guideline.length) {
          stage = loadStrings(generateFilePath(guideline [stageCounter]));
          if (stage != null) {
            if (stage.length > 0) {
              if (stage [0].replace(" ", "").contains ("[HOLD") && stage [0].trim().charAt(0) == '[') {
                keyToHold = split(split(stage [0], "]") [0], " ") [1];
                actualStage = new String [stage.length - 1];
                for (int a = 0; a < actualStage.length; a ++)
                  actualStage [a] = stage [a + 1];
                stage = actualStage;
                keyIsHeld = false;
                fade.toHold = fade.maxToHold;
              } else {
                keyToHold = "";
                fade.toHold = 0;
              }
            }
          }
          newKeys = new StringList();
          if (isTraining())
            training.posY = -height*0.2;
        }
      } else {
        println(errorMessage.invalidCodeName);
        error.invalidCodeName = true;
        exit();
      }
    }
  }
  void nextStage () {
    if (stageCounter < guideline.length - 1) {
      stageCounter ++;
      loadStageFile();
      levelCounter = 0;
    }
  }
  void loadLevel () {
    if (!error.guidelineMissing && !error.invalidCodeName) {
      if (stage.length > 0 && levelCounter < stage.length) {
        if (match(stage [levelCounter], sideNoteDelimiter) != null) {
          typeThis = split(stage [levelCounter], sideNoteDelimiter) [0];
          newKeys.append(typeThis);
          sideNote = split(stage [levelCounter], sideNoteDelimiter) [1];
        } else {
          typeThis = stage [levelCounter];
          if (isExercise()) {
            exerciseWords = convert.arrayToList(stage);
          }
          sideNote = "";
        }
        fade.resetBackgroundFade();
      }
    }
  }
  void nextLevel () {
    if (!error.guidelineMissing && !error.invalidCodeName) {
      if (levelCounter < stage.length - 1)
        levelCounter ++;
      else
        nextStage();

      fade.arrow = 0;
      fade.errLetter = 0;
      loadLevel ();
    }
  }
}

class Exercise {
  int pullFactor = 0, displayableVerticalLines = 3;
  float posY = height*0.4, toPosY = 0, scrollTransitionFactor = 8;
  void scrollWhenNecessary () {
    exercise.posY = tool.
      gradualChange(exercise.posY, exercise.toPosY, scrollTransitionFactor);
  }
}
class Training {
  float posY = height*0.6, toPosY = height*0.2, scrollTransitionFactor = 8;
  void scrollWhenNecessary () {
    training.posY = tool.
      gradualChange(training.posY, training.toPosY, scrollTransitionFactor);
  }
}
class Introduction {
  float posY, toPosY = height*0.4, adjustTransitionFactor = 8;
  void adjustPosition () {
    introduction.posY = tool.
      gradualChange(introduction.posY, introduction.toPosY, 
      introduction.adjustTransitionFactor);
  }
}
class Str {
  String toBeTyped = "", beingTyped = "", toBeTypedSnippet = "";
  String toBeTypedSnippet () {
    str.toBeTypedSnippet = "";
    for (int a = 0; a < beingTyped.length(); a ++) {
      str.toBeTypedSnippet += str(toBeTyped.charAt(a));
    }
    return toBeTypedSnippet;
  }
  void updateBeingTyped () {
    beingTyped = convert.listToString(stringBeingTyped);
  }
  void updateToBeTyped () {
    toBeTyped = convert.listToString(stringToType);
  }
  void updateWordsToType () {
    stringToType = wordsToType.initialize (typeThis);
    stringBeingTyped = new StringList ();
    rightness = new StringList ();

    str.updateToBeTyped ();
    str.updateBeingTyped ();

    right.initiateRightness ();
  }
}

class Percentage {
  float x1 = width*0.2, y1 = height*0.6, 
    x2 = width - width*0.2, y2 = height*0.6, 
    toX1, toY1, toX2, toY2, thickness = 4, 
    rad = thickness*2.5, transitionFactor = 16, width_, toWidth;
  float completion () {
    return map(str.beingTyped.length(), 0, str.toBeTyped.length(), 0, 100);
  }
  void animateCompletion () {
    strokeWeight(percentage.thickness);
    if (!typingCompleted()) {
      stroke(colors.gray, 120);
      line(x1, y1, x2, y2);
    }
    fill(colors.background);
    stroke(colors.percentage);
    line(x1, y1, x1 + width_, y2);
    strokeWeight(percentage.thickness*0.5);
    ellipseMode(CENTER);
    ellipse(x1 + width_, y2, rad, rad);
    width_ = tool.gradualChange(width_, 
      percentage.completion()*toWidth/100, transitionFactor);
    x1 = tool.gradualChange(x1, toX1, transitionFactor);
    y1 = tool.gradualChange(y1, toY1, transitionFactor);
    x2 = tool.gradualChange(x2, toX2, transitionFactor);
    y2 = tool.gradualChange(y2, toY2, transitionFactor);
  }
  void showAccuracy () {
    textFont(sansPro.bold);
    fill(colors.gray, 100);
    textSize(rad*2.5);
    textAlign(RIGHT, TOP);
    text(assessment.realAccuracy(), width - rad, rad);
    float yPos = textAscent() + textDescent();
    fill(colors.gray, 220);
    textSize(rad*0.8);
    textAlign(RIGHT, TOP);
    text("ACCURACY", width - rad, rad + yPos);
  }
  void showWPM () {
    textFont(sansPro.bold);
    fill(colors.gray, 100);
    textSize(rad*2.5);
    textAlign(LEFT, TOP);
    text(assessment.grossWPMnow (), rad, rad);
    float yPos = textAscent() + textDescent();
    fill(colors.gray, 220);
    textSize(rad*0.8);
    textAlign(LEFT, TOP);
    text("WPM", rad, rad + yPos);
  }
}

class Rightness {
  String CORRECT = "CORRECT", WRONG = "WRONG", UNKNOWN = "UNKNOWN", 
    WRONG_THEN_CORRECT = "WtC";
  void initiateRightness () {
    for (int a = 0; a < str.toBeTyped.length(); a ++)
      rightness.set(a, UNKNOWN);
  }
  void updateRightness () {
    if (str.beingTyped.length() > 0) {
      if (str.beingTyped.charAt(str.beingTyped.length() - 1) == str.toBeTyped.charAt(str.beingTyped.length() - 1))
        rightness.set(str.beingTyped.length() - 1, CORRECT);
      else
        rightness.set(str.beingTyped.length() - 1, WRONG);
      for (int a = str.beingTyped.length() + (permissionTo.useBackspace? 0 : 1); 
        a < str.toBeTyped.length(); a ++)
        rightness.set(a, UNKNOWN);
    }
    if (str.beingTyped.length() == 0 && permissionTo.useBackspace)
      for (int a = str.beingTyped.length(); a < str.toBeTyped.length(); a ++)
        rightness.set(a, UNKNOWN);
    else
      for (int a = str.beingTyped.length() + 1; a < str.toBeTyped.length(); a ++)
        rightness.set(a, UNKNOWN);
  }
  color correctness (int index) {
    if (rightness.get(index).equals(right.CORRECT))
      return colors.correctTint;
    else if (rightness.get(index).equals(right.WRONG))
      return colors.wrongTint;
    else if (rightness.get(index).equals(right.UNKNOWN))
      return color(colors.unknownTint, 0);
    return colors.gray;
  }
}

class Cursor {
  float x = 0, y = 0, thickness, alphaVal = 255, toX = this.width/2, width, 
    slidingTransitionFactor = 4;
  int giveOrTake = 0;
  void show () {
    stroke(colors.cursor, alphaVal);
    strokeCap(PROJECT);
    strokeWeight(thickness);
    line(x + giveOrTake - this.width/2, y + thickness, x + this.width/2 - giveOrTake, y + thickness);
    x = tool.gradualChange(x, toX, slidingTransitionFactor);
  }
}

class Fade extends Tools {
  float arrow = 0, toArrow = 0, arrowTransitionSpeedFactor = 40, tolerateFactor = 1, 
    errLetter = 0, toErrLetter = 0, errLetterTransitionFactor = 35, 
    arrowBrightest = 255, errBrightest = 255, fastTransition = 8, 
    temporaryErr = 0, toTemporaryErr = 0, temporaryErrTransitionFactor = 2, 
    temporaryErrBrightest = 255, backgroundBrightest = 255, 
    background = 0, toBackground = 0, backgroundTransitionFactor = 12, 
    hold = 0, toHold = 0, holdTransitionFactor = 8, maxToHold = 235;
  int temporaryErrCounter = 0, temporaryErrShiftSign = 1, temporaryNumberOfShakes = 3;
  void animateArrow () {
    if (animationWorthy(arrow, toArrow, tolerateFactor)) {
      arrow = gradualChange(arrow, toArrow, arrowTransitionSpeedFactor);
      alert.showBackspaceNotAllowed(arrow);
    } else
      arrow = toArrow;
  }
  void animateErrLetter (float x, float y, float fontSize) {
    if (animationWorthy(errLetter, toErrLetter, tolerateFactor)) {
      errLetter = gradualChange(errLetter, toErrLetter, errLetterTransitionFactor);
      alert.showErrLetter(x, y, fontSize);
    } else
      errLetter = toErrLetter;
  }
  void animateErrLetter (float x, float y, float fontSize, color fontColor) {
    if (animationWorthy(errLetter, toErrLetter, tolerateFactor)) {
      errLetter = gradualChange(errLetter, toErrLetter, errLetterTransitionFactor*2);
      alert.showErrLetter(x, y, fontSize, fontColor);
    } else
      errLetter = toErrLetter;
  }
  void animateTemporaryErr () {
    if (animationWorthy(temporaryErr, toTemporaryErr, tolerateFactor)) {
      temporaryErr = gradualChange(temporaryErr, toTemporaryErr, temporaryErrTransitionFactor);
    }
  }
  void entireScreen () {
    rectMode(CORNER);
    noStroke();
    fill(colors.background, background);
    rect(0, 0, width, height);
    background = tool.gradualChange(background, toBackground, backgroundTransitionFactor);
  }
  void mustHoldKey () {
    rectMode(CORNER);
    noStroke();
    fill(colors.background, hold);
    rect(0, 0, width, height);
    hold = tool.gradualChange(hold, toHold, holdTransitionFactor);

    if (keyToHold != "" && !keyIsHeld) {
      textFont(montserrat.bold);
      float fontSize = height*0.12, borderThickness = 1, edgeCurve = 4;
      textSize(fontSize);
      float oneCharWidth = textWidth("  "), posX = width*0.5, 
        eachHeight = (textAscent() + textDescent())*1.3, 
        eachWidth = oneCharWidth*2.6, newXPos = 0, 
        displayW = eachWidth*str.toBeTyped.length();
      cursor.thickness = eachHeight*0.05;  
      cursor.width = eachWidth;
      introduction.adjustPosition();
      {
        rectMode(CORNER);
        textAlign(CENTER, CENTER);

        noStroke();
        fade.animateTemporaryErr();
        if (dist(fade.temporaryErr, 0, fade.toTemporaryErr, 0) < fade.tolerateFactor)
          newXPos = tool.gradualChange(posX, posX + fade.temporaryErrShiftSign*(
            map(fade.temporaryErr, 0, fade.temporaryErrBrightest, 0, cursor.thickness)), 2);
        else
          newXPos = posX + fade.temporaryErrShiftSign*(- cursor.thickness +
            map(fade.temporaryErr, 0, fade.temporaryErrBrightest, 0, cursor.thickness));


        noFill();
        rect(newXPos, introduction.posY - eachHeight/2, eachWidth, eachHeight, edgeCurve);

        strokeWeight(borderThickness);
        stroke(colors.keyToPress, 140);

        noFill();
        rect(newXPos, introduction.posY - eachHeight/2, eachWidth, eachHeight, edgeCurve);
        fill(colors.keyToPress);
        text(keyToHold, newXPos + eachWidth/2, introduction.posY - textDescent());
        textFont(sansPro.light);
        textSize(fontSize*0.9);
        textAlign(RIGHT, CENTER);
        fill(colors.gray);
        text("Hold the", posX - cursor.thickness*2, introduction.posY);
        float leftMost = posX - cursor.thickness*2 - textWidth("Type the");
        textAlign(LEFT, CENTER);
        text("key", posX + eachWidth + cursor.thickness*2, introduction.posY);
        textAlign(LEFT, BOTTOM);
        textSize(fontSize*0.3);
        text("To proceed with this exercise", leftMost, introduction.posY - eachHeight/2);
        textAlign(LEFT, TOP);
        textSize(fontSize*0.4);
        text("You are required to hold this key through out this exercise", leftMost, introduction.posY + eachHeight/2 + cursor.thickness*2);
      }
    }
  }
  void resetBackgroundFade () {
    background  = backgroundBrightest;
  }
  boolean animationWorthy (float from, float to, float tolerateFactor) {
    return dist(from, 0, to, 0) > tolerateFactor;
  }
}

class Path {
  String main = dataPath("").replace("data", ""), data = main + "data/", 
    stage = "Stages/", guideline = "Guideline/Guideline.txt", 
    fonts = data + "Fonts/", generated = "";
}

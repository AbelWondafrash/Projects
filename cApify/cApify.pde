import java.awt.datatransfer.*;
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.io.IOException;
import java.util.Scanner;
import java.io.*;
import javax.swing.filechooser.*;
FileSystemView fsv = FileSystemView.getFileSystemView();
File [] roots = File.listRoots();
StringList store;
String tempoStore [], differentiatingString = "\"cAp!fy: Click End in the cApify window if you are finished.\"", monthLabel [] = {
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
String filePath = "";
float elPosX, elPosY, piecesGap, elRad, btmMenuW, 
  btmMenuH, btmMenuX [], toBtmCol [], btmCol [], elFade = 0, toElFade = 0, 
  toExpandRad, expandRad = 0, redBlinkingWidth = 10;
boolean elPressed = false, hereBefore = false, hereBefore2 = false;
int statusCounter = 0, times = 4;
float rad, factor = 0, shapes [] = {1/float(3), 0, 2}, shpPosX [], 
  shpPosY [], toShpPosX [], toShpPosY [], initialTPY, bright = 0, undoMenuX [], 
  undoY, toUndoMenuX [], somethingIsDisplayed = 0;
int shapeCounter = 0, toPieces = 0, mousePX = 0, mousePY = 0;
boolean oneTimeDeal = false, copied, saved, perishSlowly = false;
color unhovered = #FA0814, hovered = #E50914, clickedOn = #D30611;
String shapesLabels [] [], display = "", undoMenuLabels [] = {
  " Undo ", " Not really "}, undoFrom, bottomLabels [] = {"Help?", "cApify", 
  "Contact us"}, fileMissingText = "Oops! The save file is missing. Consider re-saving.";
int bottomN = bottomLabels.length, selectedItem = bottomN;
float bottomX [], bottomY, toBottomX [], toBottomY, bottomH, bottomW, 
  bottomFade [], toBottomFade [], screenW, screenH, savedPosY [], bright2 = 255;
float fadeRect = 0, contactX [], contactY [], contactR, contactG, 
  toContactX [], toContactY [], startContactX;
boolean changed = false, inEmail = false;
String contactLabels [] = {"Google+", "Facebook", "Twitter", "Pinterest", "Spotify"}, 
  contactLinks [] = {
    "https://plus.google.com/u/0/+AbelWondafrash", 
    "https://www.facebook.com/1abel", 
    "https://twitter.com/1abelaaa", 
    "https://www.pinterest.com/1abel", 
    "https://open.spotify.com/user/ab31a"},
    workStatus = "Idle", choosenDrive = "";
;
int signRect = 1, contactN = contactLabels.length;
color bottomColor [], contactCol [] = {
  #DC4B39, #3B5998, #0084b4, #BD081C, #84bd00};
void setup()
{
  screenW = 617;
  screenH = 345;
  size(617, 345);
  bottomH = screenH*0.125;
  float setHeight = screenH/2 - bottomH/3;
  bottomX = new float [3];
  toBottomX = new float [3];
  bottomFade = new float [3];
  toBottomFade = new float [3];
  bottomColor = new color [3];
  savedPosY = new float [3];
  contactX = new float [contactN];
  contactY = new float [contactN];
  toContactX = new float [contactN];
  toContactY = new float [contactN];
  toBottomY = screenH - bottomH;
  bottomY = toBottomY;
  bottomW = screenW*0.9/bottomN;
  for (int a = 0; a < bottomN; a ++)
  {
    bottomX [a] = screenW*0.5*0.3;
    toBottomX [a] = bottomW*a + screenW*0.1/2;
    bottomFade [a] = random(105) + (a + 1)*50;
    bottomColor [a] = unhovered;
  }
  undoMenuX = new float [2];
  toUndoMenuX = new float [2];
  undoMenuX [0] = screenW;
  undoMenuX [1] = screenW*1.5;
  rad = screenW*0.2;
  contactR = screenW*0.6/contactN;
  contactG = contactR*0.25;
  shpPosX = new float [3];  
  toShpPosX = new float [3];
  shpPosY = new float [3];  
  toShpPosY = new float [3];
  for (int  a = 0; a < 3; a ++)
  {
    toShpPosX [a] = screenW/2;
    toShpPosY [a] = screenH/2 - bottomH/3;
  }
  if ((int)random(1, 100) % 2 == 0)
  {
    shpPosY [0] = setHeight;  
    shpPosY [1] = setHeight;  
    shpPosY [2] = setHeight;
    shpPosX [0] = 0;  
    shpPosX [1] = screenW/2;  
    shpPosX [2] = screenW;
  } else
  {
    shpPosY [0] = 0;  
    shpPosY [1] = setHeight;  
    shpPosY [2] = screenH;
    shpPosX [0] = screenW/2;  
    shpPosX [1] = screenW/2;  
    shpPosX [2] = screenW/2;
  }
  initialTPY = shpPosY [1];
  shapesLabels = new String [3] [3];
  shapesLabels [0] [0] = "Begin";
  shapesLabels [1] [0] = "End";
  shapesLabels [1] [1] = "Pause";
  shapesLabels [2] [0] = "Save";
  shapesLabels [2] [1] = "Copy";
  shapesLabels [2] [2] = "Restart";
  startContactX = screenW*0.2/2 + (screenW*0.8 - contactN*contactR - contactG*(contactN - 1))/2;
  for (int a = 0; a < contactN; a ++)
  {
    toContactX [a] = startContactX + contactG*a + contactR*a;
    contactX [a] = startContactX + contactG*2 + contactR*2;
  }
}
void draw()
{
  frameRate(60);
  background(255);
  theAlmostEntireThing();
  bottomGUI();
  doTheCopyingWhenConditionIsMet();
  if (selectedItem == bottomN)
    surface.setTitle("cApify 1.0.1 : " + display);
  else
  {
    textSize(contactR*0.13);
    fill(unhovered);
    textAlign(CENTER, BOTTOM);
    text("Want more? Call: +251 915 787 470", screenW/2, screenH*0.988);
  }
}
void doTheCopyingWhenConditionIsMet()
{
  if (selectedItem == bottomN)
  {
    if (workStatus == "CopyingResumed" || workStatus == "CopyingStarted")
    {
      if (workStatus == "CopyingResumed")
        display = "You may continue copying now ";
      else
        display = "You may begin copying now ";
      String see [] = match(clipboard(), differentiatingString);
      if (see == null && clipboard() != differentiatingString)
      {
        String lines [] = split(clipboard(), '\n');
        for (int a = 0; a < lines.length; a ++)
          store.append(lines [a]);
        putOnClipboard (differentiatingString);
      }
    } else if (workStatus == "CopyingToClipboard")
    {
      toUndoMenuX [0] = width*1.1;
      toUndoMenuX [1] = width*1.5;
    } else if (workStatus == "Idle")
    {
      display = "Start by clicking \"Begin\".";
      if (hereBefore && clipboard () != "cApify 1.0.1")
        putOnClipboard("cApify 1.0.1");
      hereBefore = false;
    } else if (clipboard () != "cApify 1.0.1" && hereBefore && (workStatus == "RestartRequested" || workStatus == "Saving" || workStatus == "EndingRequested"))
    {
      putOnClipboard("cApify 1.0.1");
      hereBefore = false;
    } else  if (!(workStatus == "RestartRequested" || workStatus == "Saving" || workStatus == "EndingRequested"))
      hereBefore = true;
  }
}
void putOnClipboard (String input)
{
  StringSelection stringSelection = new StringSelection (input);
  Clipboard clpbrd = Toolkit.getDefaultToolkit ().getSystemClipboard ();
  clpbrd.setContents (stringSelection, null);
}
String clipboard ()
{
  String output = "";
  Clipboard clipboard = Toolkit.getDefaultToolkit ().getSystemClipboard ();
  DataFlavor flavor = DataFlavor.stringFlavor;
  if (clipboard.isDataFlavorAvailable (flavor)) {
    try {
      output = clipboard.getData (flavor).toString ();
    } 
    catch (UnsupportedFlavorException e) {
      System.out.println(e);
    } 
    catch (IOException e) {
      System.out.println(e);
    }
  }
  return output;
}
void finalizeAndSave()
{
  tempoStore = new String [store.size()];
  for (int a = 0; a < store.size (); a ++)
    tempoStore [a] = store.get (a);
  choosenDrive = "";

  for (int a = 0; a < roots.length; a ++)
  {
    File f = roots [a];
    String driveType = fsv.getSystemTypeDescription(f), see [] = match ("Local Disk", driveType);
    if (see != null)
    {
      choosenDrive = roots [a].toString();
      break;
    } else
    {
      driveType = fsv.getSystemTypeDescription(f);
      see = match ("Removable Disk", driveType);
      if (see != null)
      {
        choosenDrive = roots [a].toString();
        break;
      } else
      {
        display = "Oops! Can't find a place to work on. Attach a drive and try again";
        frameRate(0.1);
        exit();
      }
    }
  }
  filePath = choosenDrive + "Capify\\" + ("Copies of " + str(day()) + ((day() == 1)? "st " : ((day() == 2)? "nd" : ((day() == 3)? "rd" : "th"))) + " of " + monthLabel [month() - 1] + ", " + str(year()) + " _ "+ str(hour()) + "-" + str(minute()) + "-" + str(second()) + ".txt").toString();
  selectOutput("Select location and type name for the file to be saved", "fileSelected");
}
void fileSelected(File selection) {
  if (selection != null)
  {
    filePath = selection.getAbsolutePath();
    String seeXTNTN [] = match(filePath, "."), tempoFl = "";
    if (seeXTNTN != null)
    {
      for (int a = 0; a < filePath.length(); a ++)
      {
        if (filePath.charAt(a) == '.')
          break;
        else
          tempoFl += filePath.charAt(a);
      }
      filePath = tempoFl + ".txt";
    }
  }
  saveStrings(filePath, tempoStore);
  display = filePath;
  perishSlowly = false;
  saved = true;
  undoMenuLabels [0] = " Open file ";
  undoMenuLabels [1] = " Never mind ";
  toUndoMenuX [0] = width*0.06 + textWidth(display);
  somethingIsDisplayed = 255;
  toUndoMenuX [1] = textWidth("  " + undoMenuLabels [0]) + toUndoMenuX [0];
  shapesLabels [1] [0] = "Back";
  shapesLabels [1] [1] = "Restart";
  shapeCounter = 1;
  toPieces = 4;
  bright = 150;
  workStatus = "Saving";
}
void initializeStore()
{
  store = new StringList();
  putOnClipboard (differentiatingString);
}
void bottomGUI()
{
  stroke(unhovered);
  strokeWeight(1);
  line(bottomX [0], bottomY, bottomX [bottomN - 1] + bottomW, bottomY);
  if (bottomY < screenH - bottomH - bottomH*0.2)
  {
    line(bottomX [0], bottomY + bottomH, bottomX [bottomN - 1] + bottomW, bottomY + bottomH);
    fill(255, 180);
    strokeWeight(1);
    noStroke();
    rect(0, bottomY - bottomH, screenW, bottomH);
    fill(80);
    textAlign(CENTER, BOTTOM);
    textSize(rad*0.11);
    text("Copyrights © 2017 PocoThings Inc.", width/2, bottomY - 4);
    noFill();
    stroke(unhovered, 80);
    rect(bottomX [0], bottomY + bottomH, bottomW*bottomN, 768*0.45 - (bottomY + bottomH + height*0.06));
    textSize(rad*0.13);
    color selectedCol = unhovered;
    int bright = 140;
    if (mouseX < bottomX [0] +  bottomW*bottomN && mouseX > bottomW*bottomN + bottomX [0] - screenW*0.09/2 && mouseY > bottomY + bottomH && mouseY < bottomY + bottomH + screenW*0.09/2)
    {
      if (mousePressed)
        selectedCol = hovered;
      else
        selectedCol = unhovered;
      bright = 220;
    }
    fill(selectedCol, bright);
    arc(bottomX [0] + bottomW*bottomN, bottomY + bottomH, screenW*0.09, screenW*0.09, PI/2, PI);
    float x_ = bottomX [0] + bottomW*bottomN - screenW*0.1/4, 
      y_ = bottomY + bottomH + screenW*0.1/3;
    stroke(0);
    strokeWeight(4);
    textAlign(LEFT, BOTTOM);
    fill(255);
    text("-", x_, y_);
    noStroke();
    textAlign(RIGHT, BOTTOM);
    rectMode(CORNER);
    textSize(rad*0.1);
    if (mouseX < bottomX [0] +  bottomW*bottomN && mouseX > bottomW*bottomN + bottomX [0] - screenW*0.09/2 && mouseY > bottomY + bottomH && mouseY < bottomY + bottomH + screenW*0.09/2)
    {
      fill(unhovered, 220);
      rect(bottomX [bottomN - 1] + bottomW - screenW*0.09/2 - textWidth(" Minimize  "), bottomH*0.2*(selectedItem) + bottomY + bottomH, textWidth("Minimize "), (textAscent() + textDescent())); 
      fill(255);
      text(" Minimize  ", bottomX [bottomN - 1] + bottomW - screenW*0.09/2, y_ + bottomH*0.2*(selectedItem) - textAscent()/2);
    }
    if (selectedItem == 0)
    {
      fill(unhovered);
      textSize(bottomH*0.4);
      textAlign(LEFT, TOP);
      text("Getting started", bottomX [0] + bottomH/2, bottomY + bottomH + bottomH*0.5);
      fill(0);
      textSize(bottomH*0.3);
      text("    To start using cApify, click \"Begin\". Then go wherever and simply copy selected texts the way you like as many times as desired. When done, go back to cApify and click \"End\". From there you can either go with \"Save\" or \"Copy\".", 
        bottomX [0] + bottomH/2, 
        bottomY + bottomH + bottomH*0.5 + (textAscent() + textDescent())*2, 
        screenW - (bottomX [0] + bottomH/2)*2, (textAscent() + textDescent())*4);
      fill(unhovered);
      textSize(bottomH*0.4);
      textAlign(LEFT, TOP);
      text("Tips", bottomX [0] + bottomH/2, bottomY + bottomH + bottomH*0.5 + (textAscent() + textDescent())*4.8);
      fill(0);
      textSize(bottomH*0.3);
      text("    UNDO: Use this to untake an action. #This will appear when you need it.\n    SAVE: Save copies wherever so you can use them later.\n    PAUSE/RESUME: To take a break and do some unrelated copy-pasting.", 
        bottomX [0] + bottomH/2, 
        bottomY + bottomH + bottomH*0.5 + (textAscent() + textDescent())*8, 
        screenW - (bottomX [0] + bottomH/2)*2, (textAscent() + textDescent())*6);
    } else if (selectedItem == 1)
    {
      fill(unhovered);
      textSize(bottomH*0.4);
      textAlign(CENTER, TOP);
      text("Copying excelled!", screenW/2, bottomY + bottomH + bottomH*0.5);
      fill(0);
      textSize(bottomH*0.3);
      text("With cApify, your way of copying is enhanced; yet kept simple.", 
        bottomX [0] + bottomH/2, 
        bottomY + bottomH + bottomH*0.5 + (textAscent() + textDescent())*2, 
        screenW - (bottomX [0] + bottomH/2)*2, screenW/2);
      fill(unhovered);
      textSize(bottomH*0.4);
      textAlign(CENTER, TOP);
      text("What can you do with cApify?", screenW/2, bottomY + bottomH + bottomH*0.5 + textAscent()*4);
      fill(0);

      textSize(bottomH*0.3);
      text("cApify elevates your copying method by letting you copy as many text as you want and paste it all: just once. You can either copy the final collection or save it wherever, so it can be used later; both being click away. Go to \"Help?\" for more.\nUnsatisfied? Let us know about your thoughts via email.", 
        bottomX [0] + bottomH/2, 
        bottomY + bottomH + bottomH*0.5 + (textAscent() + textDescent())*5.5, 
        screenW - (bottomX [0] + bottomH/2)*2, screenW/2);
      String email = "capifybel@gmail.com";
      noStroke();
      textSize(bottomH*0.5);
      if (mouseX > screenW/2 - textWidth(email)/2 && mouseX < screenW/2 + textWidth(email)/2 && mouseY > 768*0.45 - (bottomY + bottomH + height*0.06) + bottomH + bottomY - textAscent() && mouseY < 768*0.45 - (bottomY + bottomH + height*0.06) + bottomH + bottomY - textAscent() + textAscent())
      {
        if (mousePressed)
          fill(clickedOn);
        else
          fill(hovered);
        inEmail = true;
      } else
      {
        fill(unhovered, 200);
        inEmail = false;
      }
      rectMode(CORNER);
      rect(screenW/2 - textWidth(email)/2, 768*0.45 - (bottomY + bottomH + height*0.06) + bottomH + bottomY - textAscent(), textWidth(email), textAscent());
      fill(255);
      textAlign(CENTER, BOTTOM);
      textSize(bottomH*0.4);
      text(email, screenW/2, 768*0.45 - (bottomY + bottomH + height*0.06) + bottomH + bottomY);
    } else if (selectedItem == 2)
    {
      for (int a = 0; a < contactN; a ++)
      {
        contactX [a] = gradualChange(contactX [a], toContactX [a], 12);
        contactY [a] = gradualChange(contactY [a], toContactY [a], 12);
      }
      ellipseMode(CORNER);
      for (int a = 0; a < contactN; a ++)
      {
        strokeWeight(4);
        stroke(contactCol [a], 200);
        fill(((dist(mouseX, mouseY, contactX [a] + contactR/2, contactY [a] + contactR/2) < contactR/2)? contactCol [a] : 255), 220);
        if (dist(mouseX, mouseY, contactX [a] + contactR/2, contactY [a] + contactR/2) < contactR/2)
        {
          if (mousePressed)
            fill(contactCol [a]);
        }
        ellipse(contactX [a], contactY [a], contactR, contactR);
        fill(((dist(mouseX, mouseY, contactX [a] + contactR/2, contactY [a] + contactR/2) < contactR/2)? 255 : contactCol [a]));
        textAlign(CENTER, CENTER);
        textSize(contactR*0.18);
        text(contactLabels [a], contactX [a] + contactR/2, contactY [a] + contactR/2);
        if (dist(mouseX, mouseY, contactX [a] + contactR/2, contactY [a] + contactR/2) < contactR/2)
        {
          fill(contactCol [a]);
          textAlign(CENTER, BOTTOM);
          textSize(contactR*0.18);
          text(contactLinks [a], screenW/2, bottomY + bottomH + 768*0.45 - (bottomY + bottomH + height*0.06) - 2);
        }
      }
      ellipseMode(CENTER);
      textSize(contactR*0.25);
      fill(unhovered);
      textAlign(CENTER, TOP);
      text("Reach us via", screenW/2, bottomY + bottomH*2);
    }
  }
  noStroke();
  rectMode(CORNER);
  bottomY = gradualChange(bottomY, toBottomY, 8);
  for (int a = 0; a < bottomN; a ++)
  {
    bottomX [a] = gradualChange(bottomX [a], toBottomX [a], 16);
    bottomFade [a] = gradualChange(bottomFade [a], toBottomFade [a], ((bottomFade [a] < toBottomFade [a])? 16 : 25));
  }
  for (int a = 0; a < bottomN; a ++)
  {
    if (mouseX > bottomX [a] && mouseX < bottomX [a] + bottomW && mouseY > bottomY && mouseY < bottomY + bottomH)
    {
      if (mousePressed)
        bottomColor [a] = clickedOn;
      else
        bottomColor [a] = unhovered;
      toBottomFade [a] = 255;
    } else
      toBottomFade [a] = 0;
    fill(((selectedItem == a)? unhovered : bottomColor [a]), ((selectedItem == a)? 255 : bottomFade [a]));
    rect(bottomX [a], bottomY, map(bottomX [0], -1366*0.45*0.5, toBottomX [0], 1, bottomW), bottomH);
    fill(((selectedItem == a || mouseX > bottomX [a] && mouseX < bottomX [a] + bottomW && mouseY > bottomY && mouseY < bottomY + bottomH)? 255 : unhovered), map(bottomX [bottomN - 1], -1366*0.45*0.5, bottomX [bottomN - 1], 0, 255));
    textSize(bottomH*0.4);
    textAlign(CENTER, CENTER);
    text(bottomLabels [a], bottomX [a] + bottomW/2, bottomY + bottomH/2);
  }
  bright2 = gradualChange(bright2, 0, 25);
  rectMode(CORNER);
  fill(255, bright2);
  rect(0, bottomY, width, height);
}
void theAlmostEntireThing()
{
  for (int  a = 0; a < 3 && selectedItem != bottomN; a ++)
    toShpPosY [a] = bottomY + bottomH - (screenH/2 + bottomH/3);
  if ((int)bright > 0)
    bright -= dist(bright, 0, 0, 0)/12;
  int shadowShift = 4;
  noStroke();
  fill(#D8C9CA);
  arc(shpPosX [0] + shadowShift, shpPosY [0] + shadowShift, rad*1.01, rad*1.01, PI + factor, TWO_PI - factor, OPEN);
  fill(unhovered);
  if (shapeCounter == 1 && mouseY < shpPosY [0] && dist(mouseX, mouseY, shpPosX [0], shpPosY [0]) < rad/2)
    fill(((mousePressed)? clickedOn : hovered));
  else if (shapeCounter == 0 && mouseY < shpPosY [0] - rad*sin(factor)/2 && dist(mouseX, mouseY, shpPosX [0], shpPosY [0]) < rad/2)
    fill(((mousePressed)? clickedOn : hovered));
  arc(shpPosX [0], shpPosY [0], rad, rad, PI + factor, TWO_PI - factor, OPEN);
  fill(#D8C9CA);
  rectMode(CENTER);
  arc(shpPosX [1] + shadowShift, shpPosY [1] + shadowShift, rad*1.01, rad*1.01, -factor, factor, OPEN);
  arc(shpPosX [1] + shadowShift, shpPosY [1] + shadowShift, rad*1.01, rad*1.01, PI - factor, PI + factor, OPEN);
  rect(shpPosX [1] + shadowShift, shpPosY [1] + shadowShift, rad*cos(factor)*1.01, rad*sin(factor)*1.01);
  fill(unhovered);
  if (shapeCounter == 2 && dist(mouseX, mouseY, shpPosX [1], shpPosY [1]) < rad/2)
    fill(((mousePressed)? clickedOn : hovered));
  else if (shapeCounter == 0 && mouseY > shpPosY [1] - rad*sin(factor)/2 && mouseY < shpPosY [1] + rad*sin(factor)/2&& dist(mouseX, mouseY, shpPosX [1], shpPosY [1]) < rad/2)
    fill(((mousePressed)? clickedOn : hovered));
  arc(shpPosX [1], shpPosY [1], rad, rad, -factor, factor, OPEN);
  arc(shpPosX [1], shpPosY [1], rad, rad, PI - factor, PI + factor, OPEN);
  rect(shpPosX [1], shpPosY [1], rad*cos(factor), rad*sin(factor));
  if (shapeCounter == 0 && factor < shapes [shapeCounter] + 0.05 && factor > shapes [shapeCounter] - 0.05)
  {
    float x, y;
    if (copied)
    {
      x = shpPosX [1] + rad*cos(factor)*0.4;
      y = shpPosY [1];
      textAlign(CENTER, CENTER);
      textSize(rad*0.15);
      fill(255);
      text("✓", x, y);
      if (shapeCounter == 0 && mouseY > shpPosY [1] - rad*sin(factor)/2 && mouseY < shpPosY [1] + rad*sin(factor)/2&& dist(mouseX, mouseY, shpPosX [1], shpPosY [1]) < rad/2)
      {
        x = shpPosX [1] + rad*cos(factor)*0.6;
        fill(hovered);
        textAlign(LEFT, CENTER);
        textSize(rad*0.1);
        text("(Copied to clipboard ✓)", x, y);
      }
    }
    if (saved)
    {
      x = shpPosX [0] + rad*cos(factor)*0.27;
      y = shpPosY [0] - rad*cos(factor)/3;
      textAlign(CENTER, CENTER);
      textSize(rad*0.15);
      fill(255);
      text("✓", x, y);
      if (shapeCounter == 0 && mouseY < shpPosY [0] - rad*sin(factor)/2 && dist(mouseX, mouseY, shpPosX [0], shpPosY [0]) < rad/2)
      {
        x = shpPosX [0] + rad - rad*cos(factor)*0.56;
        y = shpPosY [0] - rad/4;
        fill(hovered);
        textAlign(LEFT, BOTTOM);
        textSize(rad*0.1);
        text("(Copies are saved ✓)", x, y);
      }
    }
  } else if (!oneTimeDeal)
  {
    textSize(rad*0.14);
    fill(255);
    text("Copying\nexcelled!", shpPosX [1], shpPosY [1]);
  }
  fill(#D8C9CA);
  arc(shpPosX [2] + shadowShift, shpPosY [2] + shadowShift, rad*1.01, rad*1.01, factor, PI - factor, OPEN);
  fill(unhovered);
  if (shapeCounter == 1 && mouseY > shpPosY [2] && dist(mouseX, mouseY, shpPosX [2], shpPosY [2]) < rad/2)
    fill(((mousePressed)? clickedOn : hovered));
  else if (shapeCounter == 0 && mouseY > shpPosY [2] + rad*sin(factor)/2 && dist(mouseX, mouseY, shpPosX [2], shpPosY [2]) < rad/2)
    fill(((mousePressed)? clickedOn : hovered));
  arc(shpPosX [2], shpPosY [2], rad, rad, factor, PI - factor, OPEN);
  factor = gradualChange(factor, shapes [shapeCounter], (2 - shapeCounter)*4 + 8);
  for (int a = 0; a < 3; a ++)
  {
    shpPosX [a] = gradualChange(shpPosX [a], toShpPosX [a], 8);
    shpPosY [a] = gradualChange(shpPosY [a], toShpPosY [a], 8);
  }
  if (factor < shapes [shapeCounter] + 0.05 && factor > shapes [shapeCounter] - 0.05)
  {
    if (!oneTimeDeal)
    {
      if (shapeCounter < shapes.length - 1)
        shapeCounter ++;
      else
        oneTimeDeal = true;
    } else
    {
      if (toPieces == 2)
      {
        if (shapeCounter == 1)
        {
          toShpPosY [0] = initialTPY - rad/10;
          toShpPosY [2] = initialTPY + rad/10;
          toPieces = 9;
        } else if (shapeCounter == 0 && undoFrom == "Restart")
        {
          toShpPosY [0] = initialTPY - rad/10;
          toShpPosY [2] = initialTPY + rad/10;
          toPieces = 2;
          shapeCounter = 0;
          undoFrom = "noWhere";
        }
      } else if (toPieces == 4)
      {
        if (shapeCounter == 1)
        {
          toPieces = 9;
        }
      } else if (toPieces == 6)
      {
        if (shapeCounter == 2)
        {
          toShpPosY [0] = initialTPY;
          toShpPosY [2] = initialTPY;
          toPieces = 9;
          shapesLabels [1] [0] = "End";
          shapesLabels [1] [1] = "Pause";
        }
      }
    }
  }
  textSize(rad*0.13);
  fill(255);
  for (int b = 0; b < 3 && factor < shapes [shapeCounter] + 0.05 && factor > shapes [shapeCounter] - 0.05; b ++)
    if (shapesLabels [2 - shapeCounter] [b] != null)
    {
      if (2 - shapeCounter == 0)
      {
        textAlign(CENTER, CENTER);
        text(shapesLabels [2 - shapeCounter] [b], shpPosX [b], shpPosY [b]);
      } else if (2 - shapeCounter == 1)
      {
        textAlign(CENTER, ((b == 0)? CENTER : TOP));
        text(shapesLabels [2 - shapeCounter] [b], shpPosX [b], shpPosY [b] + rad*((b == 0)? -1 : 1)/4);
      } else
      {
        if (b == 0)
        {
          textAlign(CENTER, BOTTOM);
          text(shapesLabels [2 - shapeCounter] [b], shpPosX [b], shpPosY [b] - rad/4);
        } else if (b == 1)
        {
          textAlign(CENTER, CENTER);
          text(shapesLabels [2 - shapeCounter] [b], shpPosX [b], shpPosY [b]);
        } else
        {
          textAlign(CENTER, TOP);
          text(shapesLabels [2 - shapeCounter] [b], shpPosX [b], shpPosY [b] + rad/4);
        }
      }
    }
  noStroke();
  rectMode(CORNER);
  fill(255, bright);
  if (oneTimeDeal)
    rect(0, 0, width, height);
  console(display);
  if (perishSlowly == true && display.length() > 0 && millis() % 2 == 0)
    display = display.replace(str(display.charAt(display.length() - 1)), "");
}
void console(String dsply)
{
  fill(unhovered, 200);
  textAlign(LEFT, BOTTOM);
  textSize(width*0.025);
  String justRight = "";
  while(textWidth(dsply + ">_     " + undoMenuX [0] + undoMenuX [1]) + width*0.01> width*0.9)
  {
    justRight += display.charAt(justRight.length());
    dsply = justRight;
  }
  text(">_ " + dsply, width*0.01, height*0.06);
  redBlinkingLight(dsply + "  ");
  fill(255, somethingIsDisplayed);
  if (!perishSlowly)
    rect(width*0.01 + textWidth(">_ "), map(255 - somethingIsDisplayed, 0, 255, 0, undoY), textWidth(display), undoY);
  somethingIsDisplayed = gradualChange(int(somethingIsDisplayed), 0, 25);
  undoY = height*0.06;
  strokeWeight(0.8);
  stroke(hovered, 40);
  line(width*0.06, height*0.06, width*0.06 + textWidth(dsply), height*0.06);
  rectMode(CORNER);
  for (int a = 0; a < 2; a ++)
  {
    if (toUndoMenuX [a] >= width*0.06 + textWidth(dsply))
    {
      undoMenuX [a] = gradualChange(undoMenuX [a], toUndoMenuX [a], 12);
    }
    fill(unhovered, map(undoMenuX [a], 0, toUndoMenuX [a] + 1, 0, 230));
    if (mouseX > undoMenuX [a] && mouseX < undoMenuX [a] + textWidth(undoMenuLabels [a]) && mouseY < undoY)
    {
      fill(((mousePressed)? clickedOn : hovered), map(undoMenuX [a], 0, toUndoMenuX [a] + 1, 0, 230));
    }
    rect(undoMenuX [a], 0, textWidth(undoMenuLabels [a]), undoY);
    fill(255);
    textSize(width*0.025);
    textAlign(CENTER, BOTTOM);
    text(undoMenuLabels [a], undoMenuX [a] + textWidth(undoMenuLabels [a])/2, undoY);
  }
}
void redBlinkingLight(String disply)
{
  if (millis() != 0 && int(millis()/100%(8)) == 0 && !changed)
  {
    changed = true;
    signRect *= -1;
  } else if (millis() != 0 && int(millis()/1000%(100)) != 0)  changed = false;
  if (signRect == 1 && int(fadeRect) < 255)  fadeRect += dist(fadeRect, 0, 255, 0)/16;
  else if (signRect == -1 && int(fadeRect) > 4)  fadeRect -= dist(fadeRect, 0, 0, 0)/25;
  noStroke();
  fill(unhovered, fadeRect);
  rectMode(CORNER);
  rect(textWidth(">_ " + disply), textAscent()*0.1, textWidth("▋")*0.8, textAscent() + textDescent() - textAscent()*0.2);
  redBlinkingWidth = textWidth("▋")*0.8;
}
float gradualChange (float from, float to, float factor)
{
  if (from < to)
    from += dist(from, 0, to, 0)/factor;
  else if (from > to)
    from -= dist(from, 0, to, 0)/factor;
  return from;
}
void mousePressed()
{
  if (shapeCounter == 2 && dist(mouseX, mouseY, shpPosX [1], shpPosY [1]) < rad/2)
    toPieces = 2;
  mousePX = mouseX;
  mousePY = mouseY;
}
void mouseReleased()
{
  if (selectedItem == bottomN && factor < shapes [shapeCounter] + 0.05 && factor > shapes [shapeCounter] - 0.05)
  {
    if (mouseY < undoY && mousePY < undoY)
    {
      for (int a = 0; a < 2; a ++)
      {
        if (display != "" && mouseX > undoMenuX [a] && mouseX < undoMenuX [a] + textWidth(undoMenuLabels [a]) && mouseY < undoY && mousePX > undoMenuX [a] && mousePX < undoMenuX [a] + textWidth(undoMenuLabels [a]) && mousePY < undoY)
        {
          if (a == 0)
          {
            if (undoMenuLabels [0] == " Undo ")
            {
              if (undoFrom == "End")
              {
                shapeCounter = 1;
                toPieces = 4;
                workStatus = "CopyingResumed";
                putOnClipboard (differentiatingString);
              } else if (undoFrom == "Restart")
              {
                shapeCounter = 0;
                toPieces = 2;
                workStatus = "RestartRequestedCancelled";
              } else if (undoFrom == "||")
              {
                shapeCounter = 0;
                toPieces = 2;
                letUndoMenuPerish();
                display = "Copying paused. Click resume to continue";
                workStatus = "CopyingResumed";
                putOnClipboard (differentiatingString);
                somethingIsDisplayed = 255;
                shapesLabels [2] [0] = "Resume";
                shapesLabels [2] [1] = "End";
                shapesLabels [2] [2] = "Restart";
              }
              bright = 150;
            } else if (undoMenuLabels [0] == " Open file ")
            {
              bright = 150;
              String file [] = loadStrings(filePath);
              if(file == null)
              {
                shapeCounter = 1;
                toPieces = 4;
                bright = 150;
                letUndoMenuPerish();
                display = fileMissingText;
                workStatus = "MissingFile";
                toUndoMenuX [0] = width;
                toUndoMenuX [1] = width*1.5;
                perishSlowly = false;
                somethingIsDisplayed = 255;
                shapesLabels [1] [0] = "Back";
                shapesLabels [1] [1] = "Restart";
                saved = false;
              }
              else
                launch(filePath);
              workStatus = "FileOpened";
            }
          } else if (undoMenuLabels [1] == " Not really ")
            if (workStatus == "RestartRequested")
            {
              workStatus = "Idle";
              hereBefore2 = true;
            } else
              workStatus = "NoMistakes";
          else if (undoMenuLabels [1] == " Never mind ")
          {
            putOnClipboard("cApify 1.0.1");
            workStatus = "Don'tOpen";
          }
          if(display != fileMissingText)
            letUndoMenuPerish();
          break;
        }
      }
    } else if (shapeCounter == 2 && dist(mousePX, mousePY, shpPosX [1], shpPosY [1]) < rad/2 && dist(mouseX, mouseY, shpPosX [1], shpPosY [1]) < rad/2)
    {
      copied = false;
      saved = false;
      shapeCounter = 1;
      toPieces = 2;
      bright = 150;
      letUndoMenuPerish();
      workStatus = "CopyingStarted";
      putOnClipboard ("");
      initializeStore();
    } else if (dist(mousePX, mousePY, shpPosX [2], shpPosY [2]) < rad/2 && shapeCounter == 1 && mousePY > shpPosY [2] && mouseY > shpPosY [2] && dist(mouseX, mouseY, shpPosX [2], shpPosY [2]) < rad/2)
    {
      if (shapesLabels [1] [1] == "Restart")
      {
        shapeCounter = 2;
        toPieces = 6;
        letUndoMenuPerish();
        undoOptionFromRestart();
        workStatus = "RestartRequested";
      } else if (shapesLabels [1] [1] == "Pause")
      {
        shapeCounter = 0;
        toPieces = 2;
        letUndoMenuPerish();
        workStatus = "CopyingPaused";
        display = "Copying paused. Click resume to continue";
        perishSlowly = false;
        somethingIsDisplayed = 255;
        shapesLabels [2] [0] = "Resume";
        shapesLabels [2] [1] = "End";
        shapesLabels [2] [2] = "Restart";
      }
      bright = 150;
    } else if (dist(mousePX, mousePY, shpPosX [0], shpPosY [0]) < rad/2 && shapeCounter == 0 && mousePY < shpPosY [0] - rad*sin(factor)/2 && mousePY < shpPosY [0] - rad*sin(factor)/2 && mouseY < shpPosY [0] - rad*sin(factor)/2 && dist(mouseX, mouseY, shpPosX [0], shpPosY [0]) < rad/2)
    {
      if (shapesLabels [2] [0] == "Save")
        finalizeAndSave();
      else if (shapesLabels [2] [0] == "Resume")
      {
        shapeCounter = 1;
        toPieces = 4;
        bright = 150;
        letUndoMenuPerish();
        shapesLabels [1] [0] = "End";
        shapesLabels [1] [1] = "Pause";
        shapesLabels [2] [0] = "Save";
        shapesLabels [2] [1] = "Copy";
        shapesLabels [2] [2] = "Restart";
        workStatus = "CopyingResumed";
        putOnClipboard ("");
        putOnClipboard (differentiatingString);
      }
    } else if (dist(mousePX, mousePY, shpPosX [1], shpPosY [1]) < rad/2 && shapeCounter == 0 && mousePY < shpPosY [1] + rad*sin(factor)/2 && mousePY > shpPosY [1] - rad*sin(factor)/2 && mouseY > shpPosY [1] - rad*sin(factor)/2 && mousePY < shpPosY [1] + rad*sin(factor)/2 && mouseY < shpPosY [1] + rad*sin(factor)/2 && dist(mouseX, mouseY, shpPosX [1], shpPosY [1]) < rad/2)
    {
      if (shapesLabels [2] [1] == "Copy")
      {
        shapeCounter = 1;
        toPieces = 4;
        bright = 150;
        letUndoMenuPerish();
        String toClip = "";
        for (int a = 0; a < store.size(); a ++)
          toClip += store.get(a) + "\n";
        putOnClipboard (toClip);
        display = "Success in copying text. You are now a-paste-away!";
        workStatus = "CopyingToClipboard";
        toUndoMenuX [0] = width*0.06 + textWidth(display);
        toUndoMenuX [1] = textWidth("  " + undoMenuLabels [0]) + toUndoMenuX [0];

        perishSlowly = false;
        somethingIsDisplayed = 255;
        copied = true;
        shapesLabels [1] [0] = "Back";
        shapesLabels [1] [1] = "Restart";
      } else if (shapesLabels [2] [1] == "End")
      {
        shapeCounter = 0;
        toPieces = 2;
        shapesLabels [2] [0] = "Save";
        shapesLabels [2] [1] = "Copy";
        shapesLabels [2] [2] = "Restart";
        display = "Was that a mistake?";
        undoMenuLabels [0] = " Undo ";
        undoMenuLabels [1] = " Not really ";
        toUndoMenuX [0] = width*0.06 + textWidth(display);
        somethingIsDisplayed = 255;
        toUndoMenuX [1] = textWidth("  " + undoMenuLabels [0]) + toUndoMenuX [0];
        undoFrom = "||";
        perishSlowly = false;
        workStatus = "EndingRequested";
      }
    } else if (dist(mousePX, mousePY, shpPosX [2], shpPosY [2]) < rad/2 && shapeCounter == 0 && mousePY > shpPosY [2] + rad*sin(factor)/2 && mouseY > shpPosY [2] + rad*sin(factor)/2 && dist(mouseX, mouseY, shpPosX [2], shpPosY [2]) < rad/2)
    {
      undoOptionFromRestart();
      workStatus = "RestartRequested";
    } else if (dist(mousePX, mousePY, shpPosX [0], shpPosY [0]) < rad/2 && shapeCounter == 1 && mousePY < shpPosY [0] && mouseY < shpPosY [0] && dist(mouseX, mouseY, shpPosX [0], shpPosY [0]) < rad/2)
    {
      if (shapesLabels [1] [0] == "End")
      {
        display = "Was that a mistake?";
        undoMenuLabels [0] = " Undo ";
        undoMenuLabels [1] = " Not really ";
        toUndoMenuX [0] = width*0.06 + textWidth(display);
        somethingIsDisplayed = 255;
        toUndoMenuX [1] = textWidth("  " + undoMenuLabels [0]) + toUndoMenuX [0];
        shapeCounter = 0;
        toPieces = 2;
        undoFrom = "End";
        perishSlowly = false;
        workStatus = "EndingRequested";
      } else if (shapesLabels [1] [0] == "Back")
      {
        if (undoMenuLabels [0] == " Open file ")
        {
          undoMenuLabels [0] = " Undo ";
          undoMenuLabels [1] = " Not really ";
          letUndoMenuPerish();
        }
        workStatus = "GoingBack";
        putOnClipboard("cApify 1.0.1");
        shapeCounter = 0;
        toPieces = 2;
      }
      bright = 150;
    }
  }
  for (int a = 0; a < bottomN; a ++)
  {
    if (mouseX > bottomX [a] && mouseX < bottomX [a] + bottomW && mouseY > bottomY && mouseY < bottomY + bottomH && mousePX > bottomX [a] && mousePX < bottomX [a] + bottomW && mousePY > bottomY && mousePY < bottomY + bottomH)
    {
      if (selectedItem == bottomN)
      {
        for (int b = 0; b < bottomN; b ++)
        {
          bottomX [b] -= bottomW*0.2;
          savedPosY [b] = shpPosY [b];
        }
        for (int c = 0; c < contactN; c ++)
        {
          toContactX [c] = startContactX + contactG*c + contactR*c;
          contactX [c] = startContactX + contactG*2 + contactR*2;
          contactY [c] = screenH*0.8 + contactR*0.2*(a + 1);
        }
        toContactY [0] = screenH/2 - contactR/2;
        toContactY [1] = screenH/2;
        toContactY [2] = screenH/2 + contactR/2;
        toContactY [3] = screenH/2;
        toContactY [4] = screenH/2 - contactR/2;
      }
      if (selectedItem != a)
      {
        bright2 = 200;
      }
      selectedItem = a;
      toBottomY = 768*0.45*0.08;
      break;
    }
  }
  if (selectedItem != bottomN)
  {
    if (mouseX < bottomX [0] +  bottomW*bottomN && mouseX > bottomW*bottomN + bottomX [0] - screenW*0.09/2 && mouseY > bottomY + bottomH && mouseY < bottomY + bottomH + screenW*0.09/2 && mousePX < bottomX [0] +  bottomW*bottomN && mousePX > bottomW*bottomN + bottomX [0] - screenW*0.09/2 && mousePY > bottomY + bottomH && mousePY < bottomY + bottomH + screenW*0.09/2)
    {
      selectedItem = bottomN;
      toBottomY = screenH - bottomH;
      if (display == "Call: +251 915 787 470 for more.")
        letUndoMenuPerish();
      for (int  a = 0; a < 3; a ++)
        toShpPosY [a] = savedPosY [a];
    }
  }
  if (inEmail)
  {
    link("https://mail.google.com/mail/u/0/?view=cm&fs=1&to=capifybel@gmail.com&su=What+do+you+want+to+say?&body=Dear+Developer,%0D%0A%0D%0A%0D%0A%0D%0AYou're+awesome!+☻♥☺✌+%0D%0A%0D%0AWe'll+get+back+to+you+soon.&tf=1");
    inEmail = false;
  }
  if (selectedItem == 2)
  {
    for (int a = 0; a < contactN; a ++)
    {
      if (dist(mouseX, mouseY, contactX [a] + contactR/2, contactY [a] + contactR/2) < contactR/2 && dist(mousePX, mousePY, contactX [a] + contactR/2, contactY [a] + contactR/2) < contactR/2)
      {
        link(contactLinks [a]);
        break;
      }
    }
  }
}
void letUndoMenuPerish()
{
  toUndoMenuX [0] = width;
  toUndoMenuX [1] = width*1.5;
  somethingIsDisplayed = 255;
  perishSlowly = true;
}
void undoOptionFromRestart()
{
  display = "Was that a mistake?";
  undoMenuLabels [0] = " Undo ";
  undoMenuLabels [1] = " Not really ";
  toUndoMenuX [0] = width*0.06 + textWidth(display);
  somethingIsDisplayed = 255;
  toUndoMenuX [1] = textWidth("  " + undoMenuLabels [0]) + toUndoMenuX [0];
  shapeCounter = 2;
  toPieces = 6;
  bright = 150;
  undoFrom = "Restart";
  perishSlowly = false;
}
void keyPressed()
{
  if (keyCode == ESC)
    key = 0;
}
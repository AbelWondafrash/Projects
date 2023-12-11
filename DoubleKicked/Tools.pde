import java.awt.*;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import java.awt.datatransfer.*;
import java.awt.Toolkit;
import java.awt.*;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;

class Tools {
  Robot robot;
  Tools () {
    try {
      robot = new Robot();
    }
    catch (Exception e) {
      println(e.getMessage());
      exit();
    }
  }
  void TAB () {
    robot.keyPress(KeyEvent.VK_TAB);
    robot.keyRelease(KeyEvent.VK_TAB);
  }
  void BoldAndTab1 () {
    robot.keyPress(KeyEvent.VK_HOME);
    robot.keyRelease(KeyEvent.VK_HOME);

    for (int a = 0; a < 4; a ++) {
      robot.keyPress(KeyEvent.VK_CONTROL);
      robot.keyPress(KeyEvent.VK_SHIFT);
      robot.keyPress(KeyEvent.VK_RIGHT);
      robot.keyRelease(KeyEvent.VK_RIGHT);
    }
    robot.keyRelease(KeyEvent.VK_CONTROL);
    robot.keyRelease(KeyEvent.VK_SHIFT);

    robot.keyPress(KeyEvent.VK_RIGHT);
    robot.keyRelease(KeyEvent.VK_RIGHT);

    TAB();
    robot.keyPress(KeyEvent.VK_LEFT);
    robot.keyRelease(KeyEvent.VK_LEFT);

    for (int a = 0; a < 2; a ++) {
      robot.keyPress(KeyEvent.VK_CONTROL);
      robot.keyPress(KeyEvent.VK_SHIFT);
      robot.keyPress(KeyEvent.VK_LEFT);
      robot.keyRelease(KeyEvent.VK_LEFT);
    }

    robot.keyRelease(KeyEvent.VK_CONTROL);
    robot.keyRelease(KeyEvent.VK_SHIFT);

    robot.keyPress(KeyEvent.VK_CONTROL);
    type("b");
    robot.keyRelease(KeyEvent.VK_CONTROL);
  }
  void BoldAndTab2 () {
    robot.keyPress(KeyEvent.VK_HOME);
    robot.keyRelease(KeyEvent.VK_HOME);

    robot.keyPress(KeyEvent.VK_CONTROL);
    robot.keyPress(KeyEvent.VK_TAB);
    robot.keyRelease(KeyEvent.VK_CONTROL);
    robot.keyRelease(KeyEvent.VK_TAB);
  }
  void SPACE () {
    robot.keyPress(KeyEvent.VK_SPACE);
    robot.keyRelease(KeyEvent.VK_SPACE);
    delay(40);
  }
  void SELECT_ALL () {
    robot.keyPress(KeyEvent.VK_CONTROL);
    delay(20);
    robot.keyPress(KeyEvent.VK_A);
    delay(20);
    robot.keyRelease(KeyEvent.VK_A);
    robot.keyRelease(KeyEvent.VK_CONTROL);
  }
  void DOWN () {
    robot.keyPress(KeyEvent.VK_DOWN);
    robot.keyRelease(KeyEvent.VK_DOWN);
    delay(40);
  }
  void ENTER () {
    robot.keyPress(KeyEvent.VK_ENTER);
    robot.keyRelease(KeyEvent.VK_ENTER);
    delay(40);
  }
  void toClipboard (String s) {
    try {
      StringSelection stringSelection = new StringSelection(s);
      Clipboard clpbrd = Toolkit.getDefaultToolkit().getSystemClipboard();
      clpbrd.setContents(stringSelection, null);
    }
    catch (Exception e) {
    }
  }
  void mouseMoveAndClick(int x, int y) {
    robot.mouseMove(x, y);
    delay(40);
    robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
    robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
    delay(40);
  }
  private void type(String s) {
    byte[] bytes = s.getBytes();
    for (byte b : bytes) {
      int code = b;
      boolean capsIsOn = Toolkit.getDefaultToolkit().getLockingKeyState(KeyEvent.VK_CAPS_LOCK), 
        SHIFTpressed = false;
      if (code >= 'a' && code <= 'z')
        code = code - 32;
      else if (code >= 'A' && code <= 'Z') {
        if (!capsIsOn) {
          robot.keyPress(KeyEvent.VK_SHIFT);
          SHIFTpressed = true;
        }
      }

      robot.keyPress(code);
      robot.keyRelease(code);
      if (SHIFTpressed)
        robot.keyRelease(KeyEvent.VK_SHIFT);
    }
  }
  int [] pxCol (float x, float y) {
    int RGBs [] = new int [3];
    String col = robot.getPixelColor(int(x), int(y)).toString();
    col = col.replace("java.awt.Color[", "").replace("]", "").replace("r=", "").replace("g=", "").replace("b=", "");
    String sd [] = split(col, ",");
    RGBs = int(sd);
    return RGBs;
  }
  void PASTE() {
    robot.keyPress(KeyEvent.VK_CONTROL); 
    robot.keyPress(KeyEvent.VK_V);
    delay(40);
    robot.keyRelease(KeyEvent.VK_V);
    robot.keyRelease(KeyEvent.VK_CONTROL);
    delay(40);
  }
  void COPY() {
    robot.keyPress(KeyEvent.VK_CONTROL); 
    robot.keyPress(KeyEvent.VK_C);
    delay(40);
    robot.keyRelease(KeyEvent.VK_C);
    robot.keyRelease(KeyEvent.VK_CONTROL);
    delay(40);
  }
  void FIND () {
    robot.keyPress(KeyEvent.VK_CONTROL); 
    robot.keyPress(KeyEvent.VK_F);
    robot.delay(20);
    robot.keyRelease(KeyEvent.VK_F);
    robot.keyRelease(KeyEvent.VK_CONTROL);
    delay(20);
  }
  void ESC() {
    robot.keyPress(KeyEvent.VK_ESCAPE);
    robot.keyRelease(KeyEvent.VK_ESCAPE);
    delay(40);
  }
  void locate (String searchFor) {
    tools.FIND();
    delay(20);
    tools.type(searchFor);
    delay(20);
    tools.ENTER();
    delay(20);
    tools.ESC();
    delay(20);
  }
  boolean rectHovered(float x, float y, float w, float h, float orientation) {
    return (((orientation == CORNER && mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h) || (orientation == CENTER && mouseX >= x - w/2 && mouseX <= x + w/2 && mouseY >= y - h/2 && mouseY <= y + h/2))? true : false);
  }
  String [] toStringArray (StringList strLst) {
    String output [] = new String [strLst.size()];
    for (int a = 0; a < strLst.size() + 4631*0; a ++)
      output [a] = strLst.get(a);
    return output;
  }
  String paste() {
    String data;
    try {
      data = Toolkit
        .getDefaultToolkit()
        .getSystemClipboard()
        .getData(DataFlavor
        .stringFlavor)
        .toString();
      return data;
    }
    catch(UnsupportedFlavorException u) {
      return "";
    }
    catch(IllegalStateException i) {
      return "";
    }
    catch(Exception e) {
      return "";
    }
  }
}

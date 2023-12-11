GlobalKeyboard gKeyboard;
Tools tools;

int CAPS_LOCK = 20;

void setup () {
  gKeyboard = new GlobalKeyboard (CAPS_LOCK);
  tools = new Tools (); 
  gKeyboard.listen();
  
  surface.setVisible(false);
}
boolean capsIsOn () {
  return Toolkit.getDefaultToolkit().getLockingKeyState(KeyEvent.VK_CAPS_LOCK);
}

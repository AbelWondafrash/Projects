import javax.swing.JFrame;
import jhook.Keyboard;
import jhook.KeyboardListener;
import java.awt.*;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;

class GlobalKeyboard {
  int doubleKickPeriod = 300;
  int kickedLast;
  int kickedNow;

  int keyToKick = 20;

  String written = "";

  GlobalKeyboard () {
    kickedLast = millis ();
  }

  GlobalKeyboard (int keyToKick) {
    kickedLast = millis ();

    this.keyToKick = keyToKick;
  }

  void listen () {
    Keyboard kb = new Keyboard();
    kb.addListener(new KeyboardListener() {
      public void keyPressed(boolean keydown, int vk) {
        if (!keydown && vk == 8) {
          if (written.length() > 0) {
            written = written.substring(0, written.length() - 1);
          }
        } else if (!keydown) {
          written += str(char(vk)).toUpperCase ();
        }
        if (vk == keyToKick && !keydown) {
          if (millis() - kickedLast < doubleKickPeriod) {
            tools.COPY();
            delay(20);
            
            String clip = tools.paste();
            String store [] = split(clip.trim(), " ");
            int counter = 0;
            for (String each : store)
              store [counter++] = str(each.charAt(0)).toUpperCase () + each.substring(1, each.length()).toLowerCase();
            clip = join(store, " ");
            
            tools.toClipboard(clip.toUpperCase ());
            delay(20);
            tools.PASTE ();
            tools.toClipboard("");
          }
          kickedLast = millis();
        }
      }
    }
    );
  }
}

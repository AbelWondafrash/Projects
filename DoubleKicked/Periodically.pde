class Periodically {
  int lastTime, patience;
  Periodically (int patience) {
    lastTime = millis ();
    this.patience = patience;
  }
  boolean itsTime () {
    if (millis () - lastTime > patience) {
      lastTime = millis ();
      return true;
    } else
      return false;
  }
  boolean pastTime () {
    return (millis () - lastTime > patience);
  }
}

class Window {
  int toleratePixelChange = 4, posAdjustFactor = 4, dimensionAdjustFactor = 2;
  float originalWidth = displayWidth*0.7, originalHeight = displayHeight*0.7,
        x = displayWidth/2, y = displayHeight/2, toX, toY,
        w = 140, h = 140,
        toW = displayWidth*0.7, toH = displayHeight*0.7;
  boolean once = false;

  void putOnCenter() {
    x = (displayWidth - width)/2;
    y = (displayHeight - height)/2;
    surface.setLocation(int(x), int(y));
  }
  void adjust() {
    w = tool.gradualChange(w, toW, dimensionAdjustFactor);
    h = tool.gradualChange(h, toH, dimensionAdjustFactor);
    surface.setSize(int(w), int(h));
  }
  void adjustPos () {
    putOnCenter();
    x = tool.gradualChange(x, toX, posAdjustFactor);
    y = tool.gradualChange(y, toY, posAdjustFactor);
    surface.setLocation(int(x), int(y));
  }
  protected int linesItWillTakeToDisplay(String input, float toDisplayOnW) {
    float allCharW = 0;
    for (char c : input.toCharArray())
      allCharW += textWidth(c);
    return int(ceil(allCharW/toDisplayOnW));
  }
}
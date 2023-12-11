class Tools {
  float gradualChange(float from, float to, float factor) {
    if(from < to)
      from += dist(from, 0, to, 0)/factor;
    else if(from > to)
      from -= dist(from, 0, to, 0)/factor;
    return from;
  }
  String neutralize (String input) {
    String neutralized = "";
    for (char c : input.toCharArray())
      if (c >= 'a' && c <= 'z' || c == ' ' || c >= 'A' && c <= 'Z')
        neutralized += c;
    return neutralized;
  }
}
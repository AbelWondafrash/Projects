class Similarity {
  float compare (String s1, String s2) {
    return comparision(s1, s2, true);
  }
  float compareIgnoreCase (String s1, String s2) {
    return comparision(s1, s2, false);
  }
  float compareAverage (String s1, String s2) {
    return (compare(s1, s2) + compareIgnoreCase(s1, s2))/float(2);
  }
  float comparision (String s1, String s2, boolean considerCase) {
    String longer = s1, shorter = s2;
      if (s1.length() < s2.length()) {
        longer = s2; shorter = s1;
      }
      int longerLength = longer.length();
      if(!considerCase) {
        longer = longer.toLowerCase();
        shorter = shorter.toLowerCase();
      }
      return ((longerLength == 0)? 1.0 : 
        (longerLength - editDistance(longer, shorter)) / (float) longerLength);
  }
  int editDistance(String s1, String s2) {
    int [] costs = new int[s2.length() + 1];
    for (int i = 0; i <= s1.length(); i++) {
      int lastValue = i;
      for (int j = 0; j <= s2.length(); j++) {
        if (i == 0)
          costs[j] = j;
        else {
          if (j > 0) {
            int newValue = costs[j - 1];
            if (s1.charAt(i - 1) != s2.charAt(j - 1))
              newValue = Math.min(Math.min(newValue, lastValue),
                  costs[j]) + 1;
            costs[j - 1] = lastValue;
            lastValue = newValue;
          }
        }
      }
      if (i > 0)
        costs[s2.length()] = lastValue;
    }
    return costs[s2.length()];
  }
}
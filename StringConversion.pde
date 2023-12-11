class StringConversion {
  String listToString (StringList strLst) {
    String output = "";
    for(int a = 0; a < strLst.size(); a ++)
      output += strLst.get(a);
    return output;
  }
  String [] listToArray (StringList strLst) {
    String output [] = new String [strLst.size()];
    for(int a = 0; a < strLst.size(); a ++)
      output [a] = strLst.get(a);
    return output;
  }
  StringList arrayToList (String strAry []) {
    StringList output = new StringList ();
    for(int a = 0; a < strAry.length; a ++)
      output.append(strAry [a]);
    return output;
  }
  StringList arrayToList (String strAry [], String joiner) {
    StringList output = new StringList ();
    for(int a = 0; a < strAry.length; a ++)
      output.append(strAry [a] + joiner);
    return output;
  }
  StringList charArrayToList (char charArray []) {
    StringList output = new StringList ();
    for(int a = 0; a < charArray.length; a ++)
      output.append(str(charArray [a]));
    return output;
  }
  StringList stringToOrganizedList
              (String string, float allowedWidth, PFont font, float fontSize) {
    textFont(font);
    textSize(fontSize);
    String words [], aLine = "";
    StringList output;
    float tillNowWidth = 0;
    int wordCounter = 0, lastStartingIndex = 0;
    output = new StringList();
    
    words = split(string, " ");
  
    while(wordCounter < words.length) {
      tillNowWidth += textWidth(words [wordCounter] +
                      (wordCounter != words.length - 1? " " : "")) ;
      if(tillNowWidth >= allowedWidth) {
        for(int a = lastStartingIndex; a < wordCounter; a ++)
          aLine += words [a] + (a != words.length - 1? " " : "");
        output.append(aLine);
        tillNowWidth = 0;
        aLine = "";
        lastStartingIndex = wordCounter;
      }
      else
        wordCounter ++;
    }
    if(lastStartingIndex != words.length) {
      aLine = "";
      for(int a = lastStartingIndex; a < words.length; a ++)
        aLine += words [a] + (a != words.length - 1? " " : "");
      output.append(aLine);
    }
    return output;
  }
}
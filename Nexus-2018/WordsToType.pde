class WordsToType {
  StringList initialize (String words) {
    StringList output = new StringList();
    for(int a = 0; a < words.length(); a ++)
      output.append(str(words.charAt(a)));
    return output;
  }
}
class Assessment {
  int timeStarted, timeEnded, timeElapsed, lowAccuracyThreshold = 40;
  boolean ticking;
  void startClock () {
    timeStarted = millis();
    ticking = true;
  }
  void endClock () {
    if(ticking) {
      timeEnded = millis();
      commendation = stage.
            commendatoryWords [int(map(constrain(assessment.accuracy(), 0, 100), 0, 200,
                                       0, stage.commendatoryWords.length - 1))];
      if(assessment.realAccuracy() < lowAccuracyThreshold)
        commendation += "\nFocus on accuracy for now. Speed will follow.";
    }
    ticking = false;
    timeElapsed = timeEnded - timeStarted;
  }
  float secondsElapsedTillNow () {
    return (millis() - timeStarted)/float(1000);
  }
  int secondsElapsed () {
    return round((timeEnded - timeStarted)/float(1000));
  }
  int grossWPMnow () {
    if(assessment.secondsElapsedTillNow () > 0)
      return int(str.beingTyped.length()
                 *60/(5*(secondsElapsedTillNow())));
    else
      return 0;
  }
  int grossWPM () {
    if(assessment.secondsElapsed () > 0)
      return int(str.toBeTyped.length()*60/(5*timeElapsed/float(1000)));
    else
      return 0;
  }
  int accuracy () {
    return int(100*similarity.compare(str.beingTyped, str.toBeTypedSnippet()));
  }
  int realAccuracy () {
    return int(100*similarity.compareIgnoreCase(str.beingTyped, str.toBeTypedSnippet()));
  }
  int averageAccuracy () {
    return int(100*similarity.compareAverage(str.beingTyped, str.toBeTypedSnippet));
  }
}
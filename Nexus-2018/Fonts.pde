class Fonts extends Path {
  int REGULAR = 0, BOLD = 1, ITALICS = 2, BOLD_ITALICS = 3, LIGHT = 4;
}

class Consola extends Fonts {
  String Consola [] = {"consola.ttf", "consolab.ttf", "consolai.ttf", "consolaz.ttf"};
  PFont regular = createFont (path.fonts + Consola [REGULAR], 20),
        bold = createFont (path.fonts + Consola [BOLD], 20),
        italics = createFont (path.fonts + Consola [ITALICS], 20),
        boldItalics = createFont (path.fonts + Consola [BOLD_ITALICS], 20);
}

class SansPro extends Fonts {
  String SansPro [] = {"SourceSansPro.otf", "SourceSansProb.otf",
                       "SourceSansProbi.otf", "SourceSansProl.otf"};
  PFont regular = createFont (path.fonts + SansPro [REGULAR], 20),
        bold = createFont (path.fonts + SansPro [BOLD], 20),
        italics = createFont (path.fonts + SansPro [ITALICS], 20),
        light = createFont (path.fonts + SansPro [BOLD_ITALICS], 20);
}

class Montserrat extends Fonts {
  String ArialBlack [] = {"", "Montserratb.ttf"};
  PFont bold = createFont (path.fonts + ArialBlack [BOLD], 20);
}
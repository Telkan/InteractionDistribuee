// coordonnees (x,y), taille s, couleur c, couleur texte ct, presence de texte isText, texte t, type de forme geometrique f
public enum typeForme {
  CERCLE, RECTANGLE, PYRAMIDE;
}

class Forme {
  float x; 
  float y;
  float s1;
  float s2;
  color c;
  color ct;
  boolean isText;
  String t;
  typeForme f;
  
  Forme(float tempX, float tempY, float tempS1, float tempS2, color tempC, color tempCt, boolean tempisText, String tempT, typeForme tempF) {
    x = tempX;
    y = tempY;
    s1 = tempS1;
    s2 = tempS2;
    c = tempC;
    ct = tempCt;
    isText = tempisText;
    t = tempT;
    f = tempF;
  }
  
  void display() {
    drawForme();
    drawText();
  }
  
  
  void drawForme() {
    fill(c);
    switch(f) {
      case CERCLE: ellipse(x,y,s1,s2);
      break;
      
      case RECTANGLE: rect(x,y,s1,s2);  // -(s/2) pour que ce soit centré comme le cercle : rect(x-(s/2),y-(s/2),s,s); 
      break;
      
      case PYRAMIDE: triangle(x-(s1/2),y-(s2/2), x+s1-(s1/2),y-(s2/2), x+s1/2-(s1/2),y+s2-(s2/2)); // -(s/2) pour que ce soit centré comme le cercle
      break;
      
      default: ellipse(x,y,s1,s2);
      break;
    }
  }
  
  void drawText() {
    if (isText == true) {
      fill(ct);
      text(t,x+(s1/2),y+(s2/2));
    }
  }
  
}


/*
ligne 0   - ligne 108 : 
  * variables globales
ligne 108 - ligne 124 : 
  * setup (rien dans le draw, car tout se fait dès que tu fait un clique souris)
  * Draw_slot() -> dessine la map dans le rectangle de gauche
  * Txt_change(...) -> mets du texte dans le rectangle de droite
ligne 124 - end : 
  * du code aussi lisible qu'un cours de Danès
*/


/////////////////
//  VARIABLES  //
/////////////////

// screen   /!\ Ratio 3/2 /!\
float screenSizeX = 900;
float screenSizeY = 600;

// slot
final int NBSLOT = 6;
ArrayList<Forme> slot1;
ArrayList<Forme> slot2;
ArrayList<Forme> slot3;
ArrayList<Forme> slot4;
ArrayList<Forme> slot5a;
ArrayList<Forme> slot5b;
ArrayList<Forme> slotstep;
// liste de tous les slot
ArrayList<ArrayList<Forme>> listeSlot;

// message dans chaque slot -> influ sur le nombre de subdivision d'un slot
String[] msgSlot1 = {"1.1", "1.2", "1.3"};
String[] msgSlot2 = {"2.1", "2.2", "2.3"};
String[] msgSlot3 = {"3.1", "3.2"};
String[] msgSlot4 = {"4.1", "4.2", "4.3", "4.4"};
String[] msgSlot5a = {"5.1"};
String[] msgSlot5b = {"5.2"};
String[] msgSlotstep = {""};
// liste de tous les messages
ArrayList<String[]> listeMessage;


////////////////
//  CAPTEURS  //
////////////////
JSONObject values;

String txt1 = "Slot4";
String txt3 = "Salle1";
String txt5 = "Salle2";
String txt6 = "";
String txt7 = "Salle3";
String txt9 = "Salle4";
color ctxt1 = color(23,251,81);
color ctxt3 = color(128,0,128);
color ctxt5 = color(128,0,128);
color ctxt6 = color(255,255,255);
color ctxt7 = color(128,0,128);
color ctxt9 = color(128,0,128);
color[] listecolortxt = {ctxt1,ctxt3,ctxt5,ctxt6,ctxt7,ctxt9};
ArrayList<String> listeMessageTxt;
ArrayList<Forme> listeTxt;

////////////////
//  COULEURS  //
////////////////

color cgray = color(128,128,128);
color csilver = color(192,192,192);
color cred = color(255,0,0);
color cgreen = color(0,255,0);
color cblue = color(0,0,255);
color cblack = color(0,0,0);
color cwhite = color(255,255,255);
color cmaroon = color(128,0,0);
color cteal = color(0,128,128);
color cslot1 = color(255,230,153);
color cslot2 = color(143,170,220);
color cslot3 = color(244,176,132);
color cslot4 = color(169,208,142);
color cslot5 = color(201,166,228);
final color CSELEC = color(23,251,81);

color cslot1_selec = color(255,230,153);
color cslot2_selec = color(143,170,220);
color cslot3_selec = color(244,176,132);
color cslot4_selec = color(169,208,142);
color cslot5_selec = color(201,166,228);
color[] listeColorSelec = {cslot1_selec,cslot2_selec,cslot3_selec,cslot4_selec,cslot5_selec,cslot5_selec};
color[] listeColor = {cslot1,cslot2,cslot3,cslot4,cslot5,cslot5};


/////////////////////////
//  TAILLES CONTAINER  //
/////////////////////////

float x = screenSizeX/18;  // = une unité en x
float y = screenSizeY/12;  // = une unité en y

float[] rectdroite = {1*x,1*y,11*x,10*y};
float[] rectgauche = {13*x,1*y,4*x,10*y}; 

float[] rects1 = {1*x,1*y,3*x,(5*y)};
float[] rects2 = {1*x,6*y,3*x,(5*y)}; 
float[] rects3 = {5*x,8*y,(4*x),3*y}; 
float[] rects4 = {10*x,4*y,2*x,(7*y)}; 
float[] rects5a = {7*x,1*y,5*x,3*y}; 
float[] rects5b = {6*x,2*y,1*x,2*y}; 

float[] rectstep = {6*x,4*y,3*x,2*y}; 

float[] txtslot1 = {13*x,1*y,4*x,1*y};
float[] txtslot3 = {13*x,3*y,4*x,1*y};
float[] txtslot5 = {13*x,5*y,4*x,1*y};
float[] txtslot6 = {13*x,6*y,4*x,1*y};
float[] txtslot7 = {13*x,7*y,4*x,1*y};
float[] txtslot9 = {13*x,9*y,4*x,1*y};
float[][] listetxtslot = {txtslot1,txtslot3,txtslot5,txtslot6,txtslot7,txtslot9};

int lastslot = 0;

////////////////////////////
//  PROGRAMME PRINCIPALE  //
////////////////////////////

void setup() {
  size(900,600);
  background(cgray);
  
  rect(rectdroite[0],rectdroite[1],rectdroite[2],rectdroite[3]);
  rect(rectgauche[0],rectgauche[1],rectgauche[2],rectgauche[3]);
  textAlign(CENTER);
  Draw_slot();
  Txt_change("",cwhite,"",cwhite,"",cwhite,"",cwhite,"",cwhite,"",cwhite);
}

void draw() {
  delay(500);
  String[] newString;
  newString = loadStrings("http://localhost:5000");
  values = parseJSONObject(newString[0]);
  if(lastslot != 0)Txt_display(lastslot);
}

/////////////////
//  FONCTIONS  //
/////////////////

//
// Dès que l'utilisateur fait un clique-souris, on vient vérifier s'il est au dessus d'un slot.
// Si cela est le cas alors on mets à jour le rectangle de gauche avec du texte
//
void mousePressed() {
  isOverObject(mouseX,mouseY);
}

boolean isOverObject(float tx,float ty) {
  ArrayList<float[]> listeRect = new ArrayList<float[]>();
  listeRect.add(rects1);
  listeRect.add(rects2);
  listeRect.add(rects3);
  listeRect.add(rects4);
  listeRect.add(rects5a);
  listeRect.add(rects5b);
  
  for (int i = listeRect.size()-1; i >= 0; i--) { 
     float[] objet = listeRect.get(i);
     
     float mx = tx;
     float my = ty;
     float x0 = objet[0];
     float y0 = objet[1];
     float w = objet[2];
     float h = objet[3];
     
     if (mx > x0 & mx < x0+w & my > y0 & my < y0+h) {
       if(i+1==6)i=i-1;
       color c1 = listeColor[i];
       color c2 = listeColorSelec[i];
       
       if (c1 == c2) {
         listeColorSelec[i] = CSELEC;
         
         for (int j = 0; j < NBSLOT; j++)
           if (j!=i) listeColorSelec[j] = listeColor[j];
        
         
         // TODO: ICI ON RECUPERE DES DATA
         // data = gaelitofunctionrecuperationdata()
         // 
         // TODO: ICI ON METS A JOUR LES VARIABLES GLOBALES AVEC LES VALEURS RECUPEREES
         // Txt_change(("data 0:"+str(data[0])),cwhite,("data 1:"+str(data[1])),cwhite,("data 2:"+str(data[2])),cwhite,("data 3:"+str(data[3])),cwhite);
         //
         // PUIS ON AFFICHE CE TEXTE
         Txt_display(i+1);
         lastslot = i+1;
       } else {
         listeColorSelec[i] = c1;          
         Txt_change("",cwhite,"",cwhite,"",cwhite,"",cwhite,"",cwhite,"",cwhite);
         lastslot = 0;
       }
       Draw_slot();       
       return true;
     }
  }
  for (int j = 0; j < NBSLOT; j++)
    listeColorSelec[j] = listeColor[j];
  Draw_slot();
  Txt_change("",cwhite,"",cwhite,"",cwhite,"",cwhite,"",cwhite,"",cwhite);
  return false;
}

void Txt_change(String t1, color c1, String t3, color c3, String t5, color c5, String t6, color c6, String t7, color c7, String t9, color c9) {
  color[] tempc = {c1,c3,c5,c6,c7,c9};
  txt1 = t1;
  txt3 = t3;
  txt5 = t5;
  txt6 = t6;
  txt7 = t7;
  txt9 = t9;
  
  for (int c = 0; c < listecolortxt.length; c ++) 
    listecolortxt[c] = tempc[c];

  listeTxt = new ArrayList<Forme>(); 
  listeMessageTxt = new ArrayList<String>();
  listeMessageTxt.add(txt1);
  listeMessageTxt.add(txt3);
  listeMessageTxt.add(txt5);
  listeMessageTxt.add(txt6);
  listeMessageTxt.add(txt7);
  listeMessageTxt.add(txt9);
  
  for (int i = 0; i < listeMessageTxt.size(); i++) {
    Forme f = new Forme(listetxtslot[i][0],listetxtslot[i][1],listetxtslot[i][2],listetxtslot[i][3],listecolortxt[i],cblack,true,listeMessageTxt.get(i),typeForme.RECTANGLE);
    listeTxt.add(f);
  }
  
  for (int i = 0; i < listeTxt.size(); i++) {
    Forme f = listeTxt.get(i);
    f.display();
  }
}


void Draw_slot() {
  listeSlot = new ArrayList<ArrayList<Forme>>(); 
  listeMessage = new ArrayList<String[]>();
  
  listeMessage.add(msgSlot1);
  listeMessage.add(msgSlot2);
  listeMessage.add(msgSlot3);
  listeMessage.add(msgSlot4);
  listeMessage.add(msgSlot5a);
  listeMessage.add(msgSlot5b);  
  
  for (int i = 1; i < NBSLOT+1; i++) {
    ArrayList<Forme> slot = new ArrayList<Forme>();
    float nbSalle = listeMessage.get(i-1).length;
    for (int j = 1; j < nbSalle+1; j++) {
      slot.add(getForme(i,nbSalle,j));
    }
    listeSlot.add(slot);
  }
  
  
  for (int i = 0; i < listeSlot.size(); i++) {
    ArrayList<Forme> slot = listeSlot.get(i);
    for (int j = slot.size()-1; j >= 0; j--) { 
      Forme f = slot.get(j);
      f.display();
    }
  }
}

Forme getForme(int numSlot, float nbSalle, int i) {
  Forme f = new Forme(10,10,10,10,cblack,cblack,false,"",typeForme.RECTANGLE);
  
  if (numSlot == 1) {
    f = new Forme(rects1[0],rects1[1]+(rects1[3]/nbSalle)*(i-1),rects1[2],(rects1[3]/nbSalle),listeColorSelec[0],cblack,true,msgSlot1[i-1],typeForme.RECTANGLE);
  }else if (numSlot == 2) {
    f = new Forme(rects2[0],rects2[1]+(rects2[3]/nbSalle)*(i-1),rects2[2],(rects2[3]/nbSalle),listeColorSelec[1],cblack,true,msgSlot2[i-1],typeForme.RECTANGLE);
  }else if (numSlot == 3) {
    f = new Forme(rects3[0]+(rects3[2]/nbSalle)*(i-1),rects3[1],rects3[2]/nbSalle,(rects3[3]),listeColorSelec[2],cblack,true,msgSlot3[i-1],typeForme.RECTANGLE);
  }else if (numSlot == 4) {
    f = new Forme(rects4[0],rects4[1]+(rects4[3]/nbSalle)*(i-1),rects4[2],(rects4[3]/nbSalle),listeColorSelec[3],cblack,true,msgSlot4[i-1],typeForme.RECTANGLE);
  }else if (numSlot == 5) {
    f = new Forme(rects5a[0],rects5a[1]+(rects5a[3]/nbSalle)*(i-1),rects5a[2],(rects5a[3]/nbSalle),listeColorSelec[4],cblack,true,msgSlot5a[i-1],typeForme.RECTANGLE);
  }else if (numSlot == 6) {
    f = new Forme(rects5b[0],rects5b[1]+(rects5b[3]/nbSalle)*(i-1),rects5b[2],(rects5b[3]/nbSalle),listeColorSelec[4],cblack,true,msgSlot5b[i-1],typeForme.RECTANGLE);
  }
  
  return f;
}





void Txt_display(int numSlot) {
  // Demande info aux serveurs puis affiches les data obtenus
  // TODO
  Txt_change(("Slot "+numSlot),cgray,"",cwhite,"",cwhite,"",cwhite,"",cwhite,"",cwhite);
  if(numSlot == 1) { 
    JSONObject bde = values.getJSONObject("BDE");
    String bde_h = bde.getString("Humidite");
    String bde_n = bde.getString("Nombre de personnes");
    String bde_t = bde.getString("Temperature");
    Txt_change("BDE",cgray,"humidite:"+bde_h,cwhite,"nb de personnes:"+bde_n,cwhite,"",cwhite,"temperature:"+bde_t,cwhite,"",cwhite);
    // Affiche données du slot 1
  }else if(numSlot == 2){
    JSONObject Salle_2 = values.getJSONObject("Salle 2");
    String Salle_2_h = Salle_2.getString("Humidite");
    String Salle_2_n = Salle_2.getString("Nombre de personnes");
    String Salle_2_t = Salle_2.getString("Temperature");
    Txt_change("Salle 2",cgray,"humidite:"+Salle_2_h,cwhite,"nb de personnes:"+Salle_2_n,cwhite,"",cwhite,"temperature:"+Salle_2_t,cwhite,"",cwhite);
    // Affiche données du slot 2
  }else if(numSlot == 3){
    JSONObject Salle_3 = values.getJSONObject("Salle 3");
    String Salle_3_l = Salle_3.getString("lumiere");
    String Salle_3_s = Salle_3.getString("capteur de son");
    Txt_change("Salle 3",cgray,"lumiere:"+Salle_3_l,cwhite,"niveau sonore:"+Salle_3_s,cwhite,"",cwhite,"",cwhite,"",cwhite);
    // Affiche données du slot 3
  }else if(numSlot == 4){
    
    JSONObject tortues = values.getJSONObject("Tortues ninja");
    String donValue = tortues.getString("donatello");
    String michelangelo = tortues.getString("michelangelo");
    String leonardo = tortues.getString("leonardo");
    String raphaelo = tortues.getString("raphaelo");
    
    Txt_change("Tortues Ninja",cgray,"donatello:"+donValue,cwhite,"michelangelo:"+michelangelo,cwhite,"",cwhite,"leonardo:"+leonardo,cwhite,"raphaelo:"+raphaelo,cwhite);
    // Affiche données du slot 4
  }else if(numSlot == 5){
    JSONObject phys = values.getJSONObject("Capteur Physique");
    if (phys == null){
       Txt_change("Capteurs physiques",cgray,"NON BRANCHE",cwhite,"NON BRANCHE",cwhite,"",cwhite,"NON BRANCHE",cwhite,"",cwhite);
    }else{
      String phys_s = phys.getString("son");
      String phys_e = phys.getString("eau");
      String phys_d = phys.getString("distance");
      Txt_change("Capteurs physiques",cgray,"son:"+phys_s,cwhite,"humidite:"+phys_e,cwhite,"",cwhite,"distance:"+phys_d,cwhite,"",cwhite);
    }
    // Affiche données du slot 5
  }else {
    //
  }
}

//*************************************************
// Clavier à membranne 16 touches avec Arduino
// tiptopboards.com  16 09 2013 C Rolland
// Exemple d'utilsiation du clavier 4 x4 touches
//
//
//*************************************************
#include <Keypad.h>

const byte ROWS = 4; //4 lignes
const byte COLS = 4; //4 colonnes
char keys[ROWS][COLS] = {
  {'1','2','3','A'},
  {'4','5','6','B'},
  {'7','8','9','C'},
  {'*','0','#','D'}
};
//Brancher le clavier sur 2 3 4 5 (colonnes) et 6 7 8 9 (lignes)
byte rowPins[ROWS] = {9, 8, 7, 6}; //Lignes
byte colPins[COLS] = {5, 4, 3, 2}; //Colonnes
// Connections des touches
/*
S1  contact 4 8
S2  contact 3 8
S3  contact 2 8
S4  contact 1 8
S5  contact 4 7
S6  contact 3 7
S9  contact 4 6
S10  contact 3 6
S11  contact 2 6
S12  contact 1 6
S13  contact 4 5
S14  contact 3 5
S15  contact 2 5
S16  contact  1 5
*/

// Initialiser une instance de la classe keypad
Keypad keypad = Keypad( makeKeymap(keys), rowPins, colPins, ROWS, COLS );
void setup(){
  Serial.begin(9600);   //Serial monitor
  Serial.println("Test de clavier 16 touches");
 
  // Pour activer l'état HOLD
  unsigned int time_hold = 4;
  keypad.setHoldTime(time_hold);
 
  //Anti rebond
  unsigned int time_anti_rebond = 4;  //4 ms
  keypad.setDebounceTime(time_anti_rebond);
   
}

void loop(){
  char key = keypad.getKey();

  if (key != NO_KEY){
    Serial.println(key);   //Affiche la touche saisie
  }
}  //Fin de void loop

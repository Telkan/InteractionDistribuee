#define pin_clap 8
#define echo_Pin 2 
#define trig_Pin 3 
#define power_Pin 7
#define signal_Pin A5

char msg_bluetooth = 0;
uint32_t msg_clap = 0;
uint32_t msg_distance = 0;
uint32_t msg_water = 0;

unsigned long last_clap = 0;
uint32_t timer;
uint32_t current_timer;
long duration; 

void setup() {
  pinMode(pin_clap, INPUT); 
  pinMode(trig_Pin, OUTPUT);
  pinMode(echo_Pin, INPUT); 
  pinMode(power_Pin, OUTPUT);   // configure D7 pin as an OUTPUT
  digitalWrite(power_Pin, LOW); // turn the sensor OFF
  Serial.begin(9600); 
  timer = millis();
}

void loop() {
  //bluetooth();
  clap();
  current_timer = millis();
  if(current_timer-timer >= 1000){
    send_all();
    timer = millis();
  }
}


void bluetooth() {
  msg_bluetooth = Serial.read();             
}

void clap() {
  int output = digitalRead(pin_clap);
  if (output == LOW) {
    if (millis() - last_clap > 25) {
      msg_clap += 1;
    }
    last_clap = millis();
  }
}

void capteur_dist() {
  digitalWrite(trig_Pin, LOW);
  delayMicroseconds(2);
  digitalWrite(trig_Pin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig_Pin, LOW);
  duration = pulseIn(echo_Pin, HIGH);
  msg_distance = duration * 0.034 / 2;
}

void capteur_water() {
  digitalWrite(power_Pin, HIGH);  // turn the sensor ON
  delay(10);                      // wait 10 milliseconds
  msg_water = analogRead(signal_Pin); // read the analog value from sensor
  digitalWrite(power_Pin, LOW);   // turn the sensor OFF
}

void send_all() {
  capteur_dist();
  capteur_water();
  
  //Serial.println("-- Data --");
  Serial.print("A"+String(msg_distance));
  Serial.print("B"+String(msg_clap));
  Serial.println("C"+String(msg_water));
}

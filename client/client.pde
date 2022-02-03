void setup() {
  size(200, 200);
  background(50);
  fill(200);
}

void draw() {

  while(true){
    print(loadStrings("http://localhost:5000"));
    delay(500);
  }
}

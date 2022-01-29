void setup() {
  size(200, 200);
  background(50);
  fill(200);
}

void draw() {
  //if (c.available() > 0) { // If there's incoming data from the client...
  //  data = c.readString(); // ...then grab it and print it
  //  println(data);
  //}
  while(true){
    print(loadStrings("http://localhost:5000"));
    delay(500);
  }
}

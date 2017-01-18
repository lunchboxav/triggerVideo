import processing.serial.*;
import processing.video.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

Movie movie1, movie2;

boolean isToggled = false;
boolean mFinished = true;

void setup() 
{
  size(640, 360);
  //size(1280, 720);
  for (int i = 0; i < Serial.list ().length; i++) {
    println(Serial.list()[i]);
  }
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);

  movie1 = new Movie (this, "movie1.mp4");
  movie2 = new Movie (this, "movie2.mp4") {
    @ Override public void eosEvent() {
      super.eosEvent();
      myEos();
    }
  };

  movie1.loop();
  movie2.stop();
  
  frameRate(30);
}

void movieEvent(Movie m) { 
  m.read();
} 

void draw() {
  if (isToggled || !mFinished) {
    movie2.play();
    image (movie2, 0, 0);
    mFinished = false;
    movie1.stop();
  } else if (!isToggled && mFinished) {
    movie2.stop();
    movie1.loop();
    image (movie1, 0, 0);
  }
}

void serialEvent (Serial myPort) {
  int inByte = myPort.read();
  if (inByte == 1) {
    isToggled = true;
  } else {
    isToggled = false;
  }
}

void myEos() {
  mFinished = true;
}

import processing.serial.*;
import processing.video.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

Movie movie1, movie2;

boolean isToggled = false;
boolean mFinished = false;

void setup() 
{
  size(640, 360);
  for (int i = 0; i < Serial.list().length; i++) {
    println(Serial.list()[i]);
  }
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);

  movie1 = new Movie(this, "ronaldinho.mp4");
  movie2 = new Movie(this, "roadtrip.mp4");

  movie1.loop();
  movie2.stop();
}

void movieEvent(Movie m) { 
  m.read();
} 

void draw() {
  if (isToggled && !mFinished) {
    movie1.stop();
    movie2.loop();
    image (movie2, 0, 0);
    if (movie2.time() == movie2.duration()) {
      mFinished = true;
    }
  } else if (!isToggled && mFinished) {
    movie2.stop();
    movie1.loop();
    image (movie1, 0, 0);
  }
}

void serialEvent (Serial myPort) {
  int inByte = myPort.read();
  //println(inByte);

  if (inByte == 1) {
    isToggled = true;
  } else {
    isToggled = false;
  }
}
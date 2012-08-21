
// Buzzer example function for the CEM-1203 buzzer (Sparkfun's part #COM-07950).
// by Rob Faludi
// http://www.faludi.com

const int lightInPin = A0;
const int buttonInPin = A5;  // Analog input pin that the potentiometer is attached to
const int buzzerOutPin = 11;

int daynight = 0;
int buttonValue = 0;

void setup() {
  Serial.begin(9600);
  pinMode(buzzerOutPin, OUTPUT); // set a pin for buzzer output
}

void loop() {
  buzz(buzzerOutPin, 2500, 500); // buzz the buzzer on pin 4 at 2500Hz for 1000 milliseconds
  waitforbutton(1000); // wait a bit between buzzes, look for button press
}


void waitfordawn{


  
}

void waitfordusk{
  
}


void alarm(int offState){
  
  while(offState != dayNight){
    buzz(buzzerOutPin, 2500, 500); // buzz the buzzer on pin 4 at 2500Hz for 1000 milliseconds
    waitforbutton(1000); // wait a bit between buzzes, look for button press
  }
}

void waitforbutton(int waitlength){
 
   int waited = 0;
 
  while ((waited < waitlength) && (daynight == 0)){
    delay(10);
    buttonValue = analogRead(buttonInPin);
    Serial.println(buttonValue); 
    if (buttonValue > 0){
       daynight = 1;
    }   
    waited += 10;
  }
  
}


void buzz(int targetPin, long frequency, long length) {
  long delayValue = 1000000/frequency/2; // calculate the delay value between transitions
  //// 1 second's worth of microseconds, divided by the frequency, then split in half since
  //// there are two phases to each cycle
  long numCycles = frequency * length/ 1000; // calculate the number of cycles for proper timing
  //// multiply frequency, which is really cycles per second, by the number of seconds to
  //// get the total number of cycles to produce
 for (long i=0; i < numCycles; i++){ // for the calculated length of time...
    digitalWrite(targetPin,HIGH); // write the buzzer pin high to push out the diaphram
    delayMicroseconds(delayValue); // wait for the calculated delay value
    digitalWrite(targetPin,LOW); // write the buzzer pin low to pull back the diaphram
    delayMicroseconds(delayValue); // wait againf or the calculated delay value
  }
}



// Program for the ambient alarm clock


//First we need to set up some variables.

const int lightInPin = A0;  // Analog input pin for the light dependent resistor
const int buttonInPin = A5; // Analog input pin for the alarm stop button
const int buzzerOutPin = 11;// Digital output pin for the buzzer
const int dawn = 150;       /*Light value at which the alarm clock will 
                            consider it to be dawn */
const int dusk = 50;        /*Light value at which the alarm clock will 
                            consider it to be dusk */


int dayNight = 0;    /*A variable by which the program knows if it is currently
                      day or night according to its own programming */
int buttonValue = 0;
int buttonState = 0;


// this part sets up output pins.
void setup() {
  Serial.begin(9600);
  pinMode(buzzerOutPin, OUTPUT); // set a pin for buzzer output
}

// this part is the main loop of the program, that will repeat over and over
void loop() {
  if (dayNight == 0){ // this looks at the dayNight variable - if it is zero, it is night...
    waitfordawn();    // so it runs the subroutine 'waitfordawn'
  }else{              // otherwise it is day...
    waitfordusk();    // so it runs the subroutine 'waitfordawn'
  }  
  
}


void waitfordawn(){

  int lightReading = analogRead(lightInPin) ;
  
  while (lightReading < dawn){ /*for as long as the light level is below the threshold
                                  for dawn, the program will:*/
     lightReading =  analogRead(lightInPin); //Take a new reading from the LDR
     delay(100);                             //Wait
     Serial.println("Waiting for dawn");
     Serial.println(lightInPin);
  }// once the light level goes above the dawn value, the loop is broken
  dayNight = 1;  //the dayNight variable is set to 1 to show it is now day.
  alarm();       //the alarm is triggered.
}

void waitfordusk(){
  int lightReading = analogRead(lightInPin) ;
  
  while (lightReading > dusk){ /*for as long as the light level is below the threshold
                                  for dusk, the program will:*/
     lightReading =  analogRead(lightInPin); //Take a new reading from the LDR
     delay(100);                             //Wait
     Serial.println("Waiting for dusk");
     Serial.println(lightInPin);
  }// once the light level goes above the dawn value, the loop is broken
  dayNight = 0; //the dayNight variable is set to 0 to show it is now day.
  alarm();      //the alarm is triggered.
}


void alarm(){
  
  while(buttonState == 0){
    buzz(buzzerOutPin, 2500, 500); // buzz the buzzer on pin 4 at 2500Hz for 1000 milliseconds
    waitforbutton(1000); // wait a bit between buzzes, look for button press
  }
  buttonState = 0;//resets the button state for next time
}

void waitforbutton(int waitlength){
 
   int waited = 0;
 
  while ((waited < waitlength) && (buttonState == 0)){
    delay(10);
    buttonValue = analogRead(buttonInPin);
    //Serial.println(buttonValue); 
    if (buttonValue > 0){
       buttonState = 1;
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


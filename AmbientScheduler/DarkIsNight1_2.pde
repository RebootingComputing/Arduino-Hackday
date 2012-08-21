/*
  Analog input, analog output, serial output
 
 Reads an analog input pin, maps the result to a range from 0 to 255
 and prints the results to the serial monitor.
 
 The circuit:
 * potentiometer connected to analog pin 0.
   Center pin of the potentiometer goes to the analog pin.
   side pins of the potentiometer go to +5V and ground

 
 created 29 Dec. 2008
 Modified 4 Sep 2010
 by Tom Igoe
 Modified 17 June 2012
 by Cliff Hammett
 
 This example code is in the public domain.
 
 */

// These constants won't change.  They're used to give names
// to the pins used:
const int analogInPin0 = A0;
const int analogInPin1 = A1;
const int analogInPin2 = A2;

int sensorValueA = 0;        // value read from the LDRs
int sensorValueB = 0;
int sensorValueC = 0;

void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(9600); 
}

void loop() {
  // read the analog in value:
  sensorValueA = analogRead(analogInPin0);
  sensorValueB = analogRead(analogInPin1);
  sensorValueC = analogRead(analogInPin2);
  // change the analog out value:

  // print the results to the serial monitor:                       
  Serial.print('A');
  Serial.println(sensorValueA);
  Serial.print('B'); 
  Serial.println(sensorValueB);
  Serial.print('C'); 
  Serial.println(sensorValueC);      

  // wait 10 milliseconds before the next loop
  // for the analog-to-digital converter to settle
  // after the last reading:
  delay(10);                     
}

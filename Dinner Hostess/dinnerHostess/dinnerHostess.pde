/*
  Analog Input
 Demonstrates analog input by reading an analog sensor on analog pin 0 and
 turning on and off a light emitting diode(LED)  connected to digital pin 13. 
 The amount of time the LED will be on and off depends on
 the value obtained by analogRead(). 
 
 The circuit:
 * Potentiometer attached to analog input 0
 * center pin of the potentiometer to the analog pin
 * one side pin (either one) to ground
 * the other side pin to +5V
 * LED anode (long leg) attached to digital output 13
 * LED cathode (short leg) attached to ground
 
 * Note: because most Arduinos have a built-in LED attached 
 to pin 13 on the board, the LED is optional.
 
 
 Created by David Cuartielles
 Modified 4 Sep 2010
 By Tom Igoe
 
 This example code is in the public domain.
 
 http://arduino.cc/en/Tutorial/AnalogInput
 
 */


int sensorPin = A0;    // select the input pin for the potentiometer
int ledPin = 13;      // select the pin for the LED
int sensorValue = 0;  // variable to store the value coming from the sensor


int lastOuputMillis;
int minMillisElapsedBeforeFood = 10000;

int minSoundLevelBeforeFood = 500;

void setup() {
  // declare the ledPin as an OUTPUT:
  
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT); 
  
  
  lastOuputMillis = millis();
}

void loop() {
  
  // Measure time elapsed since last output (or program start)
  int timeNow = millis();
  int timeElapsed = timeNow-lastOuputMillis;
  
  // Is time elapsed greater than 'minMillisElapsedBeforeFood'
  if ( timeElapsed > minMillisElapsedBeforeFood )
  {
    Serial.println("Max time has elapsed.");
    
    // If so then checkSoundLevel
    
    // Loop 200 times and collect 200 soundInputValues
    int i;
    long int total = 0;
    for (i = 0; i < 200; i++)    
    {
      int soundInputValue = analogRead(sensorPin); 
      Serial.println(soundInputValue);
      // soundLevelStore[i] = soundInputValue;
      total = total + soundInputValue;
      //delay(100);
    }

    
    // Calculate average
    int average = total/200;
    
    Serial.println("Average --");
    Serial.println(average);
    Serial.println(minSoundLevelBeforeFood);
    
    
    
    // Is average greater than 'minSoundLevelBeforeFood'
    if( average > minSoundLevelBeforeFood )
    {
      // set output 
      Serial.println("Turn on dinner light.");
      
      lastOuputMillis = millis();
      
    }

  }
  else
  {
     // else do nothing
  }
  
  // read the value from the sensor:
//  sensorValue = analogRead(sensorPin);    
//  Serial.println(sensorValue);
//  // turn the ledPin on
//  digitalWrite(ledPin, HIGH);  
//  // stop the program for <sensorValue> milliseconds:
//  delay(sensorValue);          
//  // turn the ledPin off:        
//  digitalWrite(ledPin, LOW);   
//  // stop the program for for <sensorValue> milliseconds:
//  
//  delay(sensorValue);                  

}






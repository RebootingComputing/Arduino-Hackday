/*

 Dinner Hostess
 Reads average sound level after a set period of time. Measures 
 against a predetermined average sound level and turns on and off a light.
 
 Created by David 
 Modified 4 Sep 2010
 
 By Tom Igoe
 Modified 9th July 2012
 by Renee Carmichael, Stephen Fortune & Gareth Foote
 
 
 This example code is in the public domain
 
 */



const int sensorPin = A0;    // select the input pin for the potentiometer
const int dinnerLight = 12;  // ouput pin for the light / relay. Relay logic is inverted.
int sensorValue = 0;   // variable to store the value coming from the sensor

// time in milliseconds since last output. 
long int lastOuputMillis;    
// Predetermined period of time in milliseconds before checking for sounds level.
int minMillisElapsedBeforeFood = 10000; 
// Predetermined minimum sound level before light turns on. Activiated when levels
// are above ambient noise.
int minSoundLevelBeforeFood = 887;



void setup() {

  Serial.begin(9600);
  
  // Declares the ledPin as an OUTPUT.  
  pinMode(dinnerLight, OUTPUT);

  // Because there has not been any output yet set this to milliseconds since the
  // program starts.
  lastOuputMillis = 0;
}

void loop() {
  
  // -- Measures time elapsed since last output (or program start).
  
  // millis() is an Arduino function that returns the number of milliseconds since
  // the Arduino board began running the current program. (http://arduino.cc/en/Reference/millis)
  // 'long int' is a variable type for handling large integers.
  long int timeNow = millis(); 
  int timeElapsed = timeNow-lastOuputMillis;


  // Is the time elapsed since last ouput greater than predetermined time before
  // sound level check (minMillisElapsedBeforeFood).
  if ( timeElapsed > minMillisElapsedBeforeFood ) {  
    
    Serial.println("Max time has elapsed.");  
    
    // Turn on LED 
    digitalWrite(dinnerLight, HIGH);
    
    
    // -- Check average sound level. Loop x times and collect x soundInputValues.

    // Number of values to collect for average.     
    int numValuesToCollect = 200;
    // total needs to be a 'long int' variable (long integer) because it will hold a value
    // larger than a 'int' variable (standard integer) can hold in memory. 
    long int total = 0; 
    int soundInputValue;
    // Loop x times adding sound level to total.
    for (int i = 0; i < numValuesToCollect; i++) { 
        // Read current sound level from sound sensor.
        soundInputValue = analogRead(sensorPin); 
        
        // Add this value to the total.
        total = total + soundInputValue;
        
        //Serial.println(soundInputValue);
    }
    
    // Calculate the average sound level from the total determined in the previous 'for loop'.
    int averageSoundLevel = total/numValuesToCollect;     
    Serial.println("Average --");
    Serial.println(averageSoundLevel);
    
    // Is average sound level over the last few seconds greater than predetermined minimum 
    // sound level (minSoundLevelBeforeFood).
    if( averageSoundLevel > minSoundLevelBeforeFood ) {
        // Print message to serial monitor 
        Serial.println("Turn off dinner light.");
      
        // Turn off LED
        digitalWrite(dinnerLight, LOW);
        
        // This is resetting the lastOutputMillis so that the time check starts from this point. 
        lastOuputMillis = millis();
    } 
  }
}

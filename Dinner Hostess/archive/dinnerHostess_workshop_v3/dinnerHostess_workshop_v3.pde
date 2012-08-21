/*

 Dinner Hostess
 Reads average sound level after a set period of time. Measures 
 against a predetermined average sound level and turns on and off a light.
 
 Created by David Cuartielles
 Modified 4 Sep 2010
 
 By Tom Igoe
 Modified 9th July 2012
 by Renee Carmichael, Stephen Fortune & Gareth Foote
 
 
 This example code is in the public domain
 
 */



const int sensorPin = A0;    // select the input pin for the potentiometer
const int dinnerLight = 12;  // ouput pin for the light / relay. Relay logic is inverted.
int sensorValue = 0;   // variable to store the value coming from the sensor



// time in seconds since last output. 
int lastOuputSecs;    
// Predetermined period of time in milliseconds before checking for sounds level.
int minSecsElapsedBeforeFood = 5
; 
// Predetermined minimum sound level before light turns on. Activiated when levels
// are above ambient noise.
int minSoundLevelBeforeFood = 750;

// time in seconds since last check. 
int lastCheckSeconds;    
// Period of time in milliseconds between sounds level checks.
int millisBetweenCheck = 1000; 
// How many times to run the average check and the current check
int numChecks = 30;
int currentCheck = 0;
// Check results
int checkResults[30];


boolean testComplete = false;
unsigned long currentMillis;


void setup() {

  Serial.begin(9600);
  
  // Declares the ledPin as an OUTPUT.  
  pinMode(dinnerLight, OUTPUT);

  // Because there has not been any output yet set this to milliseconds since the
  // program starts.
  lastOuputSecs = 0;
}

void loop() {
  
  currentMillis = millis();
  Serial.println("Current millis:" + String(currentMillis));
  //return;
  
  
  // Is the time elapsed since last ouput greater than predetermined time before
  // sound level check (minSecsElapsedBeforeFood).
  boolean pauseComplete = isPauseForFoodComplete();
  
  if ( pauseComplete == true ) {  

    // -- Start 30 sec check of sound levels

    // Serial.println("Start average tests.");  

  
    // Turn on LED again to indicate the beginning of tests 
    digitalWrite(dinnerLight, HIGH);
        
    // Is the 1 second pause between checks complete
    boolean pauseComplete = isPauseBetweenChecksComplete();
    
    // Are all 30 checks completed
    if ( currentCheck >= numChecks && testComplete == false)
    {
      
      testComplete = true;
      // -- Check the average of 30 seconds of average tests.
      Serial.println("Test complete ---");
      
      long int total = 0;
      for (int i = 0; i < numChecks; i++) {       
          // Add this value to the total.
          total = total + checkResults[i];
      }
      
      Serial.println("Overall average: " + String(total/numChecks));
      
    } 
    else if( pauseComplete == true )
    {

        
      collectSoundLevels();
        lastCheckSeconds = currentMillis/1000;
        
        Serial.println("Check number " + String(currentCheck) + " at " + String(lastCheckSeconds));
        currentCheck = currentCheck+1;        
    }
    else
    {
      //Serial.println("Not complete1"); 
    }
      
    
    

    
    
    // Is average sound level over the last few seconds greater than predetermined minimum 
    // sound level (minSoundLevelBeforeFood).
//    if( averageSoundLevel > minSoundLevelBeforeFood ) {
//        // Print message to serial monitor 
//        Serial.println("Turn off dinner light.");
//      
//        // Turn off LED
//        digitalWrite(dinnerLight, LOW);
//        
//        // This is resetting the lastOutputSecs so that the time check starts from this point. 
//        lastOuputMillis = currentSecond;
//    } 
  }
  else
  {
    //Serial.println("Not complete2"); 
  }
  
}


boolean isPauseForFoodComplete(){
  
  // millis() is an Arduino function that returns the number of milliseconds since
  // the Arduino board began running the current program. (http://arduino.cc/en/Reference/millis)
  long int timeElapsedSinceFood = (currentMillis/1000)-lastOuputSecs;


Serial.println("Time elapsed:" + String(timeElapsedSinceFood));

  // Is the time elapsed since last ouput greater than (>) predetermined time before
  // sound level checks (minSecsElapsedBeforeFood).
  if ( timeElapsedSinceFood > minSecsElapsedBeforeFood ) {
    return true;
  } else {
    return false;
  }   
} 

boolean isPauseBetweenChecksComplete(){
  
  // millis() is an Arduino function that returns the number of milliseconds since
  // the Arduino board began running the current program. (http://arduino.cc/en/Reference/millis)
  long int timeElapsedSinceLastCheck = currentMillis-lastCheckSeconds;

  // Is the time elapsed since last check greater than (>) abritrary pause between checks (1 second).
  if ( timeElapsedSinceLastCheck > millisBetweenCheck ) {
    return true;
  } else {
    return false;
  }   
 
} 


void collectSoundLevels(){
  
  // -- Check average sound level. Loop x times and collect x soundInputValues.

  // Number of values to collect for average.     
  int numValuesToCollect = 1
  ;
  
  // total needs to be a 'long int' variable (long integer) because it will hold a value
  // larger than a 'int' variable (standard integer) can hold in memory. 
  long int total = 0; 
  int soundInputValue;
  // Loop x times adding sound level to total.
  //for (int i = 0; i < numValuesToCollect; i++) { 
      // Read current sound level from sound sensor.
      //soundInputValue = analogRead(sensorPin); 
      
      // Add this value to the total.
      //total = total + soundInputValue;
  //}
  
  // Calculate the average sound level from the total determined in the previous 'for loop'
  // and store this in an array.
  int averageSoundLevel = total/numValuesToCollect;     
  
  checkResults[currentCheck] = averageSoundLevel;   
  Serial.println(averageSoundLevel);  
  
}

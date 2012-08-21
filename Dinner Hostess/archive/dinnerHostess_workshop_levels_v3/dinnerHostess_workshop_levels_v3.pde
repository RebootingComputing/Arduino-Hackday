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
int sensorValue = 0;   // variable to store the value coming from the sensor

// time in milliseconds since last check. 
int lastCheckMillis;    
// Period of time in milliseconds between sounds level checks.
int pauseBetweenCheck = 1000; 
// How many times to run the average check and the current check
int numChecks = 30;
int currentCheck = 0;
// Check results
int checkResults[30];
boolean testComplete = false;

void setup() {

  Serial.begin(9600);
  
  // Because there has not been a check yet we set this to 0 at the  beginning
  lastCheckMillis = 0;
}

void loop() {
  
  // -- Measure average sound levels every x milliseconds.
  
  // millis() is an Arduino function that returns the number of milliseconds since
  // the Arduino board began running the current program. (http://arduino.cc/en/Reference/millis)
  int timeNow = millis(); 
  int timeElapsed = timeNow-lastCheckMillis;
  
  if(currentCheck >= numChecks && testComplete == false)
  {
    testComplete = true;
    
    Serial.println("Test complete ---");
    long int total = 0;
    for (int i = 0; i < numChecks; i++) {       
        // Add this value to the total.
        total = total + checkResults[i];
    }
    
    Serial.println("Overall average: "
    + String(total/numChecks));
    
  }
  else if (timeElapsed >= pauseBetweenCheck && testComplete == false)
  { 
    // -- Check average sound level. Loop x times and collect x soundInputValues.
    Serial.println("Running check number " + String(currentCheck));

    // Number of values to collect for average.     
    int numValuesToCollect = 500;
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
    }
    
    // Calculate the average sound level from the total determined in the previous 'for loop'
    // and store this in an array.
    checkResults[currentCheck] = total/numValuesToCollect;     
    Serial.println("Average " + String(checkResults[currentCheck]));
    currentCheck++;
    
    lastCheckMillis = millis();
  }
  
  
    
}

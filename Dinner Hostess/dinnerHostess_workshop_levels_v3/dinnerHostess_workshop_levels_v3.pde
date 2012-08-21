/*

 Dinner Hostess Levels check
 Every 1 second for 30 seconds this sketch will read the average sound level.
 
 Created by David Cuartielles
 Modified 4 Sep 2010
 
 
 By Tom Igoe
 Modified 9th July 2012
 by Gareth Foote
 
 This example code is in the public domain
 
 */
 


const int sensorPin = A0;    // select the input pin for the potentiometer
int sensorValue = 0;   // variable to store the value coming from the sensor


// time in milliseconds since last check. 
long int lastCheckMillis;    
// Period of time in milliseconds between sounds level checks.
int pauseBetweenCheck = 500; 
// How many times to run the average check and the current check
int numChecks = 30;
int currentCheck = 0;
// Check results
int checkResults[30];
boolean testComplete = false;

int erroneousValues = 0;

void setup() {

  Serial.begin(9600);
  
  // Because there has not been a check yet we set this to 0 at the  beginning
  lastCheckMillis = 0;
}

void loop() {
  
  // -- Measure average sound levels every x milliseconds.
  
  // millis() is an Arduino function that returns the number of milliseconds since
  // the Arduino board began running the current program. (http://arduino.cc/en/Reference/millis)
  // 'long int' is a variable type for handling large integers.
  long int timeNow = millis(); 
  int timeElapsed = timeNow-lastCheckMillis;
  
  // If we have reached 30 checks & the test hasn't complete
  if(currentCheck >= numChecks && testComplete == false)
  {
    // Setting testComplete to true means this will only run once.
    testComplete = true;
    
    Serial.println("Test complete ---");
    // Calculate average and display
    long int total = 0;
    for (int i = 0; i < (numChecks); i++) {       
        // Add this value to the total.
        if(checkResults[i] > 650)
        {
          
          total = total + checkResults[i];
        }
        else
        {
          Serial.println("IGNORED:"+String(checkResults[i]));
          erroneousValues++;
        }
    }
    
    Serial.println("Overall average: "+ String(total/(numChecks-erroneousValues)));
    
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
        // Serial.println(String(soundInputValue));
        // Add this value to the total.
        total = total + soundInputValue;

    }
    
    // Calculate the average sound level from the total determined in the previous 'for loop'
    // and store this in an array.
    checkResults[currentCheck] = total/numValuesToCollect;     
    Serial.println("Average " + String(checkResults[currentCheck]));
    currentCheck++;
    
    // Reset this value so that this code in the if will not run for another 1000 millis 
    lastCheckMillis = millis();
  }
  
  
    
}

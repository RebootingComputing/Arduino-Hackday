/*
  Bio sensory reading
  This will collect x amount of values from the GSR sensor into 
  an array and then calculate the average.
 
 created 29 Dec. 2008
 Modified 4 Sep 2010
 by Tom Igoe
 Modified 9 July 2012 
 by Gareth Foote, Alexandra Jonsson & Emilie Gilles
 
 This example code is in the public domain.
 
 */


const int analogInPin = A0;  // Analog input pin that the GSR sensor is attached to
int sensorValue = 0;         // Value read from the sensor

int numCollectedValues = 0;
int maxValuesToCollect = 250;
// Array of collected values
int collectedValues[250];

void setup() {
  // Initialize serial communications at 9600 bps.
  Serial.begin(9600); 
}

void loop() {
  
  // If we haven't collected the maxValuesToCollect:
  if( numCollectedValues < maxValuesToCollect )
  {
    
    // Read the current GSR sensor value.
    sensorValue = analogRead(analogInPin); 
    // Print the sensor value on screen.
    Serial.print("GSR value = ");
    Serial.println(sensorValue);
    
    // Push the sensorValue into the array at position indicated by numCollectedValues.
    collectedValues[numCollectedValues] = sensorValue;
    // Add 1 to numCollectedValues.
    numCollectedValues = numCollectedValues+1;
    
  }
  else
  {
    
    // Calculate average - Loop through all values in array, add together and divide by num of collecte values.
    long int total = 0;
    for( int i = 0; i < maxValuesToCollect; i++ )
    {
      total = total+collectedValues[i];
    }
    
    Serial.println("Calculated total--");
    Serial.println(total);
    
    Serial.println("Calculated average--");
    Serial.println(total/maxValuesToCollect);
    delay(1000*100);
    
  }
  
}

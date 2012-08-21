/*
  Pieza_bio_v7
  Appropriated from Tom Igoe's example here:  
  from http://arduinno.cc/en/Tutorial/Tone
 
  Update by Gareth Foote, Emilie Giles & Alex Joensson for Arduino Projects and Workshop.
  
  @description
  Takes skin conductivity as input from Galvanic Skin Response (GSR) sensor
  and produces as output different tones according to input values.   
  
  @wiring (TO BE COMPLETED)
  Plug the black wire of the piezo to ground and the red to 
  your selected output pin (see 'int soundOutputPin' variable below)
 */
 
 
// Output pin for speaker/piezo.
int soundOutputPin = 8;

// Analog input pin for GSR sensor.
const int analogInPin = A0; 

// These are average values taken from multiple participants representing
// the average normal conductivity level (inputmax) and the average 
// state when sweating or having licked their finger (inputmin).
int inputmin = 400;
int inputmax = 1000;

// This is the value that is returned from the GSR sensor that is
// the current level of conductivity.
int bioSensorInput;

// These are min and max values for the tone that will be playing.
// If it starts too low pitched then increase tonemin and if it
// gets too high pitched then decrease the tonemax. These default
// values are taken from the  file "pitches.h".
int tonemin = 31;
int tonemax = 4978;


void setup() {
  
  // Initialize serial communications at 9600 bps.
  Serial.begin(9600); 
}

void loop() {
    
  //  Read the current value from the GSR sensor.
  bioSensorInput = analogRead(analogInPin);                                   
  // Print this to the serial monitor.
  Serial.print("GSR value = ");
  Serial.println(bioSensorInput);
    
  // If GSR sensor input is below 900, we assume the bio sensor is
  // attached and we DO NOT make sound.
  if ( bioSensorInput <= 900 ) {
    
    // See desecription below.  
    playTone(bioSensorInput, inputmin, inputmax);
    
  }
  
}

/*
 * This function takes the current value being read by the 
 * GSR sensor and the predetermined estimated min and max resistance
 * and maps this to a tone/pitch.
 */
void playTone( int input, int rangemin, int rangemax ) { 
 
  // How long we want this tone/pitch to play for. Currently a quarter of a second.
  int noteDuration = 1000/4;
  // Calculated the tone by mapping current GSR value from inputmin/inputmax onto tonmin/tonemax 
  int freq = map(input, rangemin, rangemax, tonemin, tonemax);
   
  // tone() - Built in Arduino function that creates a sound on an output PIN 
  // at a particular frequency and duration. 
  tone(soundOutputPin, freq, noteDuration);
  
  // This creates a short pause before playing the next note/tone.
  int pauseBetweenNotes = noteDuration *1.30;
  delay(pauseBetweenNotes);
  
  // Stop the tone playing.
  noTone(soundOutputPin);
}


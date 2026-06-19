#include <Servo.h>

// Define Arduino pins for the Ultrasonic Sensor
const int trigPin = 10;
const int echoPin = 11;

// Define Arduino pin for the Servo Motor
const int servoPin = 9; 

long duration;
int distance;

Servo myServo; // Create a servo object to control the motor

void setup() {
  pinMode(trigPin, OUTPUT); // Sets the trigPin as an Output
  pinMode(echoPin, INPUT);  // Sets the echoPin as an Input
  Serial.begin(9600);       // Starts the serial communication
  myServo.attach(servoPin); // Defines on which pin the servo motor is attached
}

void loop() {
  // Rotates the servo motor from 15 to 165 degrees
  for(int i=15; i<=165; i++){  
    myServo.write(i);
    delay(30);
    distance = calculateDistance();
    
    // Send the data to Processing over Serial
    Serial.print(i);        // Sends the current angle
    Serial.print(",");      // Sends delimiter character
    Serial.print(distance); // Sends the distance value
    Serial.print(".");      // Sends end-of-packet character
  }
  
  // Rotates the servo motor back from 165 to 15 degrees
  for(int i=165; i>15; i--){  
    myServo.write(i);
    delay(30);
    distance = calculateDistance();
    
    // Send the data to Processing over Serial
    Serial.print(i);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
  }
}

// Function for calculating the distance measured by the Ultrasonic sensor
int calculateDistance(){ 
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2);
  // Sets the trigPin on HIGH state for 10 micro seconds
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  
  // Reads the echoPin, returns the sound wave travel time in microseconds
  duration = pulseIn(echoPin, HIGH);
  
  // Calculating the distance (Speed of sound wave is 0.034 cm/us)
  distance = duration * 0.034 / 2;
  return distance;
}
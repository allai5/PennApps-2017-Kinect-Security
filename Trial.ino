
#include <Servo.h>

Servo myservo; 
char val;
void setup() {
   myservo.attach(9);
   
   pinMode(8,OUTPUT);
   Serial.begin(9600); // Start serial communication at 9600 bps
}
 void loop() {
   if (Serial.available()) 
   { // If data is available to read,
     val = Serial.read(); // read it and store it in val
   }
   if (val == '1') 
   { // If 1 was received
     myservo.write(0);              // tell servo to go to position in variable 'pos'
   } 
   if (val=='2'){
        digitalWrite(8,HIGH);
 }
    if (val=='3'){
      digitalWrite(8,LOW);
      myservo.write(90);
    }
    }


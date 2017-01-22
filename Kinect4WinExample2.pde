import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;


import processing.serial.*;

Serial myPort;  // Create object from Serial class

Kinect kinect;
ArrayList <SkeletonData> bodies;
int counter=0;
boolean yoyo=true;
float a,b,rH, lH, rHy, lHy;
void setup()


{

  size(640, 480);
  background(0);
  kinect = new Kinect(this);
  smooth();
  bodies = new ArrayList<SkeletonData>();
  String portName = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
}
void draw()
{
  background(0);
  image(kinect.GetImage(), 320, 0, 320, 240);
  image(kinect.GetDepth(), 320, 240, 320, 240);
  image(kinect.GetMask(), 0, 240, 320, 240);
  for (int i=0; i<bodies.size (); i++) 
  { 
    //bodies.get(i)).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y

    drawSkeleton(bodies.get(i));
    drawPosition(bodies.get(i));
    a=0;
    b=0;
    rH = bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x;
    lH = bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_LEFT].x;
    rHy = bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y;
    lHy= bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_LEFT].y;
    if (yoyo) {
      println("Calibrating hold your hand at the middle of your body");
      delay(1000);
      println("...");
      delay(1000);
      println("...");
      delay(1000);
      println("...");
      a = bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x;
      b = bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y;
      println("hey hold your first position");
      delay(2000);
      println("checking...");
      delay(1000);
      rH = bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x;
      rHy = bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y;
      if (a-rH>0.15 && b-rHy>0.15) {          
        println("hey hold your second position");
        delay(2000);
        println("checking...");
        delay(1000);
        float rHa = bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x;
        float rHya = bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y;
        if (rHa-rH>0.3 && java.lang.Math.abs(rHya-rHy)<0.3) {
          println("hey hold your third position");
          delay(2000);
          println("checking...");
          delay(1000);
          float rHb = bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x;
          float rHyb = bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y;
          if (rHa-rHb>0.15 && rHyb-rHya>0.15) {
            yoyo=false;
          } else {
            println("failed");
          }
        } else {
          println("failed");
        }
      } else {
        println("failed");
      }
    } else {

      if ((rH -lH) >= 0.7) {
        while (bodies.get(0).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x >rH/2){
          myPort.write('1');
          println(bodies.get(0).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x, rH);
          //drawSkeleton(bodies.get(0));
          //drawPosition(bodies.get(0));
        }
      } 
      else if ((lHy-rHy)>=0.7 ) {
        while (bodies.get(0).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y<rH/2){
          myPort.write('2');
        }
      } 
      else{
        myPort.write('3');
        println(3);
      }
    }
  }

}
void drawPosition(SkeletonData _s) 
{
  noStroke();
  fill(0, 100, 255);
  String s1 = str(_s.dwTrackingID);
  text(s1, _s.position.x*width/2, _s.position.y*height/2);
}

void drawSkeleton(SkeletonData _s) 
{
  // Body
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HEAD, //3
    Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER); //2
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, //2
    Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT); //4
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, //2
    Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT); //8
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, //2
    Kinect.NUI_SKELETON_POSITION_SPINE); //1
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, //4
    Kinect.NUI_SKELETON_POSITION_SPINE);//1
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, //8
    Kinect.NUI_SKELETON_POSITION_SPINE);//1
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SPINE, //1
    Kinect.NUI_SKELETON_POSITION_HIP_CENTER);//0
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HIP_CENTER, //0
    Kinect.NUI_SKELETON_POSITION_HIP_LEFT);//12
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HIP_CENTER, //0
    Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);//16
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HIP_LEFT, //12
    Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);//16

  // Left Arm
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, //4
    Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT);//5
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT, //5
    Kinect.NUI_SKELETON_POSITION_WRIST_LEFT);//6
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_WRIST_LEFT, //6
    Kinect.NUI_SKELETON_POSITION_HAND_LEFT);//7

  // Right Arm
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, //8
    Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT);//9
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT, //9
    Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT);//10
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT, //10
    Kinect.NUI_SKELETON_POSITION_HAND_RIGHT);//11

  // Left Leg
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HIP_LEFT, //12
    Kinect.NUI_SKELETON_POSITION_KNEE_LEFT);//13
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_KNEE_LEFT, //13
    Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT);//14
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT, //14
    Kinect.NUI_SKELETON_POSITION_FOOT_LEFT);//15

  // Right Leg
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HIP_RIGHT, //16
    Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT);//17
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT, //17
    Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT);//18
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT, //18
    Kinect.NUI_SKELETON_POSITION_FOOT_RIGHT);//19
}

void DrawBone(SkeletonData _s, int _j1, int _j2) 
{
  noFill();
  stroke(255, 255, 0);
  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j2] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    line(_s.skeletonPositions[_j1].x*width/2, 
      _s.skeletonPositions[_j1].y*height/2, 
      _s.skeletonPositions[_j2].x*width/2, 
      _s.skeletonPositions[_j2].y*height/2);
  }
}

void appearEvent(SkeletonData _s) 
{
  if (_s.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    bodies.add(_s);
  }
}

void disappearEvent(SkeletonData _s) 
{
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_s.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.remove(i);
      }
    }
  }
}

void moveEvent(SkeletonData _b, SkeletonData _a) 
{
  if (_a.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_b.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.get(i).copy(_a);
        break;
      }
    }
  }
}
import com.leapmotion.leap.Controller;
//import com.leapmotion.leap.Frame;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.Tool;
import com.leapmotion.leap.FingerList;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Vector;
import com.leapmotion.leap.Screen;
//import com.leapmotion.leap.processing.LeapMotion;
import com.onformative.leap.LeapMotionP5;
import processing.opengl.*;

LeapMotionP5 leap;

boolean reverseZ = true;
PVector p;
static float LEAP_WIDTH = 200.0f; // in mm
static float LEAP_HEIGHT = 700.0f; // in mm

void setup() {
  size(500, 500, OPENGL);
  p = new PVector(0, 0, 0);
  leap = new LeapMotionP5(this);
}

void draw() {
  background(0);

  for (Map.Entry entry : leap.getFingerPositions().entrySet()) {
    Integer fingerId = (Integer) entry.getKey();
    Vector position = (Vector) entry.getValue();
    fill(leap.getFingerColors().get(fingerId));
    noStroke();
    pushMatrix();
    getPositions(position);
    translate(p.x, p.y, p.z);
    ellipse(0, 0, 24.0f, 24.0f);
    popMatrix();
  }

  for (Map.Entry entry : leap.getToolPositions().entrySet()) {
    Integer toolId = (Integer) entry.getKey();
    Vector position = (Vector) entry.getValue();
    fill(leap.getToolColors().get(toolId));
    noStroke();
    pushMatrix();
    getPositions(position);
    translate(p.x, p.y, p.z);
    ellipse(0, 0, 24.0f, 24.0f);
    popMatrix();
  }

  println("fps: " + frameRate);
}

void getPositions(Vector _v) {
  p.x = leapToScreenX(_v.getX());
  p.y = leapToScreenY(_v.getY());
  p.z = _v.getZ();
  if (reverseZ) p.z *= -1;
}

void stop() {
  leap.stop();
  super.stop();
}

float leapToScreenX(float x) {
  float c = width / 2.0f;
  if (x > 0.0) {
    return lerp(c, width, x / LEAP_WIDTH);
  } 
  else {
    return lerp(c, 0.0f, -x / LEAP_WIDTH);
  }
}

float leapToScreenY(float y) {
  return lerp(height, 0.0f, y / LEAP_HEIGHT);
}


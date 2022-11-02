PShape earth;
PImage earthTexture;
float Yrotation = 0;
boolean left = false;
boolean right = false;

void setup() {
    size(1080,720,P3D);
    getData();
    earthTexture = loadImage("earth.jpg");
    noStroke();
    textureMode(NORMAL);
    earth = createShape(SPHERE, 150);
    earth.setTexture(earthTexture);
}

void keyPressed() {
  if (key == 'a') {
    left = true;
  } else if (key == 'd') {
    right = true;
  }
}

void keyReleased() {
  if (key == 'a') {
    left = false;
  } else if (key == 'd') {
    right = false;
  }
}

void draw() {
  if (left) {
    Yrotation++;
  } else if (right) {
    Yrotation--;
  }
  translate(width*0.5, height*0.5);
  rotateY(Yrotation*0.05);
  shape(earth);
}

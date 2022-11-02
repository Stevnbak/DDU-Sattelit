PShape earth;
PImage earthTexture;
float Yrotation = 0;

void setup() {
    size(1080,720,P3D);
    getData();
    earthTexture = loadImage("earth.jpg");
    noStroke();
    textureMode(NORMAL);
    earth = createShape(SPHERE, 150);
    earth.setTexture(earthTexture);
}

/*void keyPressed() {
if (key == CODED) {
if (key == LEFT) {
Yrotation--;
    } else if (key == RIGHT) {
Yrotation++;
    }
}
}*/

void draw() {
    translate(width * 0.5, height * 0.5);
    rotateY(Yrotation * 0.05);
    shape(earth);
}

PShape earth;
PImage earthTexture;
float Yrotation = 0;
float Xrotation = 0;
boolean left = false;
boolean right = false;
boolean up = false;
boolean down = false;

public ArrayList<Sattelit> sattelites = new ArrayList<Sattelit>();

void setup() {
    size(1080,720,P3D);
    getData("25544");
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
    if (key == 'w') {
        up = true;
    } else if (key == 's') {
        down = true;
    }
}

void keyReleased() {
    if (key == 'a') {
        left = false;
    } else if (key == 'd') {
        right = false;
    }
    if (key == 'w') {
        up = false;
    } else if (key == 's') {
        down = false;
    }
}

void draw() {
    if (left) {
        Yrotation++;
    } else if (right) {
        Yrotation--;
    }
    if (up) {
        Xrotation--;
    } else if (down) {
        Xrotation++;
    }
    translate(width * 0.5, height * 0.5);
    rotateY(Yrotation * 0.01);
    rotateX(Xrotation * 0.01);
    shape(earth);
}

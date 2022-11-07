PShape earth;
PImage earthTexture;
float Yrotation = 0;
float Xrotation = 0;
boolean left = false;
boolean right = false;
boolean up = false;
boolean down = false;
boolean mouseClick = false;
float scale = 1;
boolean zoomIn = false;
boolean zoomOut = false;

public ArrayList<Sattelit> sattelites = new ArrayList<Sattelit>();
public Sattelit selectedSattelite;

void setup() {
    //Basic
    size(1080,720,P3D);
    //Create satelites:
    getData("25544");
    getData("52797");
    //Earth & Background:
    background(0);
    earthTexture = loadImage("earth.jpg");
    noStroke();
    textureMode(NORMAL);
    earth = createShape(SPHERE, 6371);
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
    if (key == 'r') {
        zoomIn = true;
    } else if (key == 'f') {
        zoomOut = true;
    }
}

void mousePressed() {
    mouseClick = true;
}

void mouseReleased() {
    mouseClick = false;
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
    if (key == 'r') {
        zoomIn = false;
    } else if (key == 'f') {
        zoomOut = false;
    }
}

void draw() {
    //Rotation
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
    //Zoom
    if (zoomIn) {
        scale += 0.01;
    } else if (zoomOut) {
        scale -= 0.01;
    }
    scale = constrain(scale, 0.5, 2.33);
    
    //Draw...
    background(0);
    pushMatrix();
    //Move, Scale and Rotate everything
    translate(width * 0.5, height * 0.5);
    rotateY(Yrotation * 0.01);
    rotateX(Xrotation * 0.01);
    scale(scale * 0.033);

    //Draw Earth
    shape(earth);
    
    for (int i = 0; i < sattelites.size(); i++) {
        sattelites.get(i).draw();
    }
    //Highlight selected sattelite:
    if(selectedSattelite != null) {
        //println(selectedSattelite.name);

    }

    popMatrix();
    hint(DISABLE_DEPTH_TEST); //Enable GUI on top
    //Draw buttons
    displayButtons();
    //Draw sattelite info
    if(selectedSattelite != null) {
        displayInfo(selectedSattelite);
    }
    hint(ENABLE_DEPTH_TEST); //Return to non GUI
}

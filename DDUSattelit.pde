PShape earth;
PImage earthTexture;
float earthRadius = 6371;

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
    perspective(PI/3.0, float(width)/float(height), 250, 25000);
    //Create satelites:
    getData("25544");
    getData("52797");
    getData("39197");
    getData("33493");
    getData("28376");
    getData("21087");
    //getData("25661");
    getData("41852");
    println("Retrieved data for all sattelites");
    //Earth & Background:
    background(0);
    earthTexture = loadImage("earth.jpg");
    noStroke();
    textureMode(NORMAL);
    earth = createShape(SPHERE, earthRadius);
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
    selectedSattelite = null;
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
        Yrotation--;
    } else if (right) {
        Yrotation++;
    }
    if (up) {
        Xrotation++;
    } else if (down) {
        Xrotation--;
    }
    //Zoom
    if (zoomIn) {
        scale += 0.1;
    } else if (zoomOut) {
        scale -= 0.1;
    }
    scale = constrain(scale, -4, 13.5);
    
    //Draw...
    background(0);
    pushMatrix();
    //Camera stuff
    PVector camLocation = convert(Xrotation, Yrotation, earthRadius + scale * 1000);
    camera(camLocation.x, camLocation.y, camLocation.z, width/2.0, height/2.0, 0, 0, 1, 0);

    //Draw Earth
    shape(earth);

    //Highlight selected sattelite:
    if(selectedSattelite != null) {
        pushMatrix();
        PVector center = new PVector(0,0,0);
        PVector retning1 = selectedSattelite.positions.get(0).get();
        PVector retning2 = selectedSattelite.positions.get(1).get();
        retning1.normalize();
        retning2.normalize();
        PVector cross = new PVector();
        PVector.cross(retning1,retning2,cross);


        //Translate + Rotate
        float angleX = atan(retning1.y/retning1.z);
        float angleY = atan(retning1.z/retning1.x);

        rotateX(-angleX);
        rotateY(angleY);
        //Draw orbit:
        beginShape();
        noFill();
        stroke(selectedSattelite.colorValue);
        strokeWeight(3);
        for(int i = 1; i< 24; i++) {
            curveVertex((selectedSattelite.alt + earthRadius) * sin(0.1*PI*i), 0, (selectedSattelite.alt + earthRadius) * cos(0.1*PI*i));
        }
        endShape();
        popMatrix();
        //Change sattelite visuals:
        selectedSattelite.size = 200;
    }
    
    //Draw sattelites
    for (int i = 0; i < sattelites.size(); i++) {
        sattelites.get(i).draw();
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

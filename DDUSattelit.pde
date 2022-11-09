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
boolean isTimePaused = false;

float scale = 1;
boolean zoomIn = false;
boolean zoomOut = false;

public ArrayList<Sattelit> sattelites = new ArrayList<Sattelit>();
public Sattelit selectedSattelite;

public float time = 0;
float timeScale = 1;
long startTime;
import java.util.Date;

void setup() {
    //Basic
    size(1080,720,P3D);
    perspective(PI/3.0, float(width)/float(height), 50, 50000);

    //Earth & Background:
    background(0);
    earthTexture = loadImage("earth.jpg");
    noStroke();
    textureMode(NORMAL);
    earth = createShape(SPHERE, earthRadius);
    earth.setTexture(earthTexture);

    //Create satelites:
    getData("25544");
    getData("54216");
    getData("39197");
    getData("33493");
    getData("28376");
    getData("21087");
    getData("25661");
    getData("41852");
    getData("32289");
    getData("39768");
    getData("40298");
    getData("54209");
    println("Retrieved data for all sattelites");

    //Time
    startTime = new Date().getTime();
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
    if (key == ' ') {
        if (isTimePaused) {
            isTimePaused = false;
        } else {
            isTimePaused = true;
      }
    }
    if (key == CODED) {
        if (keyCode == UP) {
          timeScale += 0.5;
        } else if (keyCode == DOWN) {
          timeScale -= 0.5;
        }
        if (keyCode == RIGHT) {
          time += 300*timeScale;
        } else if (keyCode == LEFT) {
          time -= 300*timeScale;
        }
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
    if (key == 'r') {
        zoomIn = false;
    } else if (key == 'f') {
        zoomOut = false;
    }
}
void mousePressed() {
    mouseClick = true;
    if(mouseButton == 37) {
        if (selectedSattelite!=null) {selectedSattelite.size=100;}
        selectedSattelite = null;
    }
}
void mouseReleased() {
    mouseClick = false;
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scale += e / 3;
}
void mouseDragged() 
{
    PVector previousPosition = new PVector(pmouseX, pmouseY);
    PVector currentPosition = new PVector(mouseX, mouseY);
    PVector moved = PVector.sub(currentPosition, previousPosition);
    Xrotation -= moved.x * (sqrt(scale + 4.1) / 5);
    Yrotation += moved.y * (sqrt(scale + 4.1) / 5);
}

void draw() {
    //Time manipulation
    if (!isTimePaused) {
      time=time+(1/frameRate)*60*timeScale;
    }
    
    perspective(PI/3.0, float(width)/float(height), 50, 50000);
    //Rotation
    if (left) {
        Xrotation--;
    } else if (right) {
        Xrotation++;
    }
    if (up) {
        Yrotation++;
    } else if (down) {
        Yrotation--;
    }
    //Zoom
    if (zoomIn) {
        scale += 0.1;
    } else if (zoomOut) {
        scale -= 0.1;
    }
    scale = constrain(scale, -4, 13.5);
    
    //Draw...
    background(25);
    pushMatrix();
    
    //Camera stuff
    beginCamera();
    camera();
    translate(0,0,-(earthRadius * 2 + scale * 1000));
    rotateX(-radians(Yrotation));
    rotateY(-radians(Xrotation));
    endCamera();
    ///PVector camLocation = convert(Yrotation, Xrotation, earthRadius + scale * 1000);
    ///camera(camLocation.x, camLocation.y, camLocation.z, width/2.0, height/2.0, 0, 0, 1, 0);

    //Draw Earth
    shape(earth);

    //Highlight selected sattelite:
    if(selectedSattelite != null) {
        selectedSattelite.drawOrbit();
    }
    
    //Draw sattelites
    for (int i = 0; i < sattelites.size(); i++) {
        sattelites.get(i).drawSatelite();
    }
    popMatrix();

    hint(DISABLE_DEPTH_TEST); //Enable GUI on top
    //Draw buttons
    displayButtons();
    //Draw sattelite info
    if(selectedSattelite != null) {
        displayInfo(selectedSattelite);
    }
    //Draw "current" time
    Date d = new Date(startTime + ((long)time * 1000));
    textSize(15);
    fill(255);
    String txt = "Time: " + d;
    textAlign(LEFT, DOWN);
    text(txt, 2 , height - 15);
    hint(ENABLE_DEPTH_TEST); //Return to non GUI
}

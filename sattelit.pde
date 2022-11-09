class Sattelit {
    //Basic info
    String id;
    String name;
    JSONObject info;
    float size;
    //Position info
    float altitude;
    ArrayList<PVector> positions = new ArrayList<PVector>();
    //Draw info
    PVector drawPosition;
    color colorValue;
    //Plane info
    float angleX;
    float angleY;
    // Velocity
    float angularVelocity;
   
    public Sattelit(String newId, JSONObject data, ArrayList<PVector> dataPositions) {
        id = newId;
        info = data;

        positions = dataPositions;
        altitude = info.getJSONArray("positions").getJSONObject(0).getFloat("sataltitude");
        
        //Name
        name = data.getJSONObject("info").getString("satname");
        //Colour
        colorValue = color(random(125,255),random(125,255),random(125,255));
        //Button
        setupButton(this);
        // Plane
        angleX = -atan(positions.get(0).y/positions.get(0).z);
        angleY = atan(positions.get(0).z/positions.get(0).x);
        angularVelocity=(positions.get(0).sub(positions.get(1))).mag()/(2*earthRadius+altitude);
        size=100;
    }
    
    void drawSatelite() {
        pushMatrix();
        rotateX(angleX);
        rotateY(angleY);
        
        translate((altitude+earthRadius)*sin(angularVelocity*time),0,(altitude+earthRadius)*cos(angularVelocity*time));
        noStroke();
        fill(colorValue);
        sphere(size);
        popMatrix();
    }
    
    void drawOrbit(){
        pushMatrix();
        rotateX(angleX);
        rotateY(angleY);

        beginShape();
        noFill();
        stroke(colorValue);
        strokeWeight(3);
        for(int i = 1; i< 24; i++) {
            curveVertex((altitude + earthRadius) * sin(0.1*PI*i), 0, (altitude + earthRadius) * cos(0.1*PI*i));
        }
        endShape();
        popMatrix();
    }
}

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
    float angleZ;
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
        colorValue = color(int(random(125,255)),int(random(125,255)),int(random(125,255)));
        for (int i=0;i<sattelites.size();i++)
        {
          if (colorValue==sattelites.get(i).colorValue)
          {
             colorValue = color(int(random(125,255)),int(random(125,255)),int(random(125,255)));
             i=0;
          }
        }
        
        //Button
        setupButton(this);
        // Plane
        PVector pos = positions.get(0).get();
        angleX = -atan(pos.y/pos.z);
        angleY = atan(pos.z/pos.x);
        angleZ = atan(pos.x/pos.y);
        angularVelocity=(positions.get(0).get().sub(positions.get(1).get())).mag()/(2*earthRadius+altitude);
        size=100;
    }
    
    void drawSatelite() {
        pushMatrix();
        rotateX(angleX);
        rotateY(angleY);
        rotateZ(angleZ);
        
        noFill();
        stroke(colorValue,80);
        strokeWeight(2);
        for (float i=0.04;i<2*PI+0.04;i+=0.04){
          line((altitude+earthRadius)*sin(i-0.02),0,(altitude+earthRadius)*cos(i-0.02),(altitude+earthRadius)*sin(i),0,(altitude+earthRadius)*cos(i));
        }
        
        pushMatrix();
        translate((altitude+earthRadius)*sin(angularVelocity*time),0,(altitude+earthRadius)*cos(angularVelocity*time));
        noStroke();
        fill(colorValue);
        sphere(size);
        popMatrix();
        popMatrix();
    }
    
    void drawOrbit(){
        pushMatrix();
        rotateX(angleX);
        rotateY(angleY);
        rotateZ(angleZ);

        noFill();
        stroke(colorValue);
        strokeWeight(3);
        beginShape();
        for(int i = 1; i< 24; i++) {
            curveVertex((altitude + earthRadius) * sin(0.1*PI*i), 0, (altitude + earthRadius) * cos(0.1*PI*i));
        }
        endShape();
        
        popMatrix();
    }
}

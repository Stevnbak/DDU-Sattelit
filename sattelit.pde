class Sattelit {
    //Basic info
    public String id;
    public String name;
    public JSONObject info;
    //Position info
    public float lat, lng, alt;
    public ArrayList<PVector> positions = new ArrayList<PVector>();
    //Draw info
    public PVector drawPosition;
    public color colorValue;
    
    public Sattelit(String newId, JSONObject data, ArrayList<PVector> dataPositions) {

        id = newId;
        info = data;

        positions = dataPositions;
        lat = info.getJSONArray("positions").getJSONObject(0).getFloat("satlatitude");
        lng = info.getJSONArray("positions").getJSONObject(0).getFloat("satlongitude");
        alt = info.getJSONArray("positions").getJSONObject(0).getFloat("sataltitude");
        drawPosition = positions.get(0);
        //Name
        name = data.getJSONObject("info").getString("satname");
        //Colour
        colorValue = color(random(125,255),random(125,255),random(125,255));
        //Button
        setupButton(this);
    }
    
    void draw() {
        pushMatrix();
        translate(drawPosition.x, drawPosition.y, drawPosition.z);
        noStroke();
        fill(colorValue);
        shape(createShape(SPHERE, 50));
        popMatrix();
    }
}

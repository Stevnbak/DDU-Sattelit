class Sattelit {
    //Basic info
    public String id;
    public String name;
    public JSONObject info;
    public float size;
    //Position info
    public float alt;
    public ArrayList<PVector> positions = new ArrayList<PVector>();
    //Draw info
    public PVector drawPosition;
    public color colorValue;
    
    public Sattelit(String newId, JSONObject data, ArrayList<PVector> dataPositions) {

        id = newId;
        info = data;

        positions = dataPositions;
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
        noStroke();
        fill(colorValue);
        pushMatrix();
        translate(drawPosition.x, drawPosition.y, drawPosition.z);
        sphere(size);
        popMatrix();
        size = 100;
    }
}

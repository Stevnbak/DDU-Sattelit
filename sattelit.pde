class Sattelit {
    public String id;
    public String name;
    public JSONObject info;
    public ArrayList<PVector> positions = new ArrayList<PVector>();
    public PVector drawPosition;
    
    public Sattelit(String newId, JSONObject data, ArrayList<PVector> dataPositions) {
        id = newId;
        info = data;
        positions = dataPositions;
        drawPosition = positions.get(0);
        //Name
        name = data.getJSONObject("info").getString("satname");
        //Button
        setupButton(this);
    }
    
    void draw() {
        pushMatrix();
        translate(drawPosition.x, drawPosition.y, drawPosition.z);
        noStroke();
        fill(255);
        shape(createShape(SPHERE, 50));
        popMatrix();
    }
}

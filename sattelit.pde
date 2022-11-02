class Sattelit {
    public String id;
    public JSONObject info;
    public ArrayList<PVector> positions = new ArrayList<PVector>();
    public PVector drawPosition;
    
    public Sattelit(String newId, JSONObject data, ArrayList<PVector> dataPositions) {
        id = newId;
        info = data;
        positions = dataPositions;
        for (int i = 0; i < positions.size(); i++) {
            println(i + ": " + positions.get(i));
        }
        drawPosition = positions.get(0);
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

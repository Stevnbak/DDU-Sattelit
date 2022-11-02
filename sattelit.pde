class Sattelit {
    public String id;
    public JSONObject info;
    public ArrayList<PVector> positions = new ArrayList<PVector>();
    
    public Sattelit(String newId, JSONObject data, ArrayList<PVector> dataPositions) {
        id = newId;
        info = data;
        positions = dataPositions;
        for (int i = 0; i < positions.size(); i++) {
            println(i + ": " + positions.get(i));
        }
    }
}

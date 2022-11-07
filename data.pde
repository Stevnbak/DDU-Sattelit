private String apiKey = "2DRLZD-96QEZP-7E3F56-4Y5O";
private int points = 2;

void getData(String satId) {
    String requestURL = "https://api.n2yo.com/rest/v1/satellite/positions/" + satId + "/41.702/-76.014/0/" + points + "/&apiKey=" + apiKey;
    JSONObject data = loadJSONObject(requestURL);
    JSONArray positionData = data.getJSONArray("positions");
    ArrayList<PVector> positions = new ArrayList<PVector>();
    for (int i = 0; i < positionData.size(); i++) {
        PVector pos = convert(positionData.getJSONObject(i).getFloat("satlatitude"),positionData.getJSONObject(i).getFloat("satlongitude"),positionData.getJSONObject(0).getFloat("sataltitude"));
        positions.add(pos);
    }
    sattelites.add(new Sattelit(satId, data, positions));
}

PVector convert(float lat, float lon, float h) {
    float theta = radians(lat);
    float phi = radians(lon) + PI;
    
    // fix: in OpenGL, y & z axes are flipped from math notation of spherical coordinates
    float x = (h+earthRadius) * cos(theta) * cos(phi);
    float y = -(h+earthRadius) * sin(theta);
    float z = -(h+earthRadius) * cos(theta) * sin(phi);
    
    return new PVector(x, y, z);
}

private String apiKey = "2DRLZD-96QEZP-7E3F56-4Y5O";
private String satId = "25544";
private int points = 2;
public ArrayList<PVector> positions = new ArrayList<PVector>();

void getData() {
    String requestURL = "https://api.n2yo.com/rest/v1/satellite/positions/" + satId + "/41.702/-76.014/0/" + points + "/&apiKey=" + apiKey;
    JSONObject data = loadJSONObject(requestURL);
    JSONArray positionData = data.getJSONArray("positions");
    for(int i = 0; i < positionData.size(); i++) {
      PVector pos = convert(positionData.getJSONObject(i).getFloat("satlatitude"),positionData.getJSONObject(i).getFloat("satlongitude"),positionData.getJSONObject(i).getFloat("sataltitude"));
      println(pos);
      positions.add(pos);
    }
}

PVector convert(float lat, float lon, float h) {
    float theta = radians(lat);
    float phi = radians(lon) + PI;
    
    // fix: in OpenGL, y & z axes are flipped from math notation of spherical coordinates
    float x = h * cos(theta) * cos(phi);
    float y = -h * sin(theta);
    float z = -h * cos(theta) * sin(phi);
    
    return new PVector(x, y, z);
    
}

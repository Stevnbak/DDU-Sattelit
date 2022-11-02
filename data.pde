private JSONObject data;
private String apiKey = "2DRLZD-96QEZP-7E3F56-4Y5O";
private String satId = "25544";
public PVector pos1;
public PVector pos2;

void getData() {
    String requestURL = "https://api.n2yo.com/rest/v1/satellite/positions/" + satId + "/41.702/-76.014/0/2/&apiKey=" + apiKey;
    data = loadJSONObject(requestURL);
    JSONArray positions = data.getJSONArray("positions");
    PVector pos1 = convert(positions.getJSONObject(0).getFloat("satlatitude"),positions.getJSONObject(0).getFloat("satlongitude"),positions.getJSONObject(0).getFloat("sataltitude"));
    PVector pos2 = convert(positions.getJSONObject(1).getFloat("satlatitude"),positions.getJSONObject(1).getFloat("satlongitude"),positions.getJSONObject(1).getFloat("sataltitude"));
    println(pos1);
    println(pos2);
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

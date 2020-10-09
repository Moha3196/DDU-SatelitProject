JSONObject liveData;
JSONArray positions;
PImage earth;
PShape globe;
//Table table;
float r = 200;
float angle;
float  jordRadius = 6371.7955/r;
float lat, lon, latSPD,lonSPD, alt;

void setup() {
  size(800, 800, P3D);
  liveData = loadJSONObject("https://www.n2yo.com/rest/v1/satellite/positions/25544/41.702/-76.014/0/2/&apiKey=M9KGXC-SH4NVR-C2WSHY-4KK9");
  earth = loadImage("earth.jpg");
  positions = liveData.getJSONArray("positions");

  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);



  float lat1 = positions.getJSONObject(0).getFloat("satlatitude");
  float lon1 = positions.getJSONObject(0).getFloat("satlongitude");

  float lat2 = positions.getJSONObject(1).getFloat("satlatitude");
  float lon2 = positions.getJSONObject(1).getFloat("satlongitude");

  println(lat1);
  println(lon1);
  println(lat2);
  println(lon2);

  lat = positions.getJSONObject(0).getFloat("satlatitude");
  lon = positions.getJSONObject(0).getFloat("satlongitude");
  alt = positions.getJSONObject(0).getFloat("sataltitude");
  latSPD += positions.getJSONObject(1).getFloat("satlatitude") - positions.getJSONObject(0).getFloat("satlatitude");
  lonSPD += positions.getJSONObject(1).getFloat("satlongitude") - positions.getJSONObject(0).getFloat("satlongitude");

}





void draw() {
  background(51);
  translate(width*0.5, height*0.5);
  rotateY(angle);
  angle += 0.02;

  lights();
  fill(200);
  noStroke();
  //sphere(r);
  shape(globe);


  lat += latSPD;
  lon += lonSPD;

  println(lat);
  println(lon);
  // original version
  // float theta = radians(lat) + PI/2;

  // fix: no + PI/2 needed, since latitude is between -180 and 180 deg
  float theta = radians(lat);

  float phi = radians(lon) + PI;

  // original version
  // float x = r * sin(theta) * cos(phi);
  // float y = -r * sin(theta) * sin(phi);
  // float z = r * cos(theta);

  // fix: in OpenGL, y & z axes are flipped from math notation of spherical coordinates
  float x = r * cos(theta) * cos(phi);
  float y = -r * sin(theta);
  float z = -r * cos(theta) * sin(phi);

  PVector pos = new PVector(x, y, z);

  float h = alt/jordRadius;
  println(h);
  PVector xaxis = new PVector(1, 0, 0);
  float angleb = PVector.angleBetween(xaxis, pos);
  PVector raxis = xaxis.cross(pos);



  pushMatrix();
  translate(x-h, y, z);
  rotate(angleb, raxis.x, raxis.y, raxis.z);
  fill(255);
  box(5, 5, 5);
  popMatrix();
}

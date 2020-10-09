JSONObject liveData;
JSONArray positions;
PImage earth;
PShape globe;
float r = 200;
float angle;
float  jordRadius = 6371.7955/r;  //basically Jordens radius i pixels
float lat, lon, latSPD, lonSPD, alt;

void setup() {
  size(800, 800, P3D);
  liveData = loadJSONObject("https://www.n2yo.com/rest/v1/satellite/positions/25544/41.702/-76.014/0/2/&apiKey=M9KGXC-SH4NVR-C2WSHY-4KK9");  //loader vores live data
  earth = loadImage("earth.jpg");
  positions = liveData.getJSONArray("positions"); //opretter et array for satelittens positioner, ved at se på arrayet for netop dét i live data'en

  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);

  getData();  //gets the live data from the website with the live data
}


void draw() {
  background(51);
  translate(width*0.5, height*0.5);
  rotateY(angle);
  angle += 0.02;

  lights();
  fill(200);
  noStroke();
  shape(globe);

  lat += latSPD;  //opdaterer hele tiden positionen med ændringen i position siden sidste sæt live data
  lon += lonSPD;  //"

  println(lat);
  println(lon);
  
  float theta = radians(lat);
  float phi = radians(lon) + PI;

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

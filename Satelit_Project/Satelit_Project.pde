JSONObject staticData;
PImage earth;
PShape globe;
//Table table;
float r = 300;
float angle;
float  jordRadius = 6371.7955/r;


void setup() {
  size(800, 800, P3D);
  staticData = loadJSONObject("staticSateliteData.json");
  earth = loadImage("earth.jpg");
  //table = loadTable("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv", "header");

  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
}



void draw() {
  background(51);
  translate(width*0.5, height*0.5);
  rotateY(angle);
  angle += 0.03;

  lights();
  fill(200);
  noStroke();
  //sphere(r);
  shape(globe);
 // for (TableRow row : table.rows()) {
    float lat = staticData.getFloat("satLatitude");
    float lon = staticData.getFloat("satLongitude");
    float alt = staticData.getFloat("satAltitude");


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
    //float maxh = pow(10, 7);
    //h = map(h, 0, maxh, 10, 100);
    PVector xaxis = new PVector(1, 0, 0);
    float angleb = PVector.angleBetween(xaxis, pos);
    PVector raxis = xaxis.cross(pos);



    pushMatrix();
    translate(x+h, y, z);
    rotate(angleb, raxis.x, raxis.y, raxis.z);
    fill(255);
    box(5, 5, 5);
    popMatrix();
 //}
}

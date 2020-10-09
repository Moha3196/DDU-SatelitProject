void getData() {
  float lat1 = positions.getJSONObject(0).getFloat("satlatitude");  //we use ".getJSONObject()" quite a lot here
  float lon1 = positions.getJSONObject(0).getFloat("satlongitude"); //the "0" or "1" refers to the first or second instance, respectively, of "satlatitude" or "satlongitude"

  float lat2 = positions.getJSONObject(1).getFloat("satlatitude");
  float lon2 = positions.getJSONObject(1).getFloat("satlongitude");

  println(lat1);
  println(lon1);
  println(lat2);
  println(lon2);

  lat = positions.getJSONObject(0).getFloat("satlatitude");
  lon = positions.getJSONObject(0).getFloat("satlongitude");
  alt = positions.getJSONObject(0).getFloat("sataltitude");
  latSPD += positions.getJSONObject(1).getFloat("satlatitude") - positions.getJSONObject(0).getFloat("satlatitude");    //Finds the change in position
  lonSPD += positions.getJSONObject(1).getFloat("satlongitude") - positions.getJSONObject(0).getFloat("satlongitude");  //We assume this change is somewhat constant, basically making it a speed
}

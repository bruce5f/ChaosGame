void setup() {
  size(1000,1000);
  noLoop();//frameRate(1);
}

int jumps = 10000000;
void draw() {
  background(0);
  stroke(255,255,255);
  float[] center = {width/2, height/2};
  
  int vertexCount = 8, illegalIntervals[] = {2,5}, radius = width/2-10;
  
  //Polygon
  ArrayList<float[]> vertices = generateVertices(vertexCount, 1.0);
  line(center[0] + radius*vertices.get(vertexCount-1)[0],
  center[1] - radius*vertices.get(vertexCount-1)[1],
  center[0] + radius*vertices.get(0)[0],
  center[1] - radius*vertices.get(0)[1]); 
  for (int i = 0; i < vertexCount-1; i++) {
     line(center[0] + radius*vertices.get(i)[0],
     center[1] - radius*vertices.get(i)[1],
     center[0] + radius*vertices.get(i+1)[0],
     center[1] - radius*vertices.get(i+1)[1]); 
  }
  
  noStroke();
  fill(255,255,255,5);
  float[] position = {0,0};
  int vertex = 0, newVertex = (int)random(vertexCount);
  
  //Points
  for (int i = 0; i < jumps; i++) {
    position = midpoint(position, vertices.get(vertex));
    rect(center[0] + radius*position[0], center[1] - radius*position[1], 1,1);
    newVertex = (int)random(vertexCount);
    
    //not vertex at current + avoidInterval
    boolean illegalVertex = true;
    while(illegalVertex) {
      newVertex = (int)random(vertexCount); 
      for (int j = 0; j < illegalIntervals.length; j++) {
        if (vertex == (newVertex+illegalIntervals[j]) % vertexCount || vertex == (vertexCount+newVertex-illegalIntervals[j]) % vertexCount) {
            illegalVertex = true;
            break;
        } 
        illegalVertex = false;
      }
    }
    vertex = newVertex;
  }

}

float[] midpoint(float[] p1, float[] p2) {
  float[] mid = {(p1[0] + p2[0])/2, (p1[1] + p2[1])/2};
    return mid;
}

ArrayList<float[]> generateVertices(int count, float percent) {
  ArrayList<float[]> vertices = new ArrayList<float[]>();
  
  //initial index keeps polygon oriented properly
    for (float i = (1-count%2)/2.0; i < count; i++) {
      vertices.add(new float[2]);
      vertices.get((int)i)[0] = cos(PI/2 + percent*PI*2*i/count);
      vertices.get((int)i)[1] = sin(PI/2 + percent*PI*2*i/count);
    }
  
  return vertices;
}

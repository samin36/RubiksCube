import peasy.*;

PeasyCam cam;   
Cubie[] cube;
int dim = 3;
float len = 1;
float rotIncrement = PI/40;
String pattern;
boolean startPattern;
boolean isRotating;
int patIndex = 0;
float center;
int start;
void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 200);
  cube = new Cubie[dim*dim*dim];
  center = -.5*dim + 1.5;
  int index = 0;
  start = 2 - dim;
  for (int x = start; x <= 1; x++) {
    for (int y = start; y <= 1; y++) {
      for (int z = start; z <= 1; z++) {
        PMatrix3D matrix = new PMatrix3D();
        matrix.translate(x, y, z);
        cube[index] = new Cubie(matrix);
        index++;
      }
    }
  }
  pattern = translatePattern("FLFuRUFFLLulBdbLLU");
  println(pattern);
  startPattern = false;
  isRotating = false;
}

void draw() {
  background(51);
  scale(75.0/(dim*len));
  pushMatrix();
  for (Cubie qb : cube) {
    qb.show();
  }
  popMatrix();
  if (patIndex < pattern.length() && startPattern && !isRotating) {
    rotateCube(pattern.charAt(patIndex));
    patIndex++;
  }
}

String translatePattern(String pat) {
  StringBuilder sb = new StringBuilder();
  for (char c : pat.toCharArray()) {
    if (c == 'U') {
      sb.append('T');
    } else if (c == 'u') {
      sb.append('t');
    } else if (c == 'B') {
      sb.append('b');
    } else if (c == 'b') {
      sb.append('B');
    } else if (c == 'D') {
      sb.append('d');
    } else if (c == 'd') {
      sb.append('D');
    } else {
      sb.append(c);
    }
  }
  return sb.toString();
}

void mousePressed() {
  startPattern = (mouseButton == RIGHT) ? true : false;
}

void keyPressed() {
  rotateCube(key);
}

void rotateCube(char faceToRotate) {
  for (Cubie cubie : cube) {
    switch (faceToRotate) {
    case 'f':
      //Front CCW
      if (round(cubie.matrix.m23) == 1) {
        cubie.configureRotation('Z', -1);
      }
      break;
    case 'F':
      //Front CW
      if (round(cubie.matrix.m23) == 1) {
        cubie.configureRotation('Z', 1);
      }
      break;
    case 'b':
      //Back CCW
      if (round(cubie.matrix.m23) == start) {
        cubie.configureRotation('Z', -1);
      }
      break;
    case 'B':
      //Back CW
      if (round(cubie.matrix.m23) == start) {
        cubie.configureRotation('Z', 1);
      }
      break;
    case 'l':
      //Left CCW
      if (round(cubie.matrix.m03) == start) {
        cubie.configureRotation('X', 1);
      }
      break;
    case 'L':
      //Left CW
      if (round(cubie.matrix.m03) == start) {
        cubie.configureRotation('X', -1);
      }
      break;
    case 'r':
      //Right CCW
      if (round(cubie.matrix.m03) == 1) {
        cubie.configureRotation('X', -1);
      }
      break;
    case 'R':
      //Right CW
      if (round(cubie.matrix.m03) == 1) {
        cubie.configureRotation('X', 1);
      }
      break;
    case 't':
      //Top CCW
      if (round(cubie.matrix.m13) == start) {
        cubie.configureRotation('Y', -1);
      }
      break;
    case 'T':
      //Top CW
      if (round(cubie.matrix.m13) == start) {
        cubie.configureRotation('Y', 1);
      }
      break;
    case 'd':
      //Down CCW
      if (round(cubie.matrix.m13) == 1) {
        cubie.configureRotation('Y', -1);
      }
      break;
    case 'D':
      //Down CW
      if (round(cubie.matrix.m13) == 1) {
        cubie.configureRotation('Y', 1);
      }
      break;
    case 'm':
      //Middle CCW
      if (round(cubie.matrix.m03) == int((start + 1) / 2)) {
        cubie.configureRotation('X', 1);
      }
      break;
    case 'M':
      //Middle CW
      if (round(cubie.matrix.m03) == int((start + 1) / 2)) {
        cubie.configureRotation('X', -1);
      }
      break;
    }
  }
}

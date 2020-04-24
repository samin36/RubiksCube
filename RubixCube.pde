import peasy.*;

PeasyCam cam;   
Cubie[] cube;
int dim = 3;
float len = 1;
String pattern;
boolean startPattern;
int patIndex = 0;
void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 200);
  cube = new Cubie[dim*dim*dim];
  int index = 0;
  int start = 2 - dim;
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
  //exit();
  startPattern = false;
}

void draw() {
  background(51);
  scale(75.0/dim);
  //for (Cubie qb : cube) {
  //  qb.show();
  //}
  cube[2].show();
  if (patIndex < pattern.length() && startPattern) {
    rotateCube(pattern.charAt(patIndex));
    patIndex++;
  } else {
    startPattern = false;
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
    } else {
      sb.append(c);
    }
  }
  return sb.toString();
}

void mousePressed() {
  //if (mouseButton == RIGHT)
  //  startPattern = true;
}
void keyPressed() {
  rotateCube(key);
}

void rotateCube(char faceToRotate) {
  for (Cubie cubie : cube) {
    cubie = cube[2];
    switch (faceToRotate) {
    case 'f':
      //Front CCW
      if (cubie.matrix.m23 == 1) {
        cubie.configureRotation('Z', -1);
        //cubie.rotateAroundZ();
      }
      break;
    case 'F':
      //Front CW
      if (cubie.matrix.m23 == 1) {
        cubie.configureRotation('Z', 1);
        //cubie.rotateAroundZ();
      }
      break;
    case 'b':
      //Back CCW
      if (cubie.matrix.m23 == -1) {
        cubie.configureRotation('Z', -1);
      }
      break;
    case 'B':
      //Back CW
      if (cubie.matrix.m23 == -1) {
        cubie.configureRotation('Z', 1);
      }
      break;
    case 'l':
      //Left CCW
      if (cubie.matrix.m03 == -1) {
        cubie.rotateAroundX(1);
      }
      break;
    case 'L':
      //Left CW
      if (cubie.matrix.m03 == -1) {
        cubie.rotateAroundX(-1);
      }
      break;
    case 'r':
      //Right CCW
      if (cubie.matrix.m03 == 1) {
        cubie.rotateAroundX(-1);
      }
      break;
    case 'R':
      //Right CW
      if (cubie.matrix.m03 == 1) {
        cubie.rotateAroundX(1);
      }
      break;
    case 't':
      //Top CCW
      if (cubie.matrix.m13 == -1) {
        cubie.rotateAroundY(-1);
      }
      break;
    case 'T':
      //Top CW
      if (cubie.matrix.m13 == -1) {
        cubie.rotateAroundY(1);
      }
      break;
    case 'd':
      //Down CCW
      if (cubie.matrix.m13 == 1) {
        cubie.rotateAroundY(1);
      }
      break;
    case 'D':
      //Down CW
      if (cubie.matrix.m13 == 1) {
        cubie.rotateAroundY(-1);
      }
      break;
    case 'm':
      //Middle CCW
      if (cubie.matrix.m03 == 0) {
        cubie.rotateAroundX(1);
      }
      break;
    case 'M':
      //Middle CW
      if (cubie.matrix.m03 == 0) {
        cubie.rotateAroundX(-1);
      }
      break;
    }
  }
}

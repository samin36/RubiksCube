import peasy.*;

PeasyCam cam;   
Cubie[][][] cube;
int dim = 3;
int len = 1;
void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 200);
  cube = new Cubie[dim][dim][dim];
  for (int x = -1; x <= 1; x++) {
    for (int y = -1; y <= 1; y++) {
      for (int z = -1; z <= 1; z++) {
        PMatrix3D matrix = new PMatrix3D();
        matrix.translate(x, y, z);
        cube[x + 1][y + 1][abs(z - 1)] = new Cubie(matrix);
      }
    }
  }
}

void draw() {
  background(51);
  scale(25);
  for (int x = -1; x <= 1; x++) {
    for (int y = -1; y <= 1; y++) {
      for (int z = -1; z <= 1; z++) {
        cube[x + 1][y + 1][abs(z - 1)].show();
      }
    }
  }
  //cube[0][0][0].show();
}

void keyPressed() {
  rotateCube(key);
}

void rotateCube(char faceToRotate) {
  for (int x = -1; x <= 1; x++) {
    for (int y = -1; y <= 1; y++) {
      for (int z = -1; z <= 1; z++) {
        Cubie cubie = cube[x + 1][y + 1][abs(z - 1)];
        switch (faceToRotate) {
        case 'f':
          //Front CCW
          if (cubie.matrix.m23 == 1) {
            cubie.rotateAroundZ(-1);
          }
          break;
        case 'F':
          //Front CW
          if (cubie.matrix.m23 == 1) {
            cubie.rotateAroundZ(1);
          }
          break;
        case 'b':
          //Back CCW
          if (cubie.matrix.m23 == -1) {
            cubie.rotateAroundZ(-1);
          }
          break;
        case 'B':
          //Back CW
          if (cubie.matrix.m23 == -1) {
            cubie.rotateAroundZ(1);
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
  }
}

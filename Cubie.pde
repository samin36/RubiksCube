/*
Represents a single 1x1x1 cube of the 27 total cubes
 */
class Cubie {
  PMatrix3D matrix;
  color c;
  Face[] faces;
  Cubie(PMatrix3D matrix) {
    this.matrix = matrix;
    //front = new Face(new PVector(0, 0, len*.5), color(0, 255, 0));
    //back = new Face(new PVector(0, 0, -len*0.5), color(70, 102, 255));
    //top = new Face(new PVector(0, -len*0.5, 0), color(255, 255, 0));
    //bottom = new Face(new PVector(0, len*0.5, 0), color(255));
    //left = new Face(new PVector(-len*0.5, 0, 0), color(255, 7, 58));
    //right = new Face(new PVector(len*0.5, 0, 0), color(255, 103, 0));
    faces = new Face[6];

    faces[0] = new Face(0, 0, len*.5, color(0, 255, 0)); //Front
    faces[1] = new Face(0, 0, -len*0.5, color(70, 102, 255)); //Back
    faces[2] = new Face(0, -len*0.5, 0, color(255, 255, 0)); //Top
    faces[3] = new Face(0, len*0.5, 0, color(255)); //Bottom
    faces[4] = new Face(-len*0.5, 0, 0, color(255, 7, 58)); //Left
    faces[5] = new Face(len*0.5, 0, 0, color(255, 165, 0)); //Right
  }

  void show() {
    pushMatrix();
    applyMatrix(matrix);
    //stroke(255);
    //strokeWeight(0.5);
    //point(0, 0, 0);
    for (Face face : faces) {
      face.show();
    }
    popMatrix();
  }

  void rotateAroundX(int dir) {
    //First rotate the matrix for this Cubie.
    PMatrix2D rotMatrix = new PMatrix2D();
    rotMatrix.rotate(dir * PI/2);
    rotMatrix.translate(matrix.m13, matrix.m23);
    matrix.m13 = round(rotMatrix.m02);
    matrix.m23 = round(rotMatrix.m12);
    for (Face face : faces) {
      if (abs(face.normal.m03) == 0) { 
        rotateNormalX(dir, face);
      }
    }
  }

  void rotateNormalX(int dir, Face face) {
    //Applying standard rotation transformation: Rx
    float nY = (dir == 1) ? -1 * face.normal.m23 : face.normal.m23;
    float nZ = (dir == 1) ? face.normal.m13 : -1 * face.normal.m13;
    face.normal.reset();
    face.normal.m13 = nY;
    face.normal.m23 = nZ;
    face.fixRotations();
  }

  void rotateAroundY(int dir) {
    //First rotate the matrix for this Cubie.
    PMatrix2D rotMatrix = new PMatrix2D();
    rotMatrix.rotate(dir * PI/2);
    rotMatrix.translate(matrix.m03, matrix.m23);
    matrix.m03 = round(rotMatrix.m02);
    matrix.m23 = round(rotMatrix.m12);
    for (Face face : faces) {
      if (abs(face.normal.m13) == 0) { 
        rotateNormalY(dir, face);
      }
    }
  }

  void rotateNormalY(int dir, Face face) {
    //Applying standard rotation transformation: Ry
    float nX = (dir == 1) ? -1 * face.normal.m23 : face.normal.m23;
    float nZ = (dir == 1) ? face.normal.m03 : -1 * face.normal.m03;
    face.normal.reset();
    face.normal.m03 = nX;
    face.normal.m23 = nZ;
    face.fixRotations();
  }

  void rotateAroundZ(int dir) {
    //First rotate the matrix for this Cubie.
    PMatrix2D rotMatrix = new PMatrix2D();
    rotMatrix.rotate(dir * PI/2);
    rotMatrix.translate(matrix.m03, matrix.m13);
    matrix.m03 = round(rotMatrix.m02);
    matrix.m13 = round(rotMatrix.m12);
    for (Face face : faces) {
      if (abs(face.normal.m23) == 0) {
        rotateNormalZ(dir, face);
      }
    }
  }

  void rotateNormalZ(int dir, Face face) {
    //Applying standard rotation transformation: Rz
    float nX = (dir == 1) ? -1 * face.normal.m13 : face.normal.m13;
    float nY = (dir == 1) ? face.normal.m03 : -1 * face.normal.m03;
    face.normal.reset();
    face.normal.m03 = nX;
    face.normal.m13 = nY;
    face.fixRotations();
  }
}

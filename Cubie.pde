/*
Represents a single 1x1x1 cubie of the 27 total cubies
 */
class Cubie {
  PMatrix3D matrix;
  PMatrix2D rotMatrix;
  PShape cubie;
  char currentlyRotAxis;  //'Z' for z-axis, 'Y' for y-axis, and 'X' for x-axis
  int currentRotDir;
  float rotAngle;
  Cubie(PMatrix3D matrix) {
    this.matrix = matrix;
    rotMatrix = new PMatrix2D();
    cubie = createShape(GROUP);
    float l = len * 0.5;
    float sW = 1.5;//4.5 / dim;
    PShape front, right, back, left, top, bottom;
    rectMode(CENTER);
    front = createShape();
    front.beginShape();
    front.strokeWeight(sW);
    front.stroke(0);
    front.fill(color(0, 255, 0));
    front.vertex(-l, -l, l);
    front.vertex(l, -l, l);
    front.vertex(l, l, l);
    front.vertex(-l, l, l);
    front.endShape(CLOSE);
    cubie.addChild(front);
    //
    right = createShape();
    right.beginShape();
    right.strokeWeight(sW);
    right.stroke(0);
    right.fill(color(255, 165, 83));
    right.vertex(l, -l, l);
    right.vertex(l, -l, -l);
    right.vertex(l, l, -l);
    right.vertex(l, l, l);
    right.endShape(CLOSE);
    cubie.addChild(right);
    //
    back = createShape();
    back.beginShape();
    back.strokeWeight(sW);
    back.stroke(0);
    back.fill(color(70, 102, 255));
    back.vertex(l, -l, -l);
    back.vertex(-l, -l, -l);
    back.vertex(-l, l, -l);
    back.vertex(l, l, -l);
    back.endShape(CLOSE);
    cubie.addChild(back);
    //
    left = createShape();
    left.beginShape();
    left.strokeWeight(sW);
    left.stroke(0);
    left.fill(color(255, 7, 58));
    left.vertex(-l, -l, -l);
    left.vertex(-l, -l, l);
    left.vertex(-l, l, l);
    left.vertex(-l, l, -l);
    left.endShape(CLOSE);
    cubie.addChild(left);
    //
    top = createShape();
    top.beginShape();
    top.strokeWeight(sW);
    top.stroke(0);
    top.fill(color(255, 255, 0));
    top.vertex(l, -l, l);
    top.vertex(l, -l, -l);
    top.vertex(-l, -l, -l);
    top.vertex(-l, -l, l);
    top.endShape(CLOSE);
    cubie.addChild(top);
    //
    bottom = createShape();
    bottom.beginShape();
    bottom.strokeWeight(sW);
    bottom.stroke(0);
    bottom.fill(color(255));
    bottom.vertex(-l, l, l);
    bottom.vertex(l, l, l);
    bottom.vertex(l, l, -l);
    bottom.vertex(-l, l, -l);
    bottom.endShape(CLOSE);
    cubie.addChild(bottom);

    currentlyRotAxis = ' ';
    currentRotDir = 0;
    rotAngle = 0;
  }

  void show() {
    rotateAroundX();
    rotateAroundY();
    rotateAroundZ();
    pushMatrix();
    applyMatrix(matrix);
    shape(cubie);
    popMatrix();
  }

  void configureRotation(char rotAxis, int rotDir) {
    if (currentlyRotAxis == ' ') {
      currentlyRotAxis = rotAxis;
      currentRotDir = rotDir;
      rotAngle = 0;
      isRotating = true;
    }
  }


  void rotateAroundX() {
    if (currentlyRotAxis == 'X') {
      if (rotAngle < PI/2) {
        //First rotate the matrix for this Cubie.
        rotMatrix.reset();
        rotMatrix.translate(center, center);
        rotMatrix.rotate(currentRotDir * rotIncrement);
        rotMatrix.translate(matrix.m13 - center, matrix.m23 - center);
        matrix.m13 = rotMatrix.m02;
        matrix.m23 = rotMatrix.m12;

        cubie.rotate(currentRotDir * rotIncrement, 1, 0, 0);
        rotAngle += rotIncrement;
      } else {
        resetRotation();
      }
    }
  }

  void rotateAroundY() {
    if (currentlyRotAxis == 'Y') {
      if (rotAngle < PI/2) {
        //First rotate the matrix for this Cubie.
        rotMatrix.reset();
        rotMatrix.translate(center, center);
        rotMatrix.rotate(currentRotDir * rotIncrement);
        rotMatrix.translate(matrix.m03 - center, matrix.m23 - center);
        matrix.m03 = rotMatrix.m02;
        matrix.m23 = rotMatrix.m12;

        cubie.rotate(-1 * currentRotDir * rotIncrement, 0, 1, 0);
        rotAngle += rotIncrement;
      } else {
        resetRotation();
      }
    }
  }

  void rotateAroundZ() {
    if (currentlyRotAxis == 'Z') {
      if (rotAngle < PI/2) {
        //First rotate the matrix for this Cubie.
        rotMatrix.reset();
        rotMatrix.translate(center, center);
        rotMatrix.rotate(currentRotDir * rotIncrement);
        rotMatrix.translate(matrix.m03 - center, matrix.m13 - center);
        //rotMatrix.rotate(currentRotDir * rotIncrement);
        //rotMatrix.translate(matrix.m03, matrix.m13);
        matrix.m03 = rotMatrix.m02;
        matrix.m13 = rotMatrix.m12;


        cubie.rotate(currentRotDir * rotIncrement, 0, 0, 1);
        rotAngle += rotIncrement;
      } else {
        resetRotation();
      }
    }
  }

  void resetRotation() {
    currentlyRotAxis = ' ';
    currentRotDir = 0;
    rotAngle = 0;
    isRotating = false;
  }
}

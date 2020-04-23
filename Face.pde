class Face {
  PMatrix3D normal;
  color col;
  Face (float x, float y, float z, color col) {
    normal = new PMatrix3D();
    normal.translate(x, y, z);
    fixRotations();
    this.col = col;
  }

  void show() {
    strokeWeight(0.08);
    stroke(0);
    fill(col);
    pushMatrix();
    applyMatrix(normal);
    rectMode(CENTER);
    square(0, 0, len);
    popMatrix();
  }

  void fixRotations() {
    //println("In fixrotations");
    if (abs(normal.m03) > 0) {
      //println("YES");
      normal.rotateY(PI/2);
    } else if (abs(normal.m13) > 0) {
      normal.rotateX(PI/2);
    }
  }
}

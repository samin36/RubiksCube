class Face2 {
  PVector normal;
  color col;
  Face2 (PVector normal, color col) {
    this.normal = normal;
    this.col = col;
  }

  void show() {
    pushMatrix();
    strokeWeight(0.1);
    stroke(0);
    fill(col);
    translate(normal.x, normal.y, normal.z);
    if (abs(normal.x) > 0) {
      rotateY(PI/2);
    } else if (abs(normal.y) > 0) {
      rotateX(PI/2);
    }
    rectMode(CENTER);
    square(0, 0, len);
    popMatrix();
  }
}

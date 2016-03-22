class tag {

  PVector loc; // dove
  String txt;
  float alpha, alphaTarget;
  int firstFrame;

  int fadeSpeed;
  color c;

  boolean out;

  tag(float _x, float _y, String _txt) {
    loc = new PVector(_x, _y);
    txt = _txt;

    c = 0;
    alphaTarget = 100;
    alpha = 0;

    firstFrame = frameCount;
    fadeSpeed = 24*3;

    out = false;
  }

  void display() {
    // display txt
    fill(c, alpha);
    text(txt, loc.x, loc.y);
  }

  void fade() {

    if (!out) {
      if (frameCount - firstFrame < fadeSpeed) {
        float nAlpha = map(frameCount, firstFrame, firstFrame+fadeSpeed, 0, alphaTarget);
        alpha = nAlpha;
      }
    } else {
      alpha = alpha - (alphaTarget / fadeSpeed);
      if(alpha<= 0){
        alpha = 0;
      }
    }
  }
}
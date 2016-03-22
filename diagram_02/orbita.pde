class orbita {
  PVector loc; // dove
  ArrayList <dot> Elements;
  float r; // radio

  dot centerDot;

  orbita(float _x, float _y, float _r) {
    loc = new PVector(_x, _y);
    r = _r;
    Elements = new ArrayList();
  }

  void assignLocs() {

    if (Elements.size() > 0) {
      // to locTarget

      float _a = TWO_PI / Elements.size();
      float _ai = random(TWO_PI);


      for (int n = 0; n<Elements.size (); n++) {
        dot p = Elements.get(n);
        // calculate LocTarget
        float a = _ai + (_a * n);
        float noiseR = p.w_target*2.5;
        float noisyR = random(r - noiseR, r +noiseR);
        
        float nX = loc.x + cos(a)*noisyR;
        float nY = loc.y + sin(a)*noisyR;

        p.locTarget.x = nX;
        p.locTarget.y = nY;
      }
    }
  }
}
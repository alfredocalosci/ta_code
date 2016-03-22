// Code from Visualizing Data, First Edition, Copyright 2008 Ben Fry.
// Based on the GraphLayout example by Sun Microsystems.

class Node {
  float x, y;
  float dx, dy;
  boolean fixed;
  String label;
  int count, countIni;
  color myColor;
  
  int type;
  String nText;


  Node(String label, String _nText) {
    this.label = label;
    x = random(width);
    y = random(height);
    count = 100;
    countIni = 100;
    myColor = nodeColor;
    
    nText = _nText;
    // tipe 0,1 or 2
    
    String c1 = label.substring(0, 1);     
    
    type = 0; // fallback
    if(c1.equals("a")){
      type = 0;
    }
    
    if(c1.equals("p")){
      type = 1;
    }
    
    if(c1.equals("i")){
      type = 2;
    }
    
  }
  
  void increment() {
    count++;
  }
  
  
  void relax() {
    float ddx = 0;
    float ddy = 0;

    for (int j = 0; j < nodeCount; j++) {
      Node n = nodes[j];
      if (n != this) {
        float vx = x - n.x;
        float vy = y - n.y;
        float lensq = vx * vx + vy * vy;
        if (lensq == 0) {
          ddx += random(1);
          ddy += random(1);
        //} else if (lensq < 100*50) {
        } else if (lensq < 3000) {
          ddx += vx / lensq;
          ddy += vy / lensq;
        }
      }
    }
    float dlen = mag(ddx, ddy) / 2;
    if (dlen > 0) {
      dx += ddx / dlen;
      dy += ddy / dlen;
    }
  }


  void update() {
    if (!fixed) {      
      x += constrain(dx, -20, 20);
      y += constrain(dy, -20, 20);
      
       x = constrain(x, 20, width-20);
      y = constrain(y, 20, height-20);
    }
    dx /= 2;
    dy /= 2;
  }
  
  void updateCount(int newCount) {
    count = newCount;
    if(count <0){
      count = 0;
    }
  }

  int getCount() {
    return count;
  }
  
  void seletctMe(){
    myColor = selectColor;
  }
  
  void deSeletctMe(){
    myColor = nodeColor;
  }
  
  void drawShadow(){
    
    fill(180);
    noStroke();
    
    if(type == 0){
      fill(64);
      ellipse(x+2, y+2, (count*0.15), (count*0.15));
    } 
    
    if(type == 1) {
      rectMode(CENTER);
      rect(x+2, y+2, (countIni*0.15), (countIni*0.15));
    }
    
    if(type == 2) {
      rectMode(CENTER);
       ellipse(x+2, y+2, (count*0.08), (count*0.08));
    }
    
    
  }

  void draw() {
    fill(myColor);
    noStroke();
    
   if(type == 0){
      // pueblo
      ellipse(x, y, 15, 15);
    } 
    
    
    if(type == 1) {
      // persona
      if(record){
        fill(255,0,0);
        ellipse(x,y,6,6);
        
      } else {
        rectMode(CENTER);
        rect(x, y, 15, 15);
      }
    }
    
    
    if(type == 2) {
      
       if(record){
         fill(0,255,0);
       }
       
     ellipse(x, y, (count*0.08), (count*0.08));
    }
    
    
    noFill();
    stroke(0);
    fill(myColor);
    
    
    if(type == 0){
      // aldea
      textFont(lugar);
      textAlign(CENTER, CENTER);
      fill(0);
      
      if(record){
        text(nText.toUpperCase(), x, y+18);
      } else {
        text(nText.toUpperCase(), x, y+18);
      }
      
    } 
    
    if(type == 1) {
      textAlign(LEFT, CENTER);
      textFont(persona, 10);
      
      fill(64);
       if(record){
         text(nText.toUpperCase(), x + 6, y);
       } else {
         text(nText.toUpperCase(), x + 12, y);
       }
    }
    
    
    
    if(type == 2) {
      
      if(record){
        fill(128);
        textAlign(LEFT, TOP);
        textFont(imagen,6);
        text(nText, x+6, y-6, 120, 300);
    }
      
    }
    
    
  }
}


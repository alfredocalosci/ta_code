void icon_staff(float x, float y, float w, color c){
  noStroke();
  fill(c);
  
  //ellipse(x, y-w/6, w*2/3, w*2/3);
  ellipse(x, y-w/12, w/12*5, w/12*5);
  arc(x, y+ w/2, w*2/3, w*2/3, -PI, 0);
  
  fill(255);
  rect(x-w/3, y+w/2-w/12, w*2/3, w/12);
  
}

void icon_inst(float x, float y, float w, color c){
   noStroke();
  fill(c);
  
  rect(x-w/12*5, y-w/6, w/6*5, w/3*2);
  
  triangle(x-w/12*5, y-w/2, x, y-w/6, x-w/12*5, y+w/2);
  triangle(x+w/12*5, y-w/2, x, y-w/6, x+w/12*5, y+w/2);  
}

void icon_inst_2(float x, float y, float w, color c) {
  noStroke();
  fill(c);

  rect(x-w/12*5, y-w/6, w/6*5, w/3);
  
  triangle(x-w/12*5, y-w/2, x, y-w/6, x-w/12*5, y-w/6);
  triangle(x+w/12*5, y-w/2, x, y-w/6, x+w/12*5, y-w/6);
  triangle(x-w/12*5, y+w/6, x, y+w/6, x, y+w/2);
  triangle(x+w/12*5, y+w/6, x, y+w/6, x, y+w/2);
}

void icon_edition(float x, float y, float w, color c){
   noStroke();
  fill(c);
  
  rect(x-w/12*5, y-w/2, w/6*5, w/3*2);
  triangle(x-w/12*5, y+w/6, x, y+w/6, x-w/12*5, y+w/2);
  triangle(x+w/12*5, y+w/6, x, y+w/6, x+w/12*5, y+w/2);
  
}

void icon_keyW(float x, float y, float w, color c){
  noStroke();
  fill(c);
  
  ellipse(x-w/6, y, w/3*2, w/3*2);
  
  ellipse(x+ w/12*5, y - w/4, w/6, w/6);
  ellipse(x+ w/12*5, y + w/4, w/6, w/6);
  
  rect(x-w/6, y-w/3, w/3*2 - w/12, w/3*2);
  rect(x+w/3, y-w/4, w/6 , w/2);
  
}

void icon_place(float x, float y, float w, color c){
  
  noStroke();
  fill(c);
  ellipse(x, y-w/12, w/3*2, w/3*2);
  triangle(x,y+w/2,x-w/24*7, y+w/12, x+w/24*7, y+w/12);
  
  fill(255);
  ellipse(x, y-w/12, w/3, w/3);
}

void icon_people(float x, float y, float w, color c){
  noStroke();
  fill(c);
  
  //ellipse(x, y-w/6, w*2/3, w*2/3);
  ellipse(x, y-w/12, w/12*5, w/12*5);
  arc(x, y+ w/2, w*2/3, w*2/3, -PI, 0);
  
}

void icon_img(float x, float y, float w, color c){
  noStroke();
  fill(c);
  
  ellipse(x- w/12*5, y - w/3, w/6, w/6);
  ellipse(x- w/12*5, y + w/3, w/6, w/6);
  ellipse(x, y - w/3, w/12, w/12);
  ellipse(x, y + w/3, w/12, w/12);
  ellipse(x+ w/12*5, y - w/3, w/6, w/6);
  ellipse(x+ w/12*5, y + w/3, w/6, w/6);
  
  rect(x- w/12*5, y - w/3, w/6*5,  w/3*2);
  
}

void icon_img_2(float x, float y, float w, color c) {
  noStroke();
  fill(c);
  rect(x- w/12*5, y - w/3, w/6*5, w/3*2);
  
  fill(255);
  rect(x- w/12*3, y - w/3+w/6, w/2, w/3);
}

void icon_keyW_2(float x, float y, float w, color c) {
  noStroke();
  fill(c);

  ellipse(x-w/4, y, w/2, w/2);
  rect(x-w/4, y-w/4, w/4*3 , w/2);
  
  //fill(0);
  //rect(x-w/6, y-w/8, w/12*6 , w/4);
}

void iconDot(float x, float y, float w, color c){
  noStroke();
  fill(c);
   ellipse(x, y, w, w);
}
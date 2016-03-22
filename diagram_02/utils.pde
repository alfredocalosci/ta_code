void resetDots() {
  
  reduceTo(popTarget);
  
  for (int n = 0; n<Punti.size (); n++) {
    dot p = Punti.get(n);    
    p.altro = int(random(Punti.size()));
  }
  println("reset dots");
}

void changeDotMode(int newMode) {
  for (int n = 0; n<Punti.size (); n++) {
    dot p = Punti.get(n);    
    p.dMode = newMode;
  }
  println("change Dot mode to: " + newMode);
}

void clusterModeTest() {
  
  for (int n = 0; n<Punti.size (); n++) {
    dot p = Punti.get(n);

    // set size
    char t = p.myType.charAt(0);

    switch(t) {

    case 'l': 
      p.w_target = 16;
      break;
    case 'i':
      p.w_target = 8;
      break;
    case 'p': 
      p.w_target = 12;
      break;
    case 'k': 
      p.w_target = 4;
      break;
    default: 
      p.w_target = 2; 
      break;
    }

    // reset it counter
    p.iterationCounter = 1;
  }
}

void reduceTo(int amount) {
  int dotToRemove = Punti.size() - amount;
  for (int n = 0; n<=dotToRemove; n++) {
    // remove dot
    int r_index = floor(random(Punti.size()-1));
    Punti.remove(r_index);
  }
}

void cloneDot() {
  // a random dot
  int n = floor(random(Punti.size()));
  dot p = Punti.get(n);
  dot np = new dot(p.loc.x, p.loc.y, p.w_target);

  Punti.add(np);
}


void imageDotMode() {
  PImage myFace_Canvas;
  PImage myFace;
  
  int randomIMG = floor(random(images.length));
  String myImg = images[randomIMG];
  
  myFace = loadImage(myImg); 
  myFace_Canvas = loadImage(myImg);

  // resize image
  if (myFace.width >= myFace.height) {
    myFace_Canvas.resize(squareTo, 0);
  } else {
    myFace_Canvas.resize(0, squareTo);
  }

  // dot population // from now to (img area)
  int popTarget = myFace_Canvas.width * myFace_Canvas.height;

  reduceTo(popTarget);

  for (int n = Punti.size (); n<popTarget; n++) {
    cloneDot();
  }

  // assign x y and w
  float g = (height / squareTo) * 0.98; //  dot grid
  PVector centro = new PVector(width/16 * 10, height/2);

  int dotW = floor(myFace_Canvas.width * g);
  int dotH = floor(myFace_Canvas.height * g);

  float deltaX = centro.x - (dotW/2);
  float deltaY = centro.y - (dotH/2);
  int count = 0;

  for (int n = 0; n< myFace_Canvas.width; n++) {
    for (int i = 0; i< myFace_Canvas.height; i++) {

      color col = myFace_Canvas.get(n, i);
      float b = brightness(col);
      float w = map(b, 0, 255, g, 0);// diametro

      float iX = deltaX + g + n*(g);
      float iY = deltaY + g + i*(g);

      dot p = Punti.get(count);
      count ++;

      p.locTarget.x = iX;
      p.locTarget.y = iY;

      p.w_target = w;
    }
  }

  // set mode to 1 / easing
  changeDotMode(1);
}


void assignData() {
  // make sure there are enought dots
   popTarget = t_editions.getRowCount() + t_images.getRowCount() + t_people.getRowCount() + t_keyW.getRowCount() + t_staff.getRowCount() + t_institutions.getRowCount()+ t_places.getRowCount();

  if (Punti.size() < popTarget) {
    // add dots
    for (int n = Punti.size (); n<popTarget; n++) {
      cloneDot();
    }
  }

  int counter = 0;   // counter

  // editions
  for (int n = 0; n<t_editions.getRowCount (); n++) {
    dot p = Punti.get(counter);
    p.myType = "e";
    // p.myNum = n;
    p.myNum = counter;
    p.myText = t_editions.getString(n, 1);
    p.myId = t_editions.getString(n, 0);

    t_editions.setInt(n, 3, counter);  
    counter ++;
  }

  // images
  for (int n = 0; n<t_images.getRowCount (); n++) {
    dot p = Punti.get(counter);
    p.myType = "i";
    // p.myNum = n;
    p.myNum = counter;
    p.myText = t_images.getString(n, 1);
    p.myId = t_images.getString(n, 0);

   t_images.setInt(n, 2, counter);  
    counter ++;
  }

  // people
  for (int n = 0; n<t_people.getRowCount (); n++) {
    dot p = Punti.get(counter);
    p.myType = "p";
    // p.myNum = n;
    p.myNum = counter;

    p.myText = t_people.getString(n, 1) + " " + t_people.getString(n, 2);
    p.myId = t_people.getString(n, 0);
   
   t_people.setInt(n, 3, counter);  

    counter ++;
  }

  // keyW
  for (int n = 0; n<t_keyW.getRowCount (); n++) {
    dot p = Punti.get(counter);
    p.myType = "k";
    // p.myNum = n;
    p.myNum = counter;
    p.myText = t_keyW.getString(n, 1);
    p.myId = t_keyW.getString(n, 0);

   t_keyW.setInt(n, 2, counter);  
    counter ++;
  }

  // staff
  for (int n = 0; n<t_staff.getRowCount (); n++) {
    dot p = Punti.get(counter);
    p.myType = "s";
    // p.myNum = n;
    p.myNum = counter;
    p.myText = t_staff.getString(n, 1) + " " + t_staff.getString(n, 2);
    p.myId = t_staff.getString(n, 0);

    t_staff.setInt(n, 4, counter);  
    counter ++;
  }

  // inst
  for (int n = 0; n<t_institutions.getRowCount (); n++) {
    dot p = Punti.get(counter);
    p.myType = "f";
    // p.myNum = n;
    p.myNum = counter;
    p.myText = t_institutions.getString(n, 1) + ", " + t_institutions.getString(n, 2);
    p.myId = t_institutions.getString(n, 0);

  t_institutions.setInt(n, 3, counter);  
    counter ++;
  }

  // places
  for (int n = 0; n<t_places.getRowCount (); n++) {
    dot p = Punti.get(counter);
    p.myType = "l"; // loci
    p.myNum = counter;
    p.myText = t_places.getString(n, 1);
    p.myId = t_places.getString(n, 0);
    
    p.c_group = counter;
     
    t_places.setInt(n, 2, counter); 

    counter ++;
  }

  dotPop = counter;
  println("Dot_Pop: " + counter);

  // img to people
  for (int a = 0; a<r_img_to_people.getRowCount (); a++) {
    String img_id = r_img_to_people.getString(a, 0);
    String people_id = r_img_to_people.getString(a, 1);

    // find people dot
    int iDot = getDotIndex(img_id, "i");
    int pDot = getDotIndex(people_id, "p");

    if (iDot >= 0 && pDot >= 0) {
      dot dotImage = Punti.get(iDot);
      dotImage.c_group = pDot;
      // println(a + ":" + iDot + " / " + pDot);
    }
  }

  // keyW to img
  for (int a = 0; a<r_img_to_keyW.getRowCount (); a++) {
    String img_id = r_img_to_keyW.getString(a, 0);
    String keyW_id = r_img_to_keyW.getString(a, 1);
    // find dots
    int iDot = getDotIndex(img_id, "i");
    int kDot = getDotIndex(keyW_id, "k");

    if (iDot >= 0 && kDot >= 0) {
      dot dotkw = Punti.get(kDot);
      dotkw.c_group = iDot;
    }
  }

  // people to places
  for (int a = 0; a<r_people_to_places.getRowCount (); a++) {
    String people_id = r_people_to_places.getString(a, 0);
    String place_id = r_people_to_places.getString(a, 1);

    // find dots
    int pDot = getDotIndex(people_id, "p");
    int lDot = getDotIndex(place_id, "l");

    if (pDot >= 0 && lDot >= 0) {
      dot dotPeople = Punti.get(pDot);
      dotPeople.c_group = lDot;
      // println(a + ":" + pDot + " / " + lDot);
    }
  }

  // remove the rest of dots
  if (Punti.size() > (counter+1)) {
    // println(Punti.size() + " / " + counter);
    int dotToRemove = Punti.size() - counter;
    for (int n = 0; n<dotToRemove; n++) {
      // remove last
      Punti.remove(Punti.size()-1);
    }
  }

  // riassign altro
  for (int n = 0; n<Punti.size (); n++) {
    dot p = Punti.get(n);    
    p.altro = int(random(Punti.size()));
  }
}

// isoViz variables

float iniX = 16;
float iniY = 16;
float gridSize = 14;
int numCol = 40; // 24
float pad = 0.95; // padding , 0.75

void isoViz() {
  // columns
  float Ysofar = iniY;
  float tag_x = iniX +(gridSize*numCol) + iniX;

  // editions
  float Ymax = Ysofar;

  // tag editions
  tag t_e = new tag(tag_x, Ymax, "_FASES");
  Tags.add(t_e);

  for (int n = 0; n<t_editions.getRowCount (); n++) {
    int dotNumber = t_editions.getInt(n, 3);
    dot p = Punti.get(dotNumber);

    PVector myLoc = getMatrixLoc(n, Ysofar);

    p.locTarget.x = myLoc.x;
    p.locTarget.y = myLoc.y;
    p.w_target = gridSize * pad; 

    Ymax = updateMaxValue(myLoc.y, Ymax);
  }

  Ysofar = Ymax + gridSize;
  Ymax = Ysofar;

  tag t_l = new tag(tag_x, Ymax, "_LUGARES");
  Tags.add(t_l);
  // places

  for (int n = 0; n<t_places.getRowCount (); n++) {
    int dotNumber = t_places.getInt(n, 2);
    dot p = Punti.get(dotNumber);

    PVector myLoc = getMatrixLoc(n, Ysofar);

    p.locTarget.x = myLoc.x;
    p.locTarget.y = myLoc.y;
    p.w_target = gridSize * pad; 

    Ymax = updateMaxValue(myLoc.y, Ymax);
  }


  Ysofar = Ymax + gridSize;
  Ymax = Ysofar;
  // people
  tag t_p = new tag(tag_x, Ymax, "_CONSERVADORES DOMÉSTICOS");
  Tags.add(t_p);

  for (int n = 0; n<t_people.getRowCount (); n++) {
    int dotNumber = t_people.getInt(n, 3);
    dot p = Punti.get(dotNumber);

    PVector myLoc = getMatrixLoc(n, Ysofar);

    p.locTarget.x = myLoc.x;
    p.locTarget.y = myLoc.y;
    p.w_target = gridSize * pad; 

    Ymax = updateMaxValue(myLoc.y, Ymax);
  }

  Ysofar = Ymax + gridSize;
  Ymax = Ysofar;

  // img
  tag t_i = new tag(tag_x, Ymax, "_IMÁGENES");
  Tags.add(t_i);

  for (int n = 0; n<t_images.getRowCount (); n++) {
    int dotNumber = t_images.getInt(n, 2); 
    dot p = Punti.get(dotNumber);

    PVector myLoc = getMatrixLoc(n, Ysofar);

    p.locTarget.x = myLoc.x;
    p.locTarget.y = myLoc.y;
    p.w_target = gridSize * pad; 

    Ymax = updateMaxValue(myLoc.y, Ymax);
  }
  // keyW
  Ysofar = Ymax + gridSize;
  Ymax = Ysofar;

  tag t_k = new tag(tag_x, Ymax, "_FOLKSONOMÍAS");
  Tags.add(t_k);

  for (int n = 0; n<t_keyW.getRowCount (); n++) {
    int dotNumber = t_keyW.getInt(n, 2);
    dot p = Punti.get(dotNumber);

    PVector myLoc = getMatrixLoc2(n, Ysofar);

    p.locTarget.x = myLoc.x;
    p.locTarget.y = myLoc.y;
    p.w_target = gridSize/2 * pad; 

    Ymax = updateMaxValue(myLoc.y, Ymax);
  }

  Ysofar = Ymax + gridSize;
  Ymax = Ysofar;

  // t_staff
  tag t_S = new tag(tag_x, Ymax, "_COLABORADRES");
  Tags.add(t_S);

  for (int n = 0; n<t_staff.getRowCount (); n++) {
    //println(t_staff.getString(n, 2));
    int dotNumber = t_staff.getInt(n, 4);
    dot p = Punti.get(dotNumber);

    PVector myLoc = getMatrixLoc(n, Ysofar);

    p.locTarget.x = myLoc.x;
    p.locTarget.y = myLoc.y;
    p.w_target = gridSize * pad; 

    Ymax = updateMaxValue(myLoc.y, Ymax);
  }

  // t_institutions
  Ysofar = Ymax + gridSize;
  Ymax = Ysofar;

  tag t_I = new tag(tag_x, Ymax, "_INSTITUCIONES");
  Tags.add(t_I);

  for (int n = 0; n<t_institutions.getRowCount (); n++) {
    //println(t_staff.getString(n, 2));
    int dotNumber = t_institutions.getInt(n, 3);
    dot p = Punti.get(dotNumber);

    PVector myLoc = getMatrixLoc(n, Ysofar);

    p.locTarget.x = myLoc.x;
    p.locTarget.y = myLoc.y;
    p.w_target = gridSize * pad; 

    Ymax = updateMaxValue(myLoc.y, Ymax);
  }

  // places > assign loc "manually"

  // assign x and y target
  // texts ?
  all_Color();
}

PVector getMatrixLoc(int n, float Ysofar) {

  PVector myLoc = new PVector(0, 0);

  float fila = floor(n/numCol);
  float columna = floor(n%numCol);

  float myX = gridSize/2 + iniX + (columna * gridSize);
  float myY = gridSize/2 + Ysofar + (fila * gridSize);

  myLoc.x = myX;
  myLoc.y = myY;

  return myLoc;
}

PVector getMatrixLoc2(int n, float Ysofar) {

  PVector myLoc = new PVector(0, 0);

  float fila = floor(n/(numCol*2));
  float columna = floor(n%(numCol*2));

  float myX = gridSize/2 + iniX + (columna * (gridSize/2));
  float myY = gridSize/2 + Ysofar + (fila * (gridSize/2));

  myLoc.x = myX;
  myLoc.y = myY;

  return myLoc;
}

float updateMaxValue(float a, float b) {
  if ( a > b) {
    return a;
  } else {
    return a;
  }
}

int getDotIndex(String my_id, String my_Type) {
  int NN = -1;
  for (int n = 0; n<Punti.size (); n++) {
    dot p = Punti.get(n); 
    String tmp_type = p.myType;
    String tmp_id = p.myId;

    if (tmp_type.equals(my_Type) && tmp_id.equals(my_id)) {
      NN = n;
      break;
    }
  }
  return NN;
}

void all_Whites() {
  for (int n = 0; n<Punti.size (); n++) {
    dot p = Punti.get(n); 
    p.whiteMe();
  }
}

void all_Gray() {
  for (int n = 0; n<Punti.size (); n++) {
    dot p = Punti.get(n); 
    p.grayMe();
  }
}

void all_Color() {
  for (int n = 0; n<Punti.size (); n++) {
    dot p = Punti.get(n); 
    p.colorizeMe();
  }
}

void orbit() {
  // assign los on an "orbita" plot

    // ** 1 ** places to center
  orbita O_1 = new orbita(width/16 * 10, height/2, height/4); // center

  // add places to Orbita 1
  for (int n = 0; n<t_places.getRowCount (); n++) {
    String myId = t_places.getString(n, 0);
    int dotIndex = getDotIndex(myId, "l");
    if (dotIndex >= 0) {
      dot p = Punti.get(dotIndex);
      O_1.Elements.add(p);
    }
  }

  // assign locs
  O_1.assignLocs();

  // loock for people
  // ** 2 ** people to places
  ArrayList <orbita> AnelliP = new ArrayList();

  for (int n = 0; n<O_1.Elements.size (); n++) {
    dot p = O_1.Elements.get(n);
    String place_Id = p.myId;
    orbita o = new orbita(p.locTarget.x, p.locTarget.y, height/10);

    for (int a = 0; a<r_people_to_places.getRowCount (); a++) {
      if (place_Id.equals(r_people_to_places.getString(a, 1))) {
        String people_id = r_people_to_places.getString(a, 0);


        int pDot = getDotIndex(people_id, "p");
        if (pDot >= 0) {
          dot ppDot = Punti.get(pDot);
          o.Elements.add(ppDot);
        }
      }
    }

    AnelliP.add(o);
  }

  ArrayList <orbita> AnelliI = new ArrayList();

  // *** images to people
  for (int n = 0; n<AnelliP.size (); n++) {

    // assign locs > people
    orbita o = AnelliP.get(n);
    o.assignLocs();

    // loop orbits
      for (int a = 0; a < o.Elements.size (); a++) {
      dot p = o.Elements.get(a);

      String people_Id = p.myId;
      orbita q = new orbita(p.locTarget.x, p.locTarget.y, height/20);

      for (int b = 0; b<r_img_to_people.getRowCount (); b++) {

        if (people_Id.equals(r_img_to_people.getString(b, 1))) {
          String image_id = r_img_to_people.getString(b, 0);
          int pDot = getDotIndex(image_id, "i");

          if (pDot >= 0) {
            dot ppDot = Punti.get(pDot);
            q.Elements.add(ppDot);
          }
        }
      }

      AnelliI.add(q);
      q.assignLocs();
    } // orbits
  }
  // // keyW to images
    // orbita exterior para keyW
  orbita O_KW = new orbita(width/16 * 10, height/2, height/2*0.9); // center
  // add KW to Orbita KW
  for (int n = 0; n<t_keyW.getRowCount (); n++) {
    String myId = t_keyW.getString(n, 0);
    int dotIndex = getDotIndex(myId, "k");
    if (dotIndex >= 0) {
      dot p = Punti.get(dotIndex);
      O_KW.Elements.add(p);
    }
  }
  // assign locs
  O_KW.assignLocs();
  
  // staff, editions and foundations
}

void setDotMode(boolean newMode) {
  for (int n = 0; n<Punti.size (); n++) {
    dot p = Punti.get(n);
    p.dotMode = newMode;
  }
}

void tagsOut() {
  for (int n = 0; n<Tags.size (); n++) {
    tag t = Tags.get(n);
    t.out = true;
  }
}
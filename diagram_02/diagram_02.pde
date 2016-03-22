// contenitore di punti
ArrayList <dot> Punti;
ArrayList <dot> HL_Punti;

// contenitore di testi
ArrayList <tag> Tags;

// data
Table_data t_people, t_images, t_places, t_keyW, t_staff, t_editions, t_institutions;
// relations
Table_data r_img_to_people, r_people_to_places, r_editions_to_places, r_img_to_keyW, r_staff_to_editions, r_institutions_to_editions;

int squareTo; // halftone image resolution
int dotPop; // dot Population
int popTarget;

PFont lugar;

int activeDotNum;
int vizMode;
int bigTimeCount, smallTimeCount, bigTime, smallTime;

String txt_01, txt_02, txt_03, txt_04;

// This code will print all the lines from the source text file.
String[] images;


void setup() {
  size( 1280, 720 );
  frameRate(24);

  // load data
  t_people = new Table_data("people.csv");
  t_images = new Table_data("images.csv");
  t_places = new Table_data("places.csv");
  t_keyW = new Table_data("keyW.csv");
  t_staff = new Table_data("staff.csv");
  t_editions = new Table_data("editions.csv");
  t_institutions = new Table_data("institutions.csv");

  // load relations
  r_img_to_people = new Table_data("images_to_people.csv");
  r_people_to_places = new Table_data("people_to_places.csv");
  r_editions_to_places = new Table_data("editions_to_places.csv");
  r_img_to_keyW= new Table_data("img_to_keyW.csv");
  r_staff_to_editions= new Table_data("staff_to_editions.csv");
  r_institutions_to_editions= new Table_data("institutions_to_editions.csv");

  // img list
  images = loadStrings("img_list.txt");
  //println("there are " + images.length + " images");

  //font = font = loadFont("BotanikaMono-Bold-18.vlw");
  lugar = createFont("BotanikaMono-8-Heavy.otf", 18);

  textFont(lugar, 12);

  Punti = new ArrayList();
  HL_Punti = new ArrayList();

  squareTo = 72; // img

  Tags = new ArrayList();

  for (int n = 0; n<1200; n++) {
    dot p = new dot(random(width), random(height), 5);
    Punti.add(p);
  }

  activeDotNum = -1;
  // data to dots
  assignData();
  //isoViz();

  txt_01 = "";
  txt_02 = "";
  txt_03 = "";
  txt_04 = "";

  // time

  bigTime = floor(random(5, 7)*24);
}

void draw() {
  background(255);

  // txt mode 4 > pack
  if (vizMode == 4) {

    float f1 = 0;
    float f2 = 128;
    float f3 = 255-64;
    float f4 = 255-48;

    //fade   
    if (bigTimeCount < bigTime/4) {
      f1 = map(bigTimeCount, 0, bigTime/4, 255, 0);
      f2 = map(bigTimeCount, 0, bigTime/4, 255, 128);
      f3 = map(bigTimeCount, 0, bigTime/4, 255, 255-64);
      f4 = map(bigTimeCount, 0, bigTime/4, 255, 255-48);
    }

    if (bigTimeCount > bigTime* 3/4) {
      f1 = map(bigTimeCount, bigTime* 3/4, bigTime, 0, 255);
      f2 = map(bigTimeCount, bigTime* 3/4, bigTime, 128, 255);
      f3 = map(bigTimeCount, bigTime* 3/4, bigTime, 255-64, 255);
      f4 = map(bigTimeCount, bigTime* 3/4, bigTime, 255-48, 255);
    }

    textAlign(LEFT, TOP);

    fill(f1);
    textFont(lugar, 18);
    text(txt_01, 24, height/3);  

    fill(f2);
    textFont(lugar, 14);
    textLeading(16);
    text(txt_02, 24, height/3 + 21 + 16, 400, 320);  
    // 58 char

    int nextY = height/3 + 21 + 16 +  floor(txt_02.length()/ 50)*21 + 16;

    fill(f3);
    textFont(lugar, 12);
    textLeading(12);
    text(txt_03, 24, nextY, 400, height - nextY - 32);

    fill(f4);
    //text(txt_04, width - 180, 24, 180-16, height - 24 - 32);
    text(txt_04, 24, 24, 400, height/3 - 48);
  }

  // display dots
  noStroke();
  for (int n = 0; n<Punti.size (); n++) {
    dot p = Punti.get(n);
    p.display();
    p.update(n);
  }

  textAlign(LEFT, TOP);
  textFont(lugar, 12);

  // display txt
  if (vizMode == 2 || vizMode == 0) {
    for (int n = 0; n<Tags.size (); n++) {
      tag t = Tags.get(n);
      t.display();
      t.fade();
      // cleanUp
      if (t.out && t.alpha == 0) {
        Tags.remove(n);
      }
    }
  }

  // display the rest
  if (activeDotNum >= 0) {
    // mark icon
    dot activeDot = Punti.get(activeDotNum); 

    if (vizMode == 2) { // ISO
      String dot_type = activeDot.myType;
      if (dot_type.equals("e")) {
        icon_edition(activeDot.loc.x, activeDot.loc.y, activeDot.w, color (128, 0, 0));
      } else {
        // is L
        icon_place(activeDot.loc.x, activeDot.loc.y, activeDot.w, color (128, 0, 0));
      }
    }

    if (vizMode == 4) { // ISO
      iconDot(activeDot.loc.x, activeDot.loc.y, activeDot.w, color (128, 0, 0));
    }
  }

  // time manager
  // bigTimeCount, smallTimeCount, bigTime, smallTime

  bigTimeCount ++;
  if (bigTimeCount > bigTime) {

    // reset counters
    bigTimeCount = 0;
    //bigTime = floor(random(5, 7)*24);
    bigTime = floor(random(7, 9)*24);



    switch(vizMode) {
    case 0: 
      newVizMode();
      break;
    case 1: 
      changeVizMode(0);
      break;
    case 2: 
      if (smallTime > 3) {
        changeVizMode(0);
      } else {
        smallTime ++;
        randomHL();
      }
      break;
    case 3: 
      changeVizMode(4);
      break;
    case 4: 
      if (smallTime > 3) {
        changeVizMode(0);
      } else {
        smallTime ++;
        randomHLPlace();
      }
      break;
    default:             // Default executes if the case labels
      changeVizMode(0);
      break;
    }
  }
}

void newVizMode() {
  int rn = floor(random(7));
  println("new Viz: " + rn);

  if (rn <=4) {
    // image
    println("Viz to image");
    changeVizMode(1);
  } 

  if (rn == 5) {
    // iso
    println("Viz to ISO");
    changeVizMode(2);
  } 

  if (rn == 6) {
    // pack
    println("Viz to pack");
    changeVizMode(3);
  }
}


void changeVizMode(int newMode) {

  vizMode = newMode;

  switch(newMode) {

  case 0: 
    activeDotNum = -1;
    all_Whites();
    resetDots();
    setDotMode(true);
    changeDotMode(0);
    tagsOut();
    txt_01 = "";
    txt_02 = "";
    txt_03 = "";
    txt_04 = "";
    smallTime = 0;
    break;

  case 1: // img
    all_Whites();
    imageDotMode();
    break;

  case 2: // iso
    assignData();
    isoViz();
    changeDotMode(1);
    //all_Color();
    setDotMode(false);
    
    break;

  case 3: // pack
    reduceTo(popTarget);
    assignData();
    
    orbit();
    all_Color();
    changeDotMode(1);
    break;

  case 4: // pack
    all_Color();
    clusterModeTest();
    changeDotMode(2);
    break;
  }
}
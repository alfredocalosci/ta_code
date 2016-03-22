void keyPressed() {

  if (key == ' ') {
    // riassegna
    resetDots();
  }

  if (key == '0') {
    // random walk
    // reduceTo(1200);
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
  }

  if (key == '1') {
    // to position
    // max 1200
    //all_Whites();
    all_Color();
    changeDotMode(1);
  }

  if (key == '2') {
    // riassegna
    all_Color();
    clusterModeTest();
    changeDotMode(2);
    //println("cluster Pop: " + Clusters.size());
  }

  if (key == '3') {
    // isoViz
    //all_Whites();
    assignData();
    isoViz();
    changeDotMode(1);
    setDotMode(false);
  }

  if (key == 'q') {
    // clone one
    cloneDot();
  }

  if (key == 'i') {
    // image mode
    all_Whites();
    imageDotMode();
  }

  if (key == 'o' || key == '4') {
    // orbit
    assignData();
    all_Color();
    orbit();
    changeDotMode(1);
  }

  if (key == 's') {
    // orbit
    saveFrame("t_a_2014-######.pnXg");
  }

  if (key == 'z') {
    // orbit
    setDotMode(true);
  }

  if (key == 'x') {
    // orbit
    setDotMode(false);
  }

  if (key == 't') { // test
    randomHL();
  }

  if (key == 'y') { // test
    randomHLPlace();
  }


  //
}
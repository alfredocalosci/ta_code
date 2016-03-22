void highlightMe(String type, String myId) {
  // reset
  HL_Punti = new ArrayList();

  char t = type.charAt(0);

  switch(t) {

  case 'e': // edition
    // top > bottom
    addEdition(myId);
    // markMe

    break;

  case 'l': // place
    // top > bottom
    addPlace(myId);

    // bottom > top
    // add edition
    addEditionBottom(myId);
    addStaffBottom(myId);
    addInstBottom(myId);
    break;
  }
}

void clean_HL_Dots() {
  // remove duplicated dots
  for (int n = 0; n<HL_Punti.size (); n++) {
    dot p = HL_Punti.get(n);
    String p_id = p.myId;
    String p_type = p.myType;

    // the others
    for (int i=n+1; i<HL_Punti.size (); i++) {
      dot q = HL_Punti.get(i);
      String q_id = q.myId;
      String q_type = q.myType;

      if (p_id.equals(q_id) && p_type.equals(q_type)) {
        // remove
        HL_Punti.remove(i);
      }
    }
  }
}

void display_HL_Dots() {
  // reset
  all_Gray();
  for (int n = 0; n<HL_Punti.size (); n++) {
    dot p = HL_Punti.get(n);
    p.gray_target = 0;
  }
}

// top > bottom scripts

void addEdition(String myId) {
  // add mySelf
  int dotN = getDotIndex(myId, "e");
  if (dotN >= 0) {
    dot p = Punti.get(dotN);
    HL_Punti.add(p);
  }

  // add places
  // arrayPlacesToAdd
  String[] toAdd = {
  };

  for (int n = 0; n<r_editions_to_places.getRowCount (); n++) {

    String e_Id = r_editions_to_places.getString(n, 0);
    String l_Id = r_editions_to_places.getString(n, 1);

    if (e_Id.equals(myId)) {
      // add l_Id to the array
      int NN = toAdd.length;
      toAdd = expand(toAdd, NN + 1);
      toAdd[NN] = l_Id;
    }
  }

  for (int n = 0; n< toAdd.length; n++) {
    addPlace(toAdd[n]);
  }

  // add staff
  addStaffFromEdition(myId);

  // add inst
  addInstFromEdition(myId);
}

void addPlace(String myId) {

  // add mySelf
  int dotN = getDotIndex(myId, "l");
  if (dotN >= 0) {
    dot p = Punti.get(dotN);
    HL_Punti.add(p);
  }

  // add people
  // arrayPeopleToAdd
  String[] toAdd = {
  };

  for (int n = 0; n<r_people_to_places.getRowCount (); n++) {
    String p_Id = r_people_to_places.getString(n, 0);
    String l_Id = r_people_to_places.getString(n, 1);

    if (l_Id.equals(myId)) {
      // add l_Id to the array
      int NN = toAdd.length;
      toAdd = expand(toAdd, NN + 1);
      toAdd[NN] = p_Id;
    }
  }

  // next step
  for (int n = 0; n< toAdd.length; n++) {
    addPeople(toAdd[n]);
  }
}

void addPeople(String myId) {
  // add mySelf
  int dotN = getDotIndex(myId, "p");
  if (dotN >= 0) {
    dot p = Punti.get(dotN);
    HL_Punti.add(p);
  }

  // add images
  // arrayImagesToAdd
  String[] toAdd = {
  };

  for (int n = 0; n<r_img_to_people.getRowCount (); n++) {
    String i_Id = r_img_to_people.getString(n, 0);
    String p_Id = r_img_to_people.getString(n, 1);

    if (p_Id.equals(myId)) {
      // add l_Id to the array
      int NN = toAdd.length;
      toAdd = expand(toAdd, NN + 1);
      toAdd[NN] = i_Id;
    }
  }

  // next step
  for (int n = 0; n< toAdd.length; n++) {
    addImage(toAdd[n]);
  }
}

void addImage(String myId) {
  // add mySelf
  int dotN = getDotIndex(myId, "i");
  if (dotN >= 0) {
    dot p = Punti.get(dotN);
    HL_Punti.add(p);
  }

  // add keyW
  // arrayKWToAdd
  String[] toAdd = {
  };

  for (int n = 0; n<r_img_to_keyW.getRowCount (); n++) {
    String i_Id = r_img_to_keyW.getString(n, 0);
    String k_Id = r_img_to_keyW.getString(n, 1);

    if (i_Id.equals(myId)) {
      // add l_Id to the array
      int NN = toAdd.length;
      toAdd = expand(toAdd, NN + 1);
      toAdd[NN] = k_Id;
    }
  }

  // next step
  for (int n = 0; n< toAdd.length; n++) {
    addKW(toAdd[n]);
  }
}

void addKW(String myId) {
  // add mySelf
  int dotN = getDotIndex(myId, "k");
  if (dotN >= 0) {
    dot p = Punti.get(dotN);
    HL_Punti.add(p);
  }
}

void addStaff(String myId) {
  // add mySelf
  int dotN = getDotIndex(myId, "s");
  if (dotN >= 0) {
    dot p = Punti.get(dotN);
    HL_Punti.add(p);
  }
}

void addInst(String myId) {
  // add mySelf
  int dotN = getDotIndex(myId, "f");
  if (dotN >= 0) {
    dot p = Punti.get(dotN);
    HL_Punti.add(p);
  }
}

String getEditionByPlace(String myId) { // place ID // unique edition

  String theID = "none";

  for (int n = 0; n<r_editions_to_places.getRowCount (); n++) {
    String e_Id = r_editions_to_places.getString(n, 0);
    String l_Id = r_editions_to_places.getString(n, 1);

    if (l_Id.equals(myId)) {
      theID = e_Id;
      break;
    }
  }

  return theID;
}

void addEditionBottom(String myId) { // place ID

  String myEditionID = getEditionByPlace(myId);
  if (!myEditionID.equals("none")) {
    int dotN = getDotIndex(myEditionID, "e");
    if (dotN >= 0) {
      dot p = Punti.get(dotN);
      HL_Punti.add(p);
    }
  }
}

void addStaffBottom(String placeId) {
  String myEditionID = getEditionByPlace(placeId);

  if (!myEditionID.equals("none")) {
    addStaffFromEdition(myEditionID);
  }
}

void addInstBottom(String placeId) {
  String myEditionID = getEditionByPlace(placeId);

  if (!myEditionID.equals("none")) {
    addInstFromEdition(myEditionID);
  }
}

void addStaffFromEdition(String myId) {
  // add staff
  String[] toAdd2 = {
  };
  // staff
  for (int n = 0; n<r_staff_to_editions.getRowCount (); n++) {

    String s_Id = r_staff_to_editions.getString(n, 0);
    String e_Id = r_staff_to_editions.getString(n, 1);

    if (e_Id.equals(myId)) {
      // add l_Id to the array
      int NN = toAdd2.length;
      toAdd2 = expand(toAdd2, NN + 1);
      toAdd2[NN] = s_Id;
    }
  }

  for (int n = 0; n< toAdd2.length; n++) {
    addStaff(toAdd2[n]);
  }
}

void addInstFromEdition(String myId) {
  String[] toAdd3 = {
  };

  for (int n = 0; n<r_institutions_to_editions.getRowCount (); n++) {

    String f_Id = r_institutions_to_editions.getString(n, 0);
    String e_Id = r_institutions_to_editions.getString(n, 1);

    if (e_Id.equals(myId)) {
      // add l_Id to the array
      int NN = toAdd3.length;
      toAdd3 = expand(toAdd3, NN + 1);
      toAdd3[NN] = f_Id;
    }
  }

  for (int n = 0; n< toAdd3.length; n++) {
    addInst(toAdd3[n]);
  }
}

void randomHL() {
  // type l OR e
  float rT = random(1);
  String type, iD;

  // active Dot
  if (rT < 0.5) {
    type = "e";
    int n = floor(random(t_editions.getRowCount ()));
    iD = t_editions.getString (n, 0);
  } else {
    // L
    type = "l";
    int n = floor(random(t_places.getRowCount ()));
    iD = t_places.getString (n, 0);
  }

  int _activeDotNum = getDotIndex(iD, type);

  if (_activeDotNum >= 0) {
    activeDotNum = _activeDotNum;
  }

  highlightMe(type, iD);
  clean_HL_Dots();
  display_HL_Dots();
  HL_text();
}

// txt_01, txt_02, txt_03
// lugar
// people
// images

void HL_text() {
  txt_01 = "";
  txt_02 = "";
  txt_03 = "";
  txt_04 = "";

  for (int n = 0; n<HL_Punti.size (); n++) {
    dot p = HL_Punti.get(n);

    char t = p.myType.charAt(0);

    switch(t) {
    case 'l': 
      txt_01 = txt_01 + p.myText.toUpperCase() + " ";

      break;
    case 'i': 
      txt_03 = txt_03 + p.myText + " ";
      break;

    case 'k': 
      txt_04 = txt_04 + p.myText + " ";
      break;

    case 'p': 
      txt_02 = txt_02 + p.myText + " ";
      break;
    }
  }
}

void randomHLPlace() {
  // type l OR e

    String type, iD;

  type = "l";
  int n = floor(random(t_places.getRowCount ()));
  iD = t_places.getString (n, 0);

  int _activeDotNum = getDotIndex(iD, type);

  if (_activeDotNum >= 0) {
    activeDotNum = _activeDotNum;
  }

  highlightMe(type, iD);
  clean_HL_Dots();
  display_HL_Dots();
  HL_text();
}
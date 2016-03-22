class Table_data {
  String[][] data;
  int rowCount;

  Table_data(String filename) {
    String[] rows = loadStrings(filename);
    data = new String[rows.length][];

    for (int i = 0; i < rows.length; i++) {
      
      // split the row on the tabs
      String[] pieces = split(rows[i], "\t");
      // add an extra item for dot number >> my stuff
      String[] pieces2 = append(pieces, "0"); 
      // copy to the table array
      data[rowCount] = pieces2;
      rowCount++;

      // this could be done in one fell swoop via:
      //data[rowCount++] = split(rows[i], TAB);
    }
    // resize the 'data' array as necessary
    data = (String[][]) subset(data, 0, rowCount);
  }

  int getRowCount() {
    return rowCount;
  }

  // find a row by its name, returns -1 if no row found
  String getRowName(int row) {
    return getString(row, 0);
  }

  String getString(int rowIndex, int column) {
    return data[rowIndex][column];
  }
  
  int getInt(int rowIndex, int column) {
    return parseInt(getString(rowIndex, column));
  }

  float getFloat(int rowIndex, int column) {
    return parseFloat(getString(rowIndex, column));
  }

  void setRowName(int row, String what) {
    data[row][0] = what;
  }

  void setString(int rowIndex, int column, String what) {
    data[rowIndex][column] = what;
  }

 void setInt(int rowIndex, int column, int what) {
    data[rowIndex][column] = str(what);
  }
  
  void setFloat(int rowIndex, int column, float what) {
    data[rowIndex][column] = str(what);
  }
 
}
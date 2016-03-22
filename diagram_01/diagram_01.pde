int nodeCount;
Node[] nodes = new Node[100];
HashMap nodeTable = new HashMap();

int edgeCount;
int edge2Count;
Edge[] edges = new Edge[500];
Edge[] edges2 = new Edge[500];

//static final color nodeColor   = #c8bcaf;
static final color nodeColor   = #000000;
//static final color selectColor = #31438F;
static final color selectColor = #5960A8;
static final color chainColor = #808080;
static final color fixedColor  = #FF8080;
//static final color fixedColor  = #808080;
static final color edgeColor   = #000000;

// pantone 660 - 0,93,168
// #5960A8

PFont font,lugar, persona,imagen ;

StringTable links;
int numLinee;
StringTable links2;
int numLinee2;

ArrayList inCatena;
Node selection, exselection, nodoAttivo; 

// time
int conta;

// 
boolean relax_mode;


// pdf
import processing.pdf.*;
boolean record;


void setup() {
  size(900,600);
  smooth();
  
  links = new StringTable("lista_completa_AC2.txt");
  numLinee = links.getRowCount();
  
  links2 = new StringTable("lista_completa_B.txt");
  numLinee2 = links2.getRowCount();

  font = createFont("BotanikaMono-Lite", 10);
  imagen = createFont("BotanikaMono-3-Lite.otf", 6);
  persona = createFont("BotanikaMono-7-Bold.otf", 10);
  lugar = createFont("BotanikaMono-8-Heavy.otf", 18);
 
  loadData();
  inCatena = new ArrayList(); 
  exselection = null;
  
  conta = 0;
  relax_mode = true;
  record = false;

}

void draw() {
  
  if (record) {
    // Note that #### will be replaced with the frame number. Fancy!
    textMode(SHAPE);
    beginRecord(PDF, "frame-####.pdf"); 
  } else {
     textMode(MODEL);
  }
  
  
  background(#eeeeee);
  
  
  if(relax_mode){
    for (int i = 0 ; i < edgeCount ; i++) {
    edges[i].relax();
  }
  
  for (int i = 0; i < nodeCount; i++) {
    nodes[i].relax();
  }
  
  for (int i = 0; i < nodeCount; i++) {
    nodes[i].update();
  }
  
  }
  
  
  for (int i = 0 ; i < edgeCount ; i++) {
    edges[i].draw();
  }
  
  for (int i = 0 ; i < edge2Count ; i++) {
    edges2[i].draw();
  }
  
 if (!record) {
  for (int i = 0 ; i < nodeCount ; i++) {
    nodes[i].drawShadow();
  }
 }
  
  for (int i = 0 ; i < nodeCount ; i++) {
    nodes[i].draw();
  }
  
  // msg txt
  if(!record){
    fill(128);
    textAlign(CENTER, CENTER);
    textFont(imagen,12);
    String msg = "press [R] to froze; [S] to save";
    
    if(!relax_mode){
      msg = "pulse [R] para reactivar la vibración";
    }
    text(msg, width/2, height - 60);
  }
  
  
  if (record) {
    endRecord();
    record = false;
  }
  
  
}

void loadData() {
  for (int i = 0; i < numLinee; i++) { 
      addEdge(links.getString(i,0),links.getString(i,1), links.getString(i,2), links.getString(i,3));
   }
   
   for (int i = 0; i < numLinee2; i++) { 
     addEdge2(links.getString(i,0),links.getString(i,1), links.getString(i,2), links.getString(i,3));
 }
   
   
   
}
void addEdge2(String fromLabel, String fromText, String toLabel, String toText) {
  Node from = findNode(fromLabel,fromText);
  Node to = findNode(toLabel, toText);
  
  from.increment();
  to.increment();
  
  for (int i = 0; i < edge2Count; i++) {
    if (edges2[i].from == from && edges2[i].to == to) {
      edges2[i].increment();
      return;
    }
  }
  
 
  Edge e = new Edge(from, to, 90, 0.35);
  e.increment();
  
  if (edge2Count == edges2.length) {
    edges2 = (Edge[]) expand(edges2);
  }
  edges2[edge2Count++] = e;
  
}

void addEdge(String fromLabel, String fromText, String toLabel, String toText) {

  Node from = findNode(fromLabel,fromText);
  Node to = findNode(toLabel, toText);
  
  from.increment();
  to.increment();
  
  for (int i = 0; i < edgeCount; i++) {
    if (edges[i].from == from && edges[i].to == to) {
      edges[i].increment();
      return;
    }
  } 
  
  // edge thiknes
  String f = fromLabel.substring(0, 1);
  String t = toLabel.substring(0, 1);
 
  float T;
  
  if(f.equals("a") || t.equals("a")){
    T = 1.3;
  } else {
     T = 0.35;
  }
  
  Edge e = new Edge(from, to, 90, T);
  
  e.increment();
  if (edgeCount == edges.length) {
    edges = (Edge[]) expand(edges);
  }
  edges[edgeCount++] = e;
}


Node findNode(String label, String nText) {
  label = label.toLowerCase();
  Node n = (Node) nodeTable.get(label);
  if (n == null) {
    return addNode(label, nText);
  }
  return n;
}


Node addNode(String label, String nText) {
  // println(Ntype);
  Node n = new Node(label, nText);  
  if (nodeCount == nodes.length) {
    nodes = (Node[]) expand(nodes);
  }
  nodeTable.put(label, n);
  nodes[nodeCount++] = n;  
  return n;
 
}

void findCatena(String label){
  // azzera gli atri nodi
  for (int i = inCatena.size()-1; i >= 0; i--) { 
    Node X = (Node) inCatena.get(i);
    X.myColor = nodeColor;
    inCatena.remove(i);
  }
  
  for (int i = 0 ; i < edgeCount ; i++) {
    Edge a = edges[i];
    Node F = a.from;
    Node T = a.to;
    
    String AA = F.label;
    String BB = T.label;
    
    if(AA.equals(label) | BB.equals(label) ){
      
      if(AA.equals(label)){
        // aggiunge il nodo di BB
        inCatena.add(T);
      } else{
        // aggiunge il nodo di AA
        inCatena.add(F);
      }
    }
  }
  
  nodoAttivo.myColor = selectColor;
  
  // azzera
  if (exselection != null) {
     exselection.fixed = false;
     exselection.myColor = nodeColor;
  }
  
  // gira tra i nodi in catena
  for (int i = inCatena.size()-1; i >= 0; i--) { 
    Node X = (Node) inCatena.get(i);
    X.myColor = color(chainColor);
  }
  
}

void mousePressed() {
  // Ignore anything greater than this distance
  float closest = 20;
  
  for (int i = 0; i < nodeCount; i++) {
    Node n = nodes[i];
    float d = dist(mouseX, mouseY, n.x, n.y);
    if (d < closest) {
      //
      selection = n;
      closest = d;
    }
  }
  
  if (selection != null){
    // && !selection.label.equals(nodoAttivo.label)
    
    String aa = selection.label;
    String bb;
    if (nodoAttivo != null){
       bb = nodoAttivo.label;
    } else {
       bb = "";
    }
    
    if(! aa.equals(bb)){
    // e diverso
    // select this
    if (mouseButton == LEFT) {
       if (nodoAttivo != null) {
         exselection = nodoAttivo;
       }
       
      nodoAttivo = selection;
      nodoAttivo.fixed = true;
    
      // la catena
      findCatena(nodoAttivo.label);
      
      
    } else if (mouseButton == RIGHT) {
      //selection.fixed = false;
      
    }
    
    }
   }
}

void mouseDragged() {
  if (selection != null) {
    selection.x = mouseX;
    selection.y = mouseY;
  }
}

void mouseReleased() {
  selection = null;
}

void keyPressed(){
  if (key == 'r' || key == 'R') {
      relax_mode = !relax_mode;
    }
    
    
    if (key == 's' || key == 'S') {
      record = true;
    }
}
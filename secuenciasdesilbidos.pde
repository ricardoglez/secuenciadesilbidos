import processing.serial.*;
import ddf.minim.*;
int numObjetos = 12;
int cual ;
int distance;
Minim minim;
AudioSample[] sample = new AudioSample[numObjetos];
Serial myPort;
String comPortString;

void setup() {
  String filename = "DW0" ;
  String ext = ".mp3" ;
  String archivo;
  size(512, 200, P3D);
  minim = new Minim(this);
  for (int i = 0; i <= numObjetos-1; i++) {
    String n = str(i);
    archivo = filename + n + ext;
    sample[i] = minim.loadSample(archivo, 2048);
    if ( sample[i] == null ) {
      println("Didn't get any! on ", sample[i]);
    }
  }
  myPort = new Serial(this, "/dev/ttyACM0", 9600);
  myPort.bufferUntil('\n');
}

void draw() {
  background(0);
  // use the mix buffer to draw the waveforms.
  dWF(cual);
  activar();
}
void serialEvent(Serial cPort) {
  comPortString = cPort.readStringUntil('\n');

  comPortString=trim(comPortString);

  //println(comPortString);
  /*If computer receives a negative number (-1), then the
   sensor is reporting an "out of range" error. Convert all
   of these to a distance of 0. */
}

void activar() {
  distance = int(comPortString);

    int distanceP = distance;
  if (distance >= 0){
    if (distanceP == distance ){
    sample[distance].trigger(); 
    println(sample[distance].getVolume() );
    println(distance, distanceP);
  }
}
}

void dWF(int cu) {
  for (int i = 0; i < sample[cu].bufferSize()- 1; i++)
  {
    line(i, 50  + sample[cu].left.get(i)*50, i+1, 50  + sample[cu].left.get(i+1)*50);
    line(i, 150 + sample[cu].right.get(i)*50, i+1, 150 + sample[cu].right.get(i+1)*50);
  }
}
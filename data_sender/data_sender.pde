import processing.serial.*;
import http.requests.*;

Serial myPort;
int Humi;
int Temp;
int Tol;

void setup() 
{
  size(200, 200);
  background(255);
  ellipse(56, 46, 55, 55);
  myPort = new Serial(this, "COM3", 9600);
  myPort.clear();
  delay(15000);
}


void draw(){
  background(255); 
  fill(255,0,0);//r
  ellipse(56, 46, 55, 55);
  myPort.write('A');
  delay(5000);
  if(myPort.available()>0){
    Humi=myPort.read();
  }
  myPort.clear();
  myPort.write('B');
  delay(5000);
  if(myPort.available()>0){
    Temp=myPort.read();
  }
  myPort.clear();
  myPort.write('C');
  delay(5000);
  if(myPort.available()>0){
    Tol=myPort.read();
  }
  myPort.clear();
  
  background(255); 
  fill(0,255,0);//g
  ellipse(56, 46, 55, 55);
  PostRequest post = new PostRequest("https://api.thingspeak.com/update.json");
  post.addData("api_key", "RK3S8OH68Q728NON");
  post.addData("field1", String.valueOf(Temp));
  post.addData("field2", String.valueOf(Humi));
  post.send();
  
  background(255); 
  fill(0,0,255);//b
  ellipse(56, 46, 55, 55);
  for(int i=0;i<15;i++){
    for(int k=0;k<60;k++){
      delay(1000);
    }
  }
}
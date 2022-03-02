class Particle{
 PVector pos;
 PVector vel;
 PVector acc;
 float r = 10;
 float maxAcc = 1;
 float maxVel = 8;
 float perception = 50;
 float s = 0.1;
 float a = 0;
 float c = 0.2;
 
 Particle(){
   pos = new PVector(0,0);
   vel = new PVector(0,0);
   acc = new PVector(0,0);
 }
  
 Particle(float xx, float yy){
   pos = new PVector(xx,yy);
   vel = new PVector(random(-1,1),random(-1,1));
   acc = new PVector(0,0);
 }
 
 void show(boolean debug){
  fill(255);
  noStroke();
  ellipse(pos.x, pos.y, r, r);
  if (debug){
    noFill();
    stroke(255,0,0);
    ellipse(pos.x, pos.y, perception, perception);
  }
 }
 
 void show(){
  fill(255);
  noStroke();
  ellipse(pos.x, pos.y, r, r);
 }
 
 void update(){
  pos.add(vel);
  vel.add(acc);
  acc.mult(0);
  vel.mult(0.99);
  vel.limit(maxVel);
 }
 
 void applyForce(PVector f){
   acc.add(f);
   acc.limit(maxAcc);
 }
 
 void repel(PVector other){
  float d = dist(pos.x, pos.y, other.x, other.y);
  
  if (d <= 200){
   PVector f = PVector.sub(pos, other);
   f.normalize();
   applyForce(f);
  }
 }
 
 void separation(Particle[] particles){
   PVector avg = new PVector();
   int num = 0;
   for (int i = 0; i < particles.length; i++){
     Particle p = particles[i];
     if (dist(pos.x, pos.y, p.pos.x, p.pos.y) <= perception){
       num++;
       avg.add(p.pos);
     }
   }
   avg.div(num);
   avg.setMag(s);
   applyForce(avg);
 }
 
 void align(Particle[] particles){
  PVector sum = new PVector();
  int num = 0;
   for (int i = 0; i < particles.length; i++){
   Particle p = particles[i];
   float d = dist(pos.x, pos.y, p.pos.x, p.pos.y);
   if (d <= perception){
     num++;
     sum.add(p.vel);
   }
  }
  PVector avg = sum.div(num);
  avg.normalize();
  avg.setMag(a);
  applyForce(avg);
 }
 
 void cohesion(Particle[] particles){
  PVector avg = new PVector();
  float num = 0; 
  for (int i = 0; i < particles.length; i++){
   Particle p = particles[i];
   float d = dist(pos.x, pos.y, p.pos.x, p.pos.y);
   if (d <= perception){
     num++;
     avg.add(p.pos);
   }
  }
  avg.div(num);
  PVector force = PVector.sub(pos, avg);
  force.normalize();
  force.setMag(c);
  applyForce(force);
 }
 
 void wrap(){
  if (pos.x < -r){
    pos.x = width+r;
  } else if (pos.x > width+r){
    pos.x = -r;
  }
  
  if (pos.y < -r){
    pos.y = height+r;
  } else if (pos.y > height+r){
    pos.y = -r;
  }
 }
}

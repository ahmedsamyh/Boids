Particle[] particles = new Particle[200];
void setup(){
  size(1200, 800);
  for (int i = 0; i < particles.length; i++){
    particles[i] = new Particle(random(width), random(height));
  }
}


void draw(){
 background(0);
 PVector m = new PVector(mouseX, mouseY);
 for(int i = 0; i < particles.length; i++){
  Particle p = particles[i];
  p.show();
  p.update();
  p.wrap();
  p.align(particles);
  p.separation(particles);
  p.cohesion(particles);
  p.repel(m);
 }
}

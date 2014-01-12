ArrayList<toxi.physics2d.VerletParticle2D> particles = new ArrayList<toxi.physics2d.VerletParticle2D>();
float len = ($(window).height() / 160);
float strength = 1.2;
float numParticles = 50;
toxi.physics2d.VerletPhysics2D physics;
boolean beingDragged = false;
toxi.physics2d.VerletParticle2D head;
toxi.physics2d.VerletParticle2D tail;
toxi.physics2d.VerletParticle2D secondFromTail;

void setup() {
    smooth(8);
    onResize();

    console.log(toxi);

    physics = new toxi.physics2d.VerletPhysics2D();
    physics.addBehavior(new toxi.physics2d.behaviors.GravityBehavior(new toxi.geom.Vec2D(0, -7)));
    physics.setWorldBounds(new toxi.geom.Rect(0,0,width,height));

    for(int i = 0; i < numParticles; i++) {
        toxi.physics2d.VerletParticle2D particle = new toxi.physics2d.VerletParticle2D(($(window).width() / 2) + (i * len), $(window).height());
        physics.addParticle(particle);
        particles.add(particle);

        if (i != 0) {
            // First we need a reference to the previous particle.
            toxi.physics2d.VerletParticle2D previous = particles.get(i - 1);

            //[offset-down] Then we make a spring connection between the particle and the previous particle with a rest length and strength (both floats).
            toxi.physics2d.VerletSpring2D spring = new toxi.physics2d.VerletSpring2D(particle,previous,len,strength);

            // We must not forget to add the spring to the physics world.
            physics.addSpring(spring);
        }
    }

    head = particles.get(0);
    head.lock();

    tail = particles.get(numParticles - 1);
    console.log(tail);

    secondFromTail = particles.get(numParticles - 2);
    console.log(secondFromTail);
}

void mouseMoved() {

}

void mouseDragged() {
    if(MouseUtils.hitTest(tail.x, tail.y, 150, 150)) {
        beingDragged = true;
    }
}

void mousePressed() {
    if(MouseUtils.hitTest(tail.x, tail.y, 150, 150)) {
        beingDragged = true;
    }
}

void mouseReleased() {
    beingDragged = false;
}

void draw() {
    background(255, 255, 255);
    physics.update();

    strokeWeight(3);
    if (beingDragged) {
        secondFromTail.x = mouseX;
        secondFromTail.y = mouseY;
    }

    stroke(255, 32, 40);
    fill(255, 255, 255);
    beginShape();
    for (int i = 0; i < particles.size(); i++) {
        if (beingDragged) {
            if (i < particles.size() - 2) {
                vertex(particles.get(i).x, particles.get(i).y);
            }
        } else {
            vertex(particles.get(i).x, particles.get(i).y);
        }

    }

    endShape();


    stroke(0);
    ellipse(tail.x, tail.y, 150, 150);
}

void onResize() {
    size($(window).width(), $(window).height(), P2D);
}
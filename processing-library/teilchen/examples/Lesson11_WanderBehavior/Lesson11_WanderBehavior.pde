import teilchen.*; 
import teilchen.behavior.*; 
import teilchen.constraint.*; 
import teilchen.cubicle.*; 
import teilchen.force.*; 
import teilchen.integration.*; 
import teilchen.util.*; 
/*
 * this sketch demonstrates how to use behaviors.  it combines `Wander` and `Motor` behaviors
 * to turn a `BehaviorParticle` into an autonomously moving *agent*.
 */

Physics mPhysics;

BehaviorParticle mParticle;

Wander mWander;

Motor mMotor;

void settings() {
    size(640, 480);
}

void setup() {
    /* physics */
    mPhysics = new Physics();
    mPhysics.add(new ViscousDrag());
    /* create particles */
    mParticle = mPhysics.makeParticle(BehaviorParticle.class);
    mParticle.position().set(width / 2.0f, height / 2.0f);
    mParticle.maximumInnerForce(100);
    mParticle.radius(10);
    /* create behavior */
    mWander = new Wander();
    mParticle.behaviors().add(mWander);
    /* a motor is required to push the particle forward - wander manipulates the direction the particle is pushed
     in */
    mMotor = new Motor();
    mMotor.auto_update_direction(true);
    /* the direction the motor pushes into is each step automatically set to the velocity */
    mMotor.strength(25);
    mParticle.behaviors().add(mMotor);
}

void draw() {
    /* update particle system */
    mPhysics.step(1.0f / frameRate);
    /* draw behavior particle */
    background(255);
    stroke(0, 127);
    line(mParticle.position().x,
         mParticle.position().y,
         mParticle.position().x + mParticle.velocity().x,
         mParticle.position().y + mParticle.velocity().y);
    fill(0);
    noStroke();
    ellipse(mParticle.position().x, mParticle.position().y,
            mParticle.radius() * 2, mParticle.radius() * 2);
}

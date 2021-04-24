package me.samhubbard.ld48;

import nape.shape.Polygon;
import me.samhubbard.game.Entity;
import nape.geom.Vec2;
import h2d.Graphics;

class BallEntity extends Entity {

    private var velocity: Vec2;

    public function new(x: Float, y: Float, speed: Float) {
        super(x, y, function(scene) {
            var graphics = new Graphics(scene);
            graphics.beginFill(0xffffff);
            graphics.drawRect(-10.0, -10.0, 20.0, 20.0);
            graphics.endFill();
            return graphics;
        });
        velocity = Vec2.fromPolar(speed, Math.random() * Math.PI);
        body.shapes.add(new Polygon(Polygon.box(20.0, 20.0)));
    }

	private function onAdd() {}

    private function update(dt: Float) {
        body.position = body.position.addMul(velocity, dt);
    }

	private function onRemove() {}
}

package me.samhubbard.ld48;

import nape.phys.BodyType;
import me.samhubbard.game.Entity;
import nape.shape.Polygon;
import h2d.Graphics;
import hxd.Key;

class PaddleEntity extends Entity {

    private var width: Float;

    private var speed: Float;

    public function new(x: Float, y: Float, width: Float, speed: Float) {
        super(x, y, function(scene) {
            var graphics = new Graphics(scene);
            graphics.beginFill(0xffffff);
            graphics.drawRect(-width / 2, 0, width, 20);
            graphics.endFill();
            return graphics;
        }, BodyType.DYNAMIC);
        this.width = width;
        this.speed = speed;
        body.shapes.add(new Polygon(Polygon.rect(-width / 2, 0, width, 20)));
    }

	private function onAdd() {}

    private function update(dt: Float) {
        if (Key.isDown(Key.LEFT)) {
            body.position.x -= speed * dt;
            body.position.x = Math.max(body.position.x, width / 2);
        }

        if (Key.isDown(Key.RIGHT)) {
            body.position.x += speed * dt;
            body.position.x = Math.min(body.position.x, BreakinGame.WIDTH - width / 2);
        }
    }

	private function onRemove() {}
}

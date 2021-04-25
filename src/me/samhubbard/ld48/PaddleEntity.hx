package me.samhubbard.ld48;

import nape.phys.BodyType;
import me.samhubbard.game.Entity;
import nape.shape.Polygon;
import h2d.Graphics;
import hxd.Key;

class PaddleEntity extends Entity {

	public var momentum(default, null): Float;

    private var width: Float;

    private var speed: Float;

    public function new(x: Float, y: Float, width: Float, speed: Float) {
        super(x, y, (scene) -> {
            var graphics = new Graphics(scene);
            graphics.beginFill(0xffffff);
            graphics.drawRect(-width / 2, -20, width, 20);
            graphics.endFill();
            return graphics;
        }, BodyType.KINEMATIC, EntityType.PADDLE);
        this.width = width;
        this.speed = speed;

        // Create the collider
        var shape = new Polygon(Polygon.rect(-width / 2, -20, width, 20));
        shape.material = Settings.MATERIAL_BOUNCY;
        body.shapes.add(shape);
    }

	private function onAdd() {}

    private function update(dt: Float) {
        var left = Key.isDown(Key.LEFT);
        var right = Key.isDown(Key.RIGHT);
        
        if (left != right) {
            body.velocity.x = (left) ? -speed : speed;
            momentum += ((left) ? -dt : dt) * Settings.PADDLE_MOMENTUM_RATE;
            momentum = Math.min(Math.max(-Settings.PADDLE_MAX_MOMENTUM, momentum), Settings.PADDLE_MAX_MOMENTUM);
        } else {
            body.velocity.x = 0;
            momentum = 0;
        }

        body.position.x = Math.min(Math.max(width / 2, body.position.x), Settings.WIDTH - width / 2);
    }

	private function onRemove() {}

	function get_momentum():Float {
		throw new haxe.exceptions.NotImplementedException();
	}
}

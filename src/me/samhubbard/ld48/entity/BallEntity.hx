package me.samhubbard.ld48.entity;

import hxd.Key;
import nape.callbacks.CbEvent;
import nape.callbacks.CbType;
import nape.phys.BodyType;
import nape.shape.Polygon;
import me.samhubbard.game.Entity;
import nape.geom.Vec2;
import h2d.Graphics;

class BallEntity extends Entity {

    private var initSpeed: Float;

    private var minSpeed: Float;

    private var maxSpeed: Float;

    public function new(x: Float, y: Float, speed: Float) {
        super(x, y, (scene) -> {
            var graphics = new Graphics(scene);
            graphics.beginFill(0xffffff);
            graphics.drawRect(-10, -10, 20, 20);
            graphics.endFill();
            return graphics;
        }, BodyType.DYNAMIC, EntityType.BALL);

        initSpeed = speed;
        minSpeed = Settings.BALL_MIN_SPEED;
        maxSpeed = Settings.BALL_MAX_SPEED;

        // Create the collider
        var shape = new Polygon(Polygon.box(20, 20));
        shape.material = Settings.MATERIAL_BOUNCY;
        body.shapes.add(shape);
        reset(x, y);
    }

    private function calcNormal(): Vec2 {
        if (body.velocity.length > 0) {
            return body.velocity.copy().normalise();
        }
        return Vec2.get(0, 0);
    }

	public function reset(x: Float, y: Float) {
        var angle = Math.PI * (0.5 + 0.4 * (Math.random() - 0.5));
        body.position.setxy(x, y);
        body.velocity = Vec2.fromPolar(initSpeed, angle);
    }

	private function onAdd() {
        registerCollisionCallback(CbEvent.BEGIN, EntityType.PADDLE, (paddle) -> {
            if (Key.isDown(Key.SPACE)) {
                weldTo(paddle);
            }
        });
        registerCollisionCallback(CbEvent.END, EntityType.PADDLE, (paddle) -> {
            body.velocity.x += cast(paddle, PaddleEntity).momentum;
            body.position.y += 2;
        });
        registerCollisionCallback(CbEvent.END, CbType.ANY_BODY.excluding(EntityType.PADDLE), (other) -> {
            var normal = calcNormal();
            if (Math.abs(normal.y) < 0.5) {
                var xSign = Std.int(normal.x / Math.abs(normal.x));
                var ySign = Std.int(normal.y / Math.abs(normal.y));
                var direction = (xSign == ySign) ? 1 : -1;
                body.velocity = body.velocity.rotate(direction * Settings.BALL_RESET_RATE);
            }
        });
        registerCollisionCallback(CbEvent.END, EntityType.BLOCK, (block) -> {
            cast(block, BlockEntity).destroy();
        });
    }

    private function motion(dt: Float) {
        var normal = calcNormal();

        if (body.velocity.length < Settings.BALL_MIN_SPEED) {
            body.velocity = normal.mul(Settings.BALL_MIN_SPEED);
        }

        if (body.velocity.length > Settings.BALL_MAX_SPEED) {
            body.velocity = normal.mul(Settings.BALL_MAX_SPEED);
        }
    }

    private function update(dt: Float) {
        if (welded) {
            if (!Key.isDown(Key.SPACE)) {
                var paddle = weldee;
                if (unweld()) {
                    body.velocity = Vec2.get(paddle.body.velocity.x, maxSpeed * 0.75);
                    motion(dt);
                }
            }
        } else {
            motion(dt);
        }
    }

	private function onRemove() {}
}

package me.samhubbard.ld48.entity;

import me.samhubbard.ld48.act.PlayAct;
import nape.geom.Vec2;
import nape.callbacks.CbEvent;
import polygonal.ds.ListSet;
import nape.phys.BodyType;
import me.samhubbard.game.Entity;
import nape.shape.Polygon;
import h2d.Graphics;
import hxd.Key;

class PaddleEntity extends Entity {

	public var momentum(default, null): Float;

    private var width: Float;

    private var speed: Float;

    private var ballsOnMagnet: ListSet<BallEntity>;

    private var isMagnet(get, never): Bool;

    private var graphics: Graphics;

    public function new(x: Float, y: Float, width: Float, speed: Float) {
        super(x, y, (scene) -> {
            graphics = new Graphics(scene);
            redraw();
            return graphics;
        }, BodyType.KINEMATIC, EntityType.PADDLE);

        this.width = width;
        this.speed = speed;
        ballsOnMagnet = new ListSet<BallEntity>();

        // Create the collider
        var shape = new Polygon(Polygon.rect(-width / 2, -20, width, 20));
        shape.material = Settings.MATERIAL_BOUNCY;
        body.shapes.add(shape);
    }

	private function onAdd() {
        registerCollisionCallback(CbEvent.BEGIN, EntityType.BALL, (ball) -> {
            if (Key.isDown(Key.SPACE)) {
                addBallToMagnet(cast(ball, BallEntity));
                weldTo(ball);
            }
        });
    }

    private function redraw() {
        var height = 20 - Math.abs(10 * momentum / Settings.PADDLE_MAX_MOMENTUM);
        if (graphics != null) {
            graphics.clear();
            graphics.beginFill((isMagnet) ? Colour.MAGNET : Colour.PADDLE);
            graphics.drawRect(-width / 2, -height * 2 / 3, width, height);
            graphics.endFill();
        }
    }

    private function addBallToMagnet(ball: BallEntity) {
        ball.weldTo(this);
        ballsOnMagnet.set(ball);
    }

    private function releaseMagnet() {
        for (ball in ballsOnMagnet) {
            ball.unweld();
            ball.body.velocity = Vec2.get(body.velocity.x, Settings.BALL_MAX_SPEED * 0.75);
        }
        ballsOnMagnet.clear();
    }

    private function update(dt: Float) {
        var playAct = cast(act, PlayAct);

        if (isMagnet) {
            if (!Key.isDown(Key.SPACE)) {
                releaseMagnet();
            } else {
                var canMagnet = playAct.takeMagnet(Settings.PADDLE_MAGNET_RATE * dt);
                if (!canMagnet) {
                    releaseMagnet();
                }
            }
        } else {
            playAct.refillMagnet(Settings.PADDLE_MAGNET_REFILL_RATE * dt);
        }

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

        body.position.x = Math.min(Math.max(width / 2, body.position.x), Settings.PLAY_WIDTH - width / 2);

        redraw();
    }

	private function onRemove() {}

	function get_isMagnet():Bool {
		return ballsOnMagnet.size > 0;
	}
}

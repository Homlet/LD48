package me.samhubbard.ld48.entity;

import me.samhubbard.ld48.state.PlayState;
import h2d.Graphics;
import h2d.Object;
import hxd.res.DefaultFont;
import h2d.Text;
import nape.phys.BodyType;
import me.samhubbard.game.Entity;

class HUDEntity extends Entity {

    private var width: Float;

    private var state: PlayState;

    private var score: Text;

    private var magnet: Graphics;

    private var balls: Graphics;

    public function new(x: Float, y: Float, width: Float, state: PlayState) {
        super(x, y, (scene) -> {
            var root = new Object(scene);
            var font = DefaultFont.get();
            score = new Text(font, root);
            score.x = 5;
            score.y = 2;
            score.scale(1.5);
            drawScore();
            magnet = new Graphics(root);
            drawMagnet();
            balls = new Graphics(root);
            drawBalls();
            return root;
        }, BodyType.STATIC);

        this.width = width;
        this.state = state;
    }

    private function drawScore() {
        score.text = '${state.score}';
    }

    private function drawMagnet() {
        magnet.clear();
        magnet.beginFill((state.magnetCooldown) ? Colour.MAGNET_COOLDOWN : Colour.MAGNET);
        magnet.drawRect(0, 30, width / 2, Settings.HUD_MAGNET_HEIGHT * state.magnet / 100);
        magnet.endFill();
    }

    private function drawBalls() {
        balls.clear();
        balls.beginFill(Colour.BALL_MAIN);
        var b = 0;
        while (b < state.ballsLeft) {
            balls.drawRect(width / 2 + 10, 30 + 30 * b, 20, 20);
            b++;
        }
        balls.endFill();
    }

	private function onAdd() {}

    private function update(dt: Float) {
        if (score != null) {
            drawScore();
        }

        if (magnet != null) {
            drawMagnet();
        }

        if (balls != null) {
            drawBalls();
        }
    }

	private function onRemove() {}
}

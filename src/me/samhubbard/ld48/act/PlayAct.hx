package me.samhubbard.ld48.act;

import me.samhubbard.ld48.state.PlayState;
import me.samhubbard.ld48.entity.PlayAreaSensorEntity;
import me.samhubbard.ld48.entity.BlockEntity;
import me.samhubbard.ld48.entity.BoundaryEntity;
import me.samhubbard.ld48.entity.FailSensorEntity;
import me.samhubbard.ld48.entity.BallEntity;
import me.samhubbard.ld48.entity.PaddleEntity;
import me.samhubbard.game.Act;

class PlayAct extends Act {

    private var state: PlayState;

    private var paddle: PaddleEntity;

    public function init() {
        state = new PlayState(3);

        paddle = new PaddleEntity(Settings.WIDTH / 2, 50, 100, Settings.PADDLE_SPEED);
        add(paddle);

        add(new BallEntity(Settings.WIDTH / 2, 100, 200, true));
        add(new BallEntity(Settings.WIDTH / 2 - 40, 100, 200, false));
        add(new BallEntity(Settings.WIDTH / 2 + 40, 100, 200, false));

        add(new FailSensorEntity(0, -50, Settings.WIDTH, 50));
        add(new PlayAreaSensorEntity(-80, -80, Settings.WIDTH + 160, Settings.HEIGHT + 160));
        add(new BoundaryEntity(0, 0, 20, Settings.HEIGHT));
        add(new BoundaryEntity(Settings.WIDTH - 20, 0, 20, Settings.HEIGHT));
        add(new BoundaryEntity(0, Settings.HEIGHT, Settings.WIDTH, 20));

        var x = 60;
        while (x <= Settings.WIDTH - 60) {
            var y = Settings.HEIGHT - 20;
            while (y > Settings.HEIGHT / 2) {
                add(new BlockEntity(x, y));
                y -= 40;
            }
            x += 40;
        }
    }

	public function update(dt: Float) {}

    public function resetBall(ball: BallEntity) {
        ball.reset(paddle.body.position.x, paddle.body.position.y + 30);
    }

    public function lostBall(ball: BallEntity) {
        if (ball.isMain) {
            if (state.ballsLeft > 0) {
                trace(state.ballsLeft);
                state.ballsLeft--;
                resetBall(ball);
            } else {
                fail();
            }
        } else {
            remove(ball);
        }
    }

    public function fail() {
        trace("FAIL");
    }
}

package me.samhubbard.ld48;

import me.samhubbard.game.Act;

class PlayAct extends Act {

    private var paddle: PaddleEntity;

    private var ball: BallEntity;

    public function init() {
        paddle = new PaddleEntity(Settings.WIDTH / 2, 50, 100, Settings.PADDLE_SPEED);
        add(paddle);

        add(new BallEntity(Settings.WIDTH / 2, 100, 200));

        add(new FailSensorEntity(0, -50, Settings.WIDTH, 50));
        add(new BoundaryEntity(0, 0, 20, Settings.HEIGHT));
        add(new BoundaryEntity(Settings.WIDTH - 20, 0, 20, Settings.HEIGHT));
        add(new BoundaryEntity(0, Settings.HEIGHT, Settings.WIDTH, 20));

        var x = 50;
        while (x < Settings.WIDTH - 50) {
            var y = Settings.HEIGHT - 40;
            while (y > Settings.HEIGHT / 2) {
                add(new BlockEntity(x, y));
                y -= 30;
            }
            x += 40;
        }
    }

	public function update(dt: Float) {}

    public function resetBall(ball: BallEntity) {
        ball.reset(paddle.body.position.x, paddle.body.position.y + 30);
    }
}

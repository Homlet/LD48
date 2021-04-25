package me.samhubbard.ld48.act;

import me.samhubbard.ld48.entity.HUDEntity;
import me.samhubbard.ld48.entity.WaveSpawnAreaEntity;
import me.samhubbard.ld48.entitygroup.StandardBlockWave;
import polygonal.ds.ArrayList;
import me.samhubbard.ld48.state.PlayState;
import me.samhubbard.ld48.entity.PlayAreaSensorEntity;
import me.samhubbard.ld48.entity.BlockEntity;
import me.samhubbard.ld48.entity.BoundaryEntity;
import me.samhubbard.ld48.entity.FailSensorEntity;
import me.samhubbard.ld48.entity.BallEntity;
import me.samhubbard.ld48.entity.PaddleEntity;
import me.samhubbard.ld48.entitygroup.BlockWave;
import me.samhubbard.game.Act;

class PlayAct extends Act {

    private var state: PlayState;

    private var paddle: PaddleEntity;

    private var activeWaves: ArrayList<BlockWave>;

    public function init(userData: Dynamic) {
        state = new PlayState(3);

        paddle = new PaddleEntity(Settings.PLAY_WIDTH / 2, Settings.PADDLE_WIDTH, 100, Settings.PADDLE_SPEED);
        add(paddle);

        add(new BallEntity(Settings.PLAY_WIDTH / 2, 100, 200, true));

        add(new FailSensorEntity(0, -50, Settings.PLAY_WIDTH, 50));
        add(new PlayAreaSensorEntity(0, -80, Settings.PLAY_WIDTH, Settings.HEIGHT + 100));
        add(new WaveSpawnAreaEntity(0, Settings.HEIGHT, Settings.PLAY_WIDTH, 30));
        add(new HUDEntity(Settings.PLAY_WIDTH, 0, Settings.WIDTH - Settings.PLAY_WIDTH, state));

        add(new BoundaryEntity(0, 0, 20, Settings.HEIGHT));
        add(new BoundaryEntity(Settings.PLAY_WIDTH - 20, 0, 20, Settings.HEIGHT));
        add(new BoundaryEntity(0, Settings.HEIGHT, Settings.PLAY_WIDTH, 20));
    }

    public function update(dt: Float) {}

    public function extraBall() {
        state.ballsLeft++;
    }

    public function resetBall(ball: BallEntity) {
        ball.reset(paddle.body.position.x, paddle.body.position.y + 30);
    }

    public function lostBall(ball: BallEntity) {
        if (ball.isMain) {
            if (state.ballsLeft > 0) {
                state.ballsLeft--;
                resetBall(ball);
            } else {
                fail();
            }
        } else {
            remove(ball);
        }
    }

    public function addScore(value: Int) {
        state.score += value;
    }

    public function takeMagnet(amount: Float): Bool {
        if (state.magnetCooldown) {
            return false;
        }

        if (state.magnet > 0) {
            state.magnet = Math.max(0, state.magnet - amount);
            if (state.magnet == 0) {
                state.magnetCooldown = true;
            }

            return true;
        }

        return false;
    }

    public function refillMagnet(amount: Float) {
        if (state.magnet < 100) {
            state.magnet = Math.min(state.magnet + amount, 100);
        }

        if (state.magnet > 20) {
            state.magnetCooldown = false;
        }
    }

    public function fail() {
        game.setAct(GameOverAct, state);
    }
}

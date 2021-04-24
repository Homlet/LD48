package me.samhubbard.ld48;

import me.samhubbard.game.Act;

class PlayAct extends Act {

    public function init() {
        add(new PaddleEntity(BreakinGame.WIDTH / 2, 50, 100, 400));
        add(new BallEntity(100.0, 100.0, 100.0));
    }
}

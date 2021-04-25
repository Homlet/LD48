package me.samhubbard.ld48.act;

import hxd.Key;
import me.samhubbard.ld48.entity.GameOverEntity;
import me.samhubbard.ld48.entity.HUDEntity;
import me.samhubbard.ld48.state.PlayState;
import me.samhubbard.ld48.entity.BoundaryEntity;
import me.samhubbard.game.Act;

class GameOverAct extends Act {

    private var state: PlayState;

    public function init(userData: Dynamic) {
        state = cast(userData, PlayState);

        add(new HUDEntity(Settings.PLAY_WIDTH, 0, Settings.WIDTH - Settings.PLAY_WIDTH, state));

        add(new BoundaryEntity(0, 0, 20, Settings.HEIGHT));
        add(new BoundaryEntity(Settings.PLAY_WIDTH - 20, 0, 20, Settings.HEIGHT));

        add(new GameOverEntity(Settings.PLAY_WIDTH / 2, Settings.HEIGHT / 2, state));
    }

	public function update(dt: Float) {
        if (Key.isPressed(Key.SPACE)) {
            restart();
        }
    }

    public function restart() {
        game.setAct(PlayAct);
    }
}

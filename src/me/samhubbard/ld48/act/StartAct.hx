package me.samhubbard.ld48.act;

import me.samhubbard.ld48.entity.StartEntity;
import hxd.Key;
import me.samhubbard.ld48.state.PlayState;
import me.samhubbard.ld48.entity.BoundaryEntity;
import me.samhubbard.game.Act;

class StartAct extends Act {

    private var state: PlayState;

    public function init(userData: Dynamic) {
        state = cast(userData, PlayState);

        add(new BoundaryEntity(0, 0, 20, Settings.HEIGHT));
        add(new BoundaryEntity(Settings.PLAY_WIDTH - 20, 0, 20, Settings.HEIGHT));

        add(new StartEntity(Settings.PLAY_WIDTH / 2, Settings.HEIGHT / 2, state));
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

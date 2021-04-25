package me.samhubbard.ld48;

import me.samhubbard.ld48.act.PlayAct;
import me.samhubbard.game.Game;

class BreakinGame extends Game {

    public function new() {
        super(Settings.WIDTH, Settings.HEIGHT);
    }

    override function init() {
        setAct(PlayAct);
    }
}

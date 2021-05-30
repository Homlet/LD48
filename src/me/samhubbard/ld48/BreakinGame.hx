package me.samhubbard.ld48;

import hxd.Res;
import me.samhubbard.ld48.act.StartAct;
import me.samhubbard.game.Game;

class BreakinGame extends Game {

    public function new() {
        super(Settings.WIDTH, Settings.HEIGHT);
    }

    override function init() {
        Res.initEmbed();

        setAct(StartAct);
    }
}

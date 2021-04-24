package me.samhubbard.ld48;

import me.samhubbard.game.Game;

class BreakinGame extends Game {
    public static final WIDTH: Int = 640;

    public static final HEIGHT: Int = 480;

    public function new() {
        super(WIDTH, HEIGHT);
    }

    override function init() {
        setAct(PlayAct);
    }
}

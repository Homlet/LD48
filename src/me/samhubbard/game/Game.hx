package me.samhubbard.game;

import hxd.App;

abstract class Game extends App {

    private var act: Act;

    public final width: Int;

    public final height: Int;

    public function new(width: Int, height: Int) {
        super();
        this.width = width;
        this.height = height;
    }

    public function setAct(act: Class<Act>) {
        this.act = Type.createInstance(act, [width, height]);
        this.act.init();
        this.setScene2D(this.act.scene, false);
    }

    override function update(dt: Float) {
        act.notifyUpdate(dt);
    }
}

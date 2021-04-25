package me.samhubbard.game;

import h2d.Scene;
import polygonal.ds.Hashable;

interface Actor extends Hashable {

    @:allow(me.samhubbard.game.Act)
    private function notifyAdded(act: Act, scene: Scene): Void;

    @:allow(me.samhubbard.game.Act)
    private function notifyUpdate(dt: Float): Void;

    @:allow(me.samhubbard.game.Act)
    private function notifyRemoved(): Void;
}

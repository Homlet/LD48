package me.samhubbard.ld48.entity;

import h2d.Object;
import h2d.Scene;
import nape.phys.BodyType;
import me.samhubbard.game.Entity;

abstract class Destroyable extends Entity {

    private var destroyed: Bool;

    private function new(x: Float, y: Float, drawableFactory: Scene -> Object) {
        super(x, y, drawableFactory, BodyType.KINEMATIC, EntityType.BLOCK);

        destroyed = false;
    }

    public function destroy() {
        if (destroyed) {
            return;
        }

        onDestroy();
        destroyed = true;
    }

    public abstract function onDestroy(): Void;
}

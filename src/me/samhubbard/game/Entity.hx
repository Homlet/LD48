package me.samhubbard.game;

import nape.phys.Body;
import nape.phys.BodyType;
import polygonal.ds.Hashable;
import polygonal.ds.HashKey;
import h2d.Drawable;
import h2d.Scene;

abstract class Entity implements Hashable {

    public final key: Int;

    // TODO: better solution
    private final drawableFactory: Scene -> Drawable;

    private final body: Body;

    private var drawable: Drawable;

    private var act: Act;

	private function new(x: Float, y: Float, drawableFactory: Scene -> Drawable, bodyType: BodyType=null) {
        key = HashKey.next();
        body = new Body(bodyType);
        body.position.setxy(x, y);
        this.drawableFactory = drawableFactory;
	}

    @:allow(me.samhubbard.game.Act)
    private function notifyAdded(act: Act, scene: Scene) {
        this.act = act;
        drawable = drawableFactory(scene);
        body.space = act.space;
        onAdd();
    }

    @:allow(me.samhubbard.game.Act)
    private function notifyUpdate(dt: Float) {
        update(dt);
        drawable.setPosition(body.position.x, body.position.y);
    }
    
    @:allow(me.samhubbard.game.Act)
    private function notifyRemoved() {
        act = null;
        drawable.remove();
        drawable = null;
        body.space = null;
        onRemove();
    }

    private abstract function onAdd(): Void;

    private abstract function update(dt: Float): Void;

    private abstract function onRemove(): Void;
}

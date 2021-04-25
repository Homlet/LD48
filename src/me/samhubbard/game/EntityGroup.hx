package me.samhubbard.game;

import polygonal.ds.HashSet;
import polygonal.ds.ArrayList;
import polygonal.ds.HashKey;
import h2d.Scene;

abstract class EntityGroup implements Actor {

    private static inline final ENTITY_SET_SLOT_COUNT = 512;

    public final key: Int;

    private final entities: HashSet<Entity>;

    private var act: Act;

    private var scene: Scene;

    private var added: Bool;

	public function new() {
        key = HashKey.next();
        entities = new HashSet<Entity>(ENTITY_SET_SLOT_COUNT);
        added = false;
	}

    private function add(entity: Entity) {
        entities.set(entity);

        entity.notifyAddedToGroup(this);

        if (act != null || scene != null) {
            entity.notifyAdded(act, scene);
        }
    }

    private function addAll<T:Entity>(entities: ArrayList<T>) {
        for (entity in entities) {
            add(entity);
        }
    }

    public function remove(entity: Entity): Bool {
        if (!added) {
            return false;
        }

        if (!entities.has(entity)) {
            return false;
        }

        entities.remove(entity);
        entity.notifyRemoved();
        entity.notifyRemoveFromGroup();

        return true;
    }

    public function removeAll(): Bool {
        if (!added) {
            return false;
        }

        for (entity in entities) {
            entity.notifyRemoved();
            entity.notifyRemoveFromGroup();
        }

        entities.clear();

        return true;
    }

    @:allow(me.samhubbard.game.Act)
    private function notifyAdded(act: Act, scene: Scene) {
        this.act = act;
        this.scene = scene;

        onAdd();

        for (entity in entities) {
            entity.notifyAdded(act, scene);
        }

        added = true;
    }

    @:allow(me.samhubbard.game.Act)
    private function notifyUpdate(dt: Float) {
        update(dt);

        for (entity in entities) {
            entity.notifyUpdate(dt);
        }
    }

    @:allow(me.samhubbard.game.Act)
    private function notifyRemoved() {
        act = null;
        scene = null;
        added = false;

        for (entity in entities) {
            entity.notifyRemoved();
        }

        onRemove();
    }

    private abstract function onAdd(): Void;

    private abstract function update(dt: Float): Void;

    private abstract function onRemove(): Void;
}
